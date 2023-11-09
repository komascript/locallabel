#!/usr/bin/env texlua

--[[
  Build script for LaTeX class locallabel.
  Copyright (c) 2023 Markus Kohm

  This file is part of the build system of locallabel.
]]

release_info = "2023-11-09 v0.1"
-- Bundle and modules

module       = "locallabel"

unpackfiles  = { "*.dtx" }

-- Typesetting

typesetruns  = 4

-- Detail how to set the version automatically
-- Example: `l3build tag --date 2023-10-10 v0.0.1'

tagfiles = {"*.dtx","README.md","build.lua"}

function update_tag (file,content,tagname,tagdate)
   tagname = string.gsub (tagname, "v(%d+%.%d+)", "%1")
   
   if string.match (file, "%.dtx$") then
      return string.gsub (content,
                          "%{%d%d%d%d%-%d%d%-%d%d%}%{[%d%.]*%d+%}",
                          "{" .. tagdate .. "}{" .. tagname .. "}" )
   elseif string.match (file, "%.md$") then
      return string.gsub (content,
                          "\nRelease: %d%d%d%d%-%d%d%-%d%d v[%d%.]*%d+",
                          "\nRelease: " .. tagdate .. " v" .. tagname )
   elseif string.match (file, "%.lua$") then
      return string.gsub (content,
                          '\nrelease_info%s*=%s*"%d%d%d%d%-%d%d%-%d%d%s*v[%d%.]*%d+"%s*\n',
                          '\nrelease_info = "' .. tagdate .. " v" .. tagname .. '"\n')
   end
   return content
end
