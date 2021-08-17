local c = require('colorbuddy.color').colors
local s = require('colorbuddy.style').styles
local Group = require('colorbuddy.group').Group

Group.new('HopNextKey', c.pink, nil, s.bold)
Group.new('HopNextKey1', c.cyan:saturate(), nil, s.bold)
Group.new('HopNextKey2', c.cyan:dark(), nil)
