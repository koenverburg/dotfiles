-- require('planery.reload').reload_module('popup')

local popup = require('popup')

popup.create('Hello World', {
  results = {
    minheight = 10,
    minwidth = 0.8
  },
  line = 8,
  col = 55,
  -- padding = { 0, 0, 0, 0 },
  borderchars = {"─", "│", "─", "│", "┌", "┐", "┘", "└"},
  -- borderchars = {"━", "┃", "━", "┃", "┏", "┓", "┛", "┗"}
  -- borderchars = {"═", "║", "═", "║", "╔", "╗", "╝", "╚"}
})
