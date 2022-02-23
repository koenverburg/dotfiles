# Nvim

The keybinding I use in vim

| key                      | what it does                         |
|--------------------------|--------------------------------------|
| shift+h                  | Jump to the beginning of a line      |
| shift+l                  | Jump to the end of a line            |
| Tab                      | Jump between {}[]()                  |
| ,w                       | save a file                          |
| ,space                   | resets the highlighted searched word |
| ,s                       | Sort lines in alphabetical order     |
| ,,                       | Toggles QuickFix window              |
| ,shift+t                 | Creates a new tab                    |
| ,shift+{h,l}             | move tags left and right             |
| ctrl+{h,j,k,l}           | move left,up,down, right on panes    |
| ctrl+{left, right} arrow | make a pane bigger or smaller        |
| gt                       | go to next tab                       |
| gT                       | go to previous tab                   |

#### Telescope
| Action                           | Mappings       |
|----------------------------------|----------------|
| Next item                        | `<C-n>/<Down>` |
| Previous item                    | `<C-p>/<Up>`   |
| Next/previous (in normal mode)   | `j/k`          |
| Confirm selection                | `<CR>`         |
| go to file selection as a split  | `<C-x>`        |
| go to file selection as a vsplit | `<C-v>`        |
| go to a file in a new tab        | `<C-t>`        |
| scroll up in preview window      | `<C-u>`        |
| scroll down in preview window    | `<C-d>`        |
| close telescope                  | `<C-c>`        |
| close telescope (in normal mode) | `<Esc>`        |


---

Telescope File Browser
```lua
local mappings = {
  ["i"] = {
    ["<A-c>"] = fb_actions.create,
    ["<A-r>"] = fb_actions.rename,
    ["<A-m>"] = fb_actions.move,
    ["<A-y>"] = fb_actions.copy,
    ["<A-d>"] = fb_actions.remove,
    ["<C-o>"] = fb_actions.open,
    ["<C-g>"] = fb_actions.goto_parent_dir,
    ["<C-e>"] = fb_actions.goto_home_dir,
    ["<C-w>"] = fb_actions.goto_cwd,
    ["<C-t>"] = fb_actions.change_cwd,
    ["<C-f>"] = fb_actions.toggle_browser,
    ["<C-h>"] = fb_actions.toggle_hidden,
    ["<C-s>"] = fb_actions.toggle_all,
  },
  ["n"] = {
    ["c"] = fb_actions.create,
    ["r"] = fb_actions.rename,
    ["m"] = fb_actions.move,
    ["y"] = fb_actions.copy,
    ["d"] = fb_actions.remove,
    ["o"] = fb_actions.open,
    ["g"] = fb_actions.goto_parent_dir,
    ["e"] = fb_actions.goto_home_dir,
    ["w"] = fb_actions.goto_cwd,
    ["t"] = fb_actions.change_cwd,
    ["f"] = fb_actions.toggle_browser,
    ["h"] = fb_actions.toggle_hidden,
    ["s"] = fb_actions.toggle_all,
  },
}
```
