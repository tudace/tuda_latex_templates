#!/usr/bin/env texlua

module="tuda-ci"

sourcefiledir="tex"
sourcefiles={"*.dtx", "*.ins","*.sty", "*.cls", "*.cfg", "*.clo", "*.def"}
installfiles={"*.sty", "*.cls", "*.cfg", "*.clo", "*.def"}
docfiledir="examples"
typesetfiles={"*.tex"}

textfiles= {"README.md"}

flatten=false

typesetexe="lualatex"
typesetopts=""
unpackexe="pdflatex"

demofiles = {"examples-de/*.tex", "examples/*.tex"}
supportdir="examples"

typesetsuppfiles={ "*.bib", "*.lco"}
typesetdemofiles = demofiles

-- allow to tag the build.lua file by only excluding it for other targets
excludefiles={"example/*","*/Examples-*.tex","Examples-*","*~"}
if not options["target"] == "tag" then
	excludefiles={table.unpack(excludefiles),"build.lua","config-*.lua"}
end

packageversion = "3.42-dev"
packagedate = "2025-01-07"

tagfiles = {"*.sty", "*.cls", "*.cfg", "*.md", "*.clo", "*.tex", "*.lco", "*.def", "*.bib", "*.lua"}

function get_dev_tag (oldtag)
	if string.match(oldtag, "%-dev$") then
		return (oldtag), true
	end
	newtag=string.gsub(oldtag,"v?(%d+).%d+%-?%w*%s?","%1.")..string.format("%02d",math.floor(string.gsub(oldtag,"v?%d+.(%d+)%-?%w*%s?","%1") + 1))
	return newtag.."-dev",false
end

function update_tag(file,content,tagname,tagdate)
	local versionpattern = "%d+.%d+%-?%w*"
	local datepattern = "%d%d%d%d%-%d%d%-%d%d"
	local tag_only_changes = false
	local tagname = tagname or packageversion
	if tagname=="dev" or string.match(tagname, "%-dev$")then
		tagname, tag_only_changes=get_dev_tag(packageversion)
	end
	-- tagging \changes
	content = string.gsub(content,"\\changes{v?0*%.0*}{"..datepattern, "\\changes{v"..tagname.."}{"..tagdate)
	content = string.gsub(content,"\\changes{v3.41-dev}{2025-01-07", "\\changes{v"..tagname.."}{"..tagdate)
	-- don't tag fileversion to not change all dates
	if tag_only_changes then
		return content
	end
	content = string.gsub(content,
		"(tuda%-ci v)"..versionpattern.."%s%("..datepattern.."%)",
		"%1"..tagname.." ("..tagdate..")")
	content = string.gsub(content,
		"(version )"..versionpattern.."%s%("..datepattern.."%)",
		"%1"..tagname.." ("..tagdate..")")
	content = string.gsub(content,"\\def\\filedate{"..datepattern.."}","\\def\\filedate{"..tagdate.."}")
	content = string.gsub(content,"\\def\\fileversion{"..versionpattern.."}","\\def\\fileversion{"..tagname.."}")
	if string.match(file, "%.md$") or string.match(file, "%.tex$") then
		content = string.gsub(content,
			"(tuda%-ci v|version)"..versionpattern.."%s%("..datepattern.."%)",
			"%1"..tagname.." ("..tagdate..")")
	elseif file == "build.lua" then
		content = string.gsub(content,"(packageversion%s*=%s*\")"..versionpattern, "%1"..tagname)
		content = string.gsub(content,"(packagedate%s*=%s*\")"..datepattern, "%1"..tagdate)
	else
		content = string.gsub(content,
			"(\\Provides%a-{[^\n]-}%[)"..datepattern.."%s-v"..versionpattern,
			"%1"..tagdate.." v"..tagname)
		content = string.gsub(content,
			"(\\ProvidesExpl%a-{[^\n]-}){[^\n]-}{[^\n]-}",
			"%1{".. tagdate.."}{"..tagname .. "}")
		content = string.gsub(content,
			"(\\usepackage{"..module.."}%[)"..datepattern.."%]",
			"%1"..tagdate.."]")
		content = string.gsub(content,"\\changes{v"..tagname.."(%-dev)?}{"..datepattern, "\\changes{v"..tagname.."}{"..tagdate)
	end
	content = string.gsub (content,
	                  "(Copyright %(C%) 20%d%d%–)%d%d%d%d",
	                  "%1"..os.date("%Y"))
	return content
end
