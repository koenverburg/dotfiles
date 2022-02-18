-- require('snippets').use_suggested_mappings()

-- local snippets = require'snippets'
-- local U = require'snippets.utils'
-- snippets.snippets = {
--   scss = {
--     debug = U.match_indentation [[
-- * {
--   background-color: rgba(0,0,0, .05);
-- }
--     ]]
--   };

--   typescriptreact = {

--     log = [[ console.log(${1}) ]]

--   };

--   -- ts = {
--   --   react = [[
-- -- type ${1:foo} = {
--   -- ${2:bar}
-- -- };]];

--   -- };

--   lua = {
--     req = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = require '$1']];

--     func = [[function${1|vim.trim(S.v):gsub("^%S"," %0")}(${2|vim.trim(S.v)})$0 end]];

--     ["local"] = [[local ${2:${1|S.v:match"([^.()]+)[()]*$"}} = ${1}]];

--     -- Match the indentation of the current line for newlines.
--     ["for"] = U.match_indentation [[
-- for ${1:i}, ${2:v} in ipairs(${3:t}) do
--   $0
-- end]];

--   };

--   _global = {
--     hack = U.force_comment [[ HACk: ${1} ]];
--     note = U.force_comment [[ NOTE: ${1} ]];
--     todo = U.force_comment [[ TODO(KOEN): ${1} ]];
--     copyright = U.force_comment [[ Copyright (C) Koen Verburg ${=os.date("%Y")} ]];
--   };
-- }

