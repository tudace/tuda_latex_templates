#!/usr/bin/env texlua

--[[
	Build script for the TUDa-CI project
	Copyright (C) 2018–2025 Marei Peischl <tuda-ci@peitex.de>

	This file is part of the build system of the tuda-ci bundle.

	It may be distributed and/or modified under the conditions of the
	LaTeX Project Public License (LPPL), either version 1.3c of this
	license or (at your option) any later version. The latest version
	of this license is in the file

	https://www.latex-project.org/lppl.txt
]]

module="tuda-ci"

sourcefiledir="tex"
sourcefiles={"*.dtx", "*.ins","*.sty", "*.cls", "*.cfg", "*.clo", "*.def"}
installfiles={"*.sty", "*.cls", "*.cfg", "*.clo", "*.def"}
docfiledir="examples"
typesetfiles={"DEMO*.tex","tuda-ci.dtx"}
typesetcmds="\\def\\TUDaDefaultBuildOptions{accept-missing-logos}"

textfiles= {"README.md"}

flatten=false

typesetexe="lualatex"
typesetopts=""
unpackexe="pdflatex"

demofiles = {"examples/DEMO*.tex","DEMO*.tex"}
supportdir="examples"

typesetsuppfiles={ "*.bib", "*.lco"}
typesetdemofiles = demofiles

-- allow to tag the build.lua file by only excluding it for other targets
excludefiles={"*/Example-*.tex","Examples-*","*~"}
if not options["target"] == "tag" then
	excludefiles={table.unpack(excludefiles),"build.lua","config-*.lua"}
end

packageversion = "4.01"
packagedate = "2025-02-11"

tagfiles = {"*.sty", "*.cls", "*.cfg", "*.md", "*.clo", "*.tex", "*.lco", "*.def", "*.bib", "*.lua", "*.ins", "*.dtx"}

function get_dev_tag (oldtag)
	if string.match(oldtag, "%-dev$") then
		return (oldtag), true
	end
	newtag=string.gsub(oldtag,"v?(%d+).%d+%-?%w*%s?","%1.")..string.format("%02d",math.floor(string.gsub(oldtag,"v?%d+.(%d+)%-?%w*%s?","%1") + 1))
	return newtag.."-dev",false
end

--[[
  # Tagging configuration
]]

function update_tag(file, content, tagname, tagdate)
	local versionpattern = "%d+.%d+%-?%w*"
	local datepattern = "%d%d%d%d%-%d%d%-%d%d"
	local tag_only_changes = false
	local old_tagpattern = ""
	local tagname = tagname or packageversion
	if tagname == "dev" or string.match(tagname, "%-dev$") then
		tagname, tag_only_changes = get_dev_tag(packageversion)
	else
    -- when a new tag is set all \changes{<old-dev-tag>} should be replaced as well
		old_tagpattern = string.gsub(packageversion, "%.", "%%.")
		old_tagpattern = string.gsub(old_tagpattern, "%-", "%%-")
	end
	-- Copyright (C) 2018–2025 by uploadconfig["author"]>
	-- maybe change to -- instead of –
	content = string.gsub(content, "(Copyright %(C%) 20%d%d)%-*%d%d%d%d by " ..
							uploadconfig["author"], "%1--" .. os.date("%Y") ..
							" by " .. uploadconfig["author"])
	-- tagging \changes
	if file ~= "build.lua" then
		content = string.gsub(content, "\\changes{v?0*%.0*}{" .. datepattern,
							"\\changes{v" .. tagname .. "}{" .. tagdate)
		content = string.gsub(content, "\\changes{version}{date",
							"\\changes{v" .. tagname .. "}{" .. tagdate)
	end
	-- don't tag fileversion to not change all dates
	if tag_only_changes then return content end
--	if string.match(old_tagpattern, "-dev$") then
		content = string.gsub(content,
							"\\changes{v" .. old_tagpattern .. "}{" ..
								datepattern,
							"\\changes{v" .. tagname .. "}{" .. tagdate)
