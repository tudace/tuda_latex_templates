#!/usr/bin/env texlua

module="tuda-ci"

sourcefiledir="tex"
sourcefiles={"*.dtx", "*.ins","*.sty", "*.cls", "*.cfg", "*.clo", "*.def"}
installfiles={"*.sty", "*.cls", "*.cfg", "*.clo", "*.def"}

excludefiles={"Examples-*"}

textfiles= {"README.md"}

flatten=false

typesetexe="lualatex"
typesetopts=""
unpackexe="pdflatex"

demofiles = {"examples-de/*.tex", "examples/*.tex"}
supportdir="examples"
typesetsuppfiles={ "*.bib", "*.lco"}
typesetdemofiles = demofiles

tagfiles = {"*.sty", "*.cls", "*.cfg", "*.md", "*.clo", "examples/*.tex", "examples/*.lco", "*.def", "examples/*.bib"}
--


function update_tag(file,content,tagname,tagdate)
	local packagedate=tagdate
	local packageversion=tagname
	local replaced  = string.gsub(content,"tuda%-ci v%d+.%d+%-*%w* %(%d%d%d%d%-%d%d%-%d%d%)", "tuda-ci v"..tagname.." ("..tagdate..")")
	replaced = string.gsub(replaced,"\\def\\filedate{%d%d%d%d%-%d%d%-%d%d%}","\\def\\filedate{"..tagdate.."}")
	replaced = string.gsub(replaced,"\\def\\fileversion{%d+.%d%d%-*%w*}","\\def\\fileversion{"..tagname.."}")
	replaced = string.gsub(replaced,"version %d+.%d+%-*%w* %(%d%d%d%d%-%d%d%-%d%d%)","version "..tagname.." ("..tagdate..")")
	replaced = string.gsub (replaced,
                "\\ProvidesExplPackage {(.-)} {.-} {.-}",
                "\\ProvidesExplPackage {%1} {" .. packagedate.."} {"..packageversion .. "}")
	replaced = string.gsub (replaced,
	                  "\\ProvidesExplPackage {(.-)} {.-} {.-}",
	                  "\\ProvidesExplPackage {%1} {" .. packagedate.."} {"..packageversion .. "}")
	replaced = string.gsub (replaced,
	                  "\\ProvidesExplFile {(.-)} {.-} {.-}",
	                  "\\ProvidesExplFile {%1} {" .. packagedate.."} {"..packageversion .. "}")
	replaced = string.gsub (replaced,
	                  '(version%s*=%s*")%d%.%d+%l?(",%s*--TAGVERSION)',
	                  "%1"..packageversion.."%2")
	replaced = string.gsub (replaced,
	                  '(date%s*=%s*")%d%d%d%d%-%d%d%-%d%d(",%s*--TAGDATE)',
	                  "%1"..packagedate.."%2")
	replaced = string.gsub (replaced,
	                  "date{Version %d%.%d+%l?, released %d%d%d%d%-%d%d%-%d%d",
	                  "date{Version "..packageversion..", released ".. packagedate)
	replaced = string.gsub (replaced,
	                  "Copyright %(C%) 2019%-%d%d%d%d",
	                  "Copyright (C) 2019-"..os.date("%Y"))
	return replaced
end