--	end
	content = string.gsub(content,
						"(tuda%-ci v)" .. versionpattern .. "%s%(" ..
							datepattern .. "%)",
						"%1" .. tagname .. " (" .. tagdate .. ")")
	content = string.gsub(content, "(version )" .. versionpattern .. "%s%(" ..
							datepattern .. "%)",
						"%1" .. tagname .. " (" .. tagdate .. ")")
	content = string.gsub(content, "\\def\\filedate{" .. datepattern .. "}",
						"\\def\\filedate{" .. tagdate .. "}")
	content = string.gsub(content,
						"\\def\\fileversion{" .. versionpattern .. "}",
						"\\def\\fileversion{" .. tagname .. "}")
	if string.match(file, "%.md$") or string.match(file, "%.tex$") then
		content = string.gsub(content,
							"(tuda%-ci v|version)" .. versionpattern .. "%s%(" ..
								datepattern .. "%)",
							"%1" .. tagname .. " (" .. tagdate .. ")")
	elseif file == "build.lua" then
		content = string.gsub(content,
							"(packageversion%s*=%s*\")" .. versionpattern,
							"%1" .. tagname)
		content = string.gsub(content, "(packagedate%s*=%s*\")" .. datepattern,
							"%1" .. tagdate)
	else
		content = string.gsub(content, "(\\Provides%a+{[^\n]+}\n?%s-%[)" ..
								datepattern .. "%s-v" .. versionpattern,
							"%1" .. tagdate .. " v" .. tagname)
		content = string.gsub(content,
							"(\\ProvidesExpl%a-{[^\n]-}){[^\n]-}{[^\n]-}",
							"%1{" .. tagdate .. "}{" .. tagname .. "}")
		content = string.gsub(content, "(\\usepackage{" .. module .. "}%[)" ..
								datepattern .. "%]", "%1" .. tagdate .. "]")
		content = string.gsub(content,
							"\\changes{v" .. tagname .. "(%-dev)?}{" ..
								datepattern,
							"\\changes{v" .. tagname .. "}{" .. tagdate)
	end
	return content
end

--[[
  # CTAN/Upload configuration
]]

ctanexcludefiles={"DEMO*-de.tex"}
if options["target"] == "ctan" then
  excludefiles={table.unpack(excludefiles),table.unpack(ctanexcludefiles)}
end


github_base_url = "https://github.com/tudace/TUDa_LaTeX_templates"
ctanpkg = module
ctanzip=ctanpkg.."-ctan_v"..packageversion
uploadconfig = {
	author = "Marei Peischl",
	uploader = "Marei Peischl",
	description = "The TUDa-CI-Bundle provides a possibility to use the Corporate Design of TU Darmstadt in LaTeX. It contains documentclasses as well as some auxilary packages and config files together with templates for all supported document types.",
	pkg = ctanpkg,
	version = packageversion .. " " .. packagedate,
	license = "lppl1.3c",
	summary = "LaTeX templates using CI of Technische Universität Darmstadt",
	ctanPath = "/macros/latex/contrib/" .. ctanpkg,
	home = "https://www.ulb.tu-darmstadt.de/finden_nutzen/medien_nutzen/dokumente_erstellen/latex/index.en.jsp",
	support = "https://www.ulb.tu-darmstadt.de/lernen_arbeiten/lehr_und_lernformate/textverarbeitung/textverarbeitung.en.jsp",
	repository = {github_base_url .. ".git"},
	bugtracker = {github_base_url .. "/issues"},
	announcement_file = "ctan.ann",
	update = true,
	-- copied from CTAN entry https://ctan.org/json/2.0/pkg/tuda-ci 2025-01-08
	topic = {
		"doc-templ", "std-conform", "presentation", "dissertation", "class", "letter", "poster"
	},
	note_file = "ctan.note"
}
