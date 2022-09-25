-- Disable builtin plugins {{{
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1

vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1

vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
--}}}

-- utils {{{
function loadable(name)
  local ok, module = pcall(require, name)

  if not ok then
    vim.notify("Failed to load " .. name)
    return
  end
  return module
end

function bind(mode, keys, func)
  vim.api.nvim_set_keymap(mode, keys, func, { noremap = true, silent = true })
end

function normal(key, func)
  bind("n", key, func)
end

function visual(key, func)
  bind("v", key, func)
end

function insert(key, func)
  bind("i", key, func)
end

function terminal(key, func)
  bind("t", key, func)
end

function lsp_map(mode, key, action)
  local command = string.format("<cmd>lua %s()<cr>", action)
  vim.api.nvim_buf_set_keymap(0, mode, key, command, { noremap = true, silent = true })
end

-- }}}

-- Load first {{{
loadable('impatient')
loadable('packer_compiled')
-- }}}

-- Vim Opts {{{
vim.cmd "language en_US.utf-8"
vim.cmd [[ highlight clear SignColumn ]]
vim.cmd [[ set nowrap ]]
vim.cmd [[ set laststatus=3 ]]
vim.cmd [[ set noshowmode ]]
vim.cmd [[ set colorcolumn=80,120 ]]

vim.g.mapleader = ","
vim.g.hidden = true
vim.g.nobackup = true
vim.g.undofile = true
vim.g.undordir = "~/.config/nvim/undodir"
-- vim.g.nowrap = true
vim.g.noswapfile = true

vim.wo.number = true
vim.wo.list = true
vim.wo.relativenumber = false

vim.opt.autoindent = true
vim.opt.autoindent = true
vim.opt.background = "dark"
vim.opt.backspace = "indent,eol,start"
vim.opt.clipboard = vim.o.clipboard .. "unnamed,unnamedplus"
vim.opt.cmdheight = 1
vim.opt.completeopt = "menu,menuone,noselect,noinsert"
vim.opt.cursorline = true
vim.opt.expandtab = true

vim.opt.foldmethod = "marker"
vim.opt.foldenable = true
vim.cmd [[ set foldlevel=0 ]]

vim.opt.inccommand = "split"
vim.opt.ruler = true
vim.opt.shiftwidth = 2
vim.opt.shortmess = vim.o.shortmess .. "c"
vim.opt.showtabline = 2
vim.opt.signcolumn = "yes"
vim.opt.softtabstop = 2
vim.opt.tabstop = 2
vim.opt.termguicolors = true

local function status_line()
  local file_name = "%m %t"
  local modified = " %-m"
  local right_align = "%="
  local line_no = "%10([%l/%L%)]"

  return string.format("%s%s%s%s", file_name, modified, right_align, line_no)
end

vim.opt.winbar = status_line()
-- }}}

-- Bootstrap Packer {{{
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
if not packer_exists then
  if vim.fn.input "Download Packer? (y for yes)" ~= "y" then
    return
  end

  local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath "data")
  vim.fn.mkdir(directory, "p")

  local out = vim.fn.system(
    string.format('git clone %s "%s"', "https://github.com/wbthomason/packer.nvim", directory .. "/packer.nvim")
  )

  print(out)
  print "Downloading packer.nvim..."
  print "( You'll need to restart now )"

  return
end
-- }}}

-- Packer {{{
require("packer").startup {
  function(use)
    -- use "tweekmonster/startuptime.vim"
    use { "wbthomason/packer.nvim", opt = true }
    use { "lewis6991/impatient.nvim" }

    -- Colorscheme
    use "Shatur/neovim-ayu"
    use "glepnir/zephyr-nvim"
    use "Yagua/nebulous.nvim"
    use "ellisonleao/gruvbox.nvim"
    use "tjdevries/gruvbuddy.nvim"
    use "tjdevries/colorbuddy.vim"

    -- Telescope
    use "nvim-telescope/telescope.nvim"
    use "ThePrimeagen/git-worktree.nvim"
    use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }

    -- treesitter
    use "nvim-treesitter/playground"
    use "nvim-treesitter/nvim-treesitter"
    use "JoosepAlviste/nvim-ts-context-commentstring"
    -- use "nvim-treesitter/nvim-treesitter-textobjects"

    -- LSP config
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-nvim-lsp"
    use "hrsh7th/nvim-cmp"
    use "j-hui/fidget.nvim"
    use "tami5/lspsaga.nvim" -- look into creating myown hovers
    use "onsails/lspkind-nvim"
    use "neovim/nvim-lspconfig"
    use "ray-x/lsp_signature.nvim"
    use { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" }
    -- use "nvim-lua/lsp_extensions.nvim"
    -- use "simrat39/inlay-hints.nvim"

    -- Misc
    use "nvim-lua/popup.nvim"
    use "nvim-lua/plenary.nvim"

    -- Utils
    use "phaazon/hop.nvim"
    use "windwp/nvim-autopairs"
    use "kyazdani42/nvim-tree.lua"
    use "stevearc/dressing.nvim"
    use "unblevable/quick-scope"
    use "rmagatti/alternate-toggler"
    use "jose-elias-alvarez/null-ls.nvim"
    use "numToStr/Comment.nvim"
    -- use "rcarriga/nvim-notify"
    -- use 'anuvyklack/hydra.nvim'

    -- Searching
    use "google/vim-searchindex"

    -- sessions
    use "rmagatti/session-lens"
    use "rmagatti/auto-session"

    -- Misc
    -- use "RRethy/vim-illuminate"
    -- use "nathom/filetype.nvim"

    -- Lanaguages
    use "elzr/vim-json"
    use "stephpy/vim-yaml"
    use "ekalinin/Dockerfile.vim"

    -- Looks
    use "lewis6991/gitsigns.nvim"
    use "tjdevries/express_line.nvim"
    use "kyazdani42/nvim-web-devicons"

    -- My plugins
    -- use "koenverburg/peepsight.nvim"
    -- use "koenverburg/cmd-palette.nvim"
    use "koenverburg/minimal-tabline.nvim"

    -- Git
    -- use "TimUntersberger/neogit"
    -- use "sindrets/diffview.nvim"
    -- use "tjdevries/diff-therapy.nvim"
  end,
  config = {
    -- Move to lua dir so impatient.nvim can cache it
    compile_path = vim.fn.stdpath "config" .. "/lua/packer_compiled.lua",
    display = {
      open_fn = function()
        return require("packer.util").float { border = "single" }
      end,
    },
  },
}
-- }}}

-- Plugin Configs {{{
require("minimal-tabline").setup {
  enable = true,
  file_name = false,
  tab_index = true,
  pane_count = false,
  modified_sign = false,
  no_name = "[No Name]",
}

require('hop').setup()
require("fidget").setup()
require("gitsigns").setup()
require("session-lens").setup()
require('comment').setup()
require("lsp_signature").setup()

require("mason").setup()
require("mason-lspconfig").setup {
  automatic_installation = false,
  ensure_installed = {
    "gopls",
    "css-lsp",
    "sumneko_lua",
    "cssmodules-language-server",
    "tailwindcss-language-server",
    "typescript-language-server",
  },
}

local ls = require("null-ls")

local spell = ls.builtins.completion
local formatting = ls.builtins.formatting
local diagnostics = ls.builtins.diagnostics

local os = vim.loop.os_uname().sysname

local core_sources = {
  -- completion.spell,
  formatting.gofmt,
  formatting.stylua, -- install with "cargo install stylua"
  formatting.prettier,
}

local function TableConcat(t1, t2)
  for i = 1, #t2 do
    t1[#t1 + 1] = t2[i]
  end
  return t1
end

local hostname = vim.loop.os_gethostname()
local sources = core_sources

if string.find(hostname, 'AMS') then
  sources = TableConcat(sources, { formatting.eslint })
else
  sources = TableConcat(sources, { formatting.standardjs })
end

ls.setup {
  sources = {}, -- something is wrong with this, got an issue on adimbp
}

require("nvim-tree").setup({
  view = {
    float = {
      enable = true,
      open_win_config = {
        relative = "editor",
        border = "rounded",
        width = 200,
        height = 50,
        row = 5,
        col = 5,
      },
    }
  }
})

require("nvim-treesitter.configs").setup {
  highlight = { enable = true, additional_vim_regex_highlighting = true },
  indent = { enable = true },
  ensure_installed = {
    "css",
    "go",
    "graphql",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "markdown",
    "tsx",
    "typescript",
    "yaml",
  },
  context_commentstring = {
    enable = true,
    config = {
      yml = "# %s",
      yaml = "# %s",

      css = "// %s",
      scss = "// %s",

      js = "// %s",
      ts = "// %s",
      tsx = {
        __default = "// %s",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
        jsx_attribute = "{/* %s */}",
        comment = "// %s",
      },
      jsx = {
        __default = "// %s",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
        jsx_attribute = "{/* %s */}",
        comment = "// %s",
      },
    },
  },
}

require("telescope").setup {
  defaults = {
    color_devicons = true,
    borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
    layout_config = {
      height = 0.75,
      width = 0.9
    }
  },
  extensions = {
    fzf = {
      fuzzy = false, -- false will only do exact matching
      override_file_sorter = true, -- override the file sorter
      override_generic_sorter = true, -- override the generic sorter
      case_mode = "ignore_case", -- or "ignore_case" or "respect_case", the default case_mode is "smart_case"
    },
  },
}

require("telescope").load_extension "fzf"
local cmp = require "cmp"
local lspkind = require "lspkind"
local lspconfig = require "lspconfig"
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = {
    ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-k>"] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(
      cmp.mapping.confirm {
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      },
      { "i", "s" }
    ),
  },
  experimental = {
    native_menu = false,
    ghost_text = true,
  },
  formatting = {
    format = lspkind.cmp_format(),
  },
  sources = {
    { name = "luasnip" },
    { name = "nvim_lsp" },
    { name = "treesitter" },
    { name = "path" },
    { name = "buffer" },
  },
}

function lsp_on_attach(client, bufnr)
  -- require("aerial").on_attach(client, bufnr)
  -- require("conrad.plugins.show-references").on_attach(client, bufnr)

  if client.name == "tsserver" or client.name == "gopls" then
    client.server_capabilities.document_formatting = false
  end

  -- if client.name == "tsserver" or client.name == "lua" or client.name == "go" then
  --   require("inlay-hints").on_attach(client, bufnr)
  -- end

  normal("<leader>lf", [[ <cmd>lua vim.lsp.buf.format({async=true})<cr> ]])

  lsp_map("n", "K", "vim.lsp.buf.hover")
  lsp_map("n", "gD", "vim.lsp.buf.declaration")
  lsp_map("n", "gd", "vim.lsp.buf.definition")
  lsp_map("n", "<c-]>", "vim.lsp.buf.definition")
  lsp_map("n", "gi", "vim.lsp.buf.implementation")

  -- lsp saga
  lsp_map("n", "K", "require('lspsaga.hover').render_hover_doc")
  lsp_map("n", "gr", "require('lspsaga.rename').rename")

  lsp_map("n", "<leader>ca", "require('lspsaga.codeaction').code_action")
  lsp_map("i", "<leader>ca", "require('lspsaga.codeaction').code_action")

  lsp_map("n", "gx", "Lspsaga code_action<cr>")
  lsp_map("x", "gx", ":<c-u>Lspsaga range_code_action<cr>")

  -- Moved to telescope for these
  -- lsp_map('n', '<c-r>', 'vim.lsp.buf.references')
  -- lsp_map('n', 'gds', 'vim.lsp.buf.document_symbol')
  -- lsp_map('n', 'gW', 'vim.lsp.buf.workspace_symbol')

  lsp_map("n", "<leader>sd", "require('lspsaga.diagnostic').show_line_diagnostics")
  lsp_map("n", "[e", "require('lspsaga.diagnostic').lsp_jump_diagnostic_prev")
  lsp_map("n", "]e", "require('lspsaga.diagnostic').lsp_jump_diagnostic_next")
end

local servers = {
  vimls = {},
  dockerls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        hint = {
          enable = true,
        },
      },
    },
  },
  gopls = {
    settings = {
      gopls = {
        codelenses = {
          test = true,
          tidy = true,
          generate = true,
          references = true,
          upgrade_dependency = true,
        },
        hints = {
          assignVariableTypes = true,
          compositeLiteralFields = true,
          compositeLiteralTypes = true,
          constantValues = true,
          functionTypeParameters = true,
          parameterNames = true,
          rangeVariableTypes = true,
        },
        gofumpt = true,
      },
    },
  },
  tsserver = {
    root_dir = vim.loop.cwd,
    settings = {
      javascript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
      typescript = {
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionLikeReturnTypeHints = true,
          includeInlayFunctionParameterTypeHints = true,
          includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
          includeInlayParameterNameHintsWhenArgumentMatchesName = true,
          includeInlayPropertyDeclarationTypeHints = true,
          includeInlayVariableTypeHints = true,
        },
      },
    },
    filetypes = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",

      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  html = { cmd = { "vscode-html-language-server", "--stdio" } },
  cssls = { cmd = { "vscode-css-language-server", "--stdio" } },
}

for name, opts in pairs(servers) do
  if type(opts) == "function" then
    opts()
  else
    local client = lspconfig[name]
    client.setup(vim.tbl_extend("force", {
      on_attach = lsp_on_attach,
      flags = { debounce_text_changes = 150 },
      -- capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities()),
    }, opts))
  end
end




-- }}}

-- Vim Bindings {{{
normal("q", "<NOP>") -- turn off recording of macros
normal("G", "Gzz")

-- Swap : and ; to make colon commands easer to type
normal(";", ":")
normal(":", ";")

-- Quick folding
-- normal("<space>f", "za<cr>")

-- Rapid movement
normal("<s-a>", ":edit %:h<cr>")

-- Move whole lines, kudos @theprimeagen
visual("J", ":m '>+1<CR>gv=gv")
visual("K", ":m '<-2<CR>gv=gv")

-- Copy from cursor position to end of the line
normal("Y", "y$")

-- Concat lines below on current line
normal("J", "mzJ`z")

-- Undo until , .
insert(",", ",<c-g>u")
insert(".", ".<c-g>u")

-- This is so I can quickly quite out of vim without having to close all the buffers
-- normal("<leader>bd", "<cmd>qall<cr>") -- delete all buffers
normal("<leader>q", "<cmd>qall<cr>")

-- Easier Moving between splits
normal("<C-j>", "<C-W><C-J>")
normal("<C-k>", "<C-W><C-K>")
normal("<C-l>", "<C-W><C-L>")
normal("<C-h>", "<C-W><C-H>")

-- Better jk
normal("j", "gj")
normal("k", "gk")

-- Faster moving from beginning to end of a line
normal("H", "^")
normal("L", "g_")

visual("H", "^")
visual("L", "g_")

-- Jumping from the beginning of a []{}() to the end
normal("<Tab>", "%")

-- Splits
normal("sh", ":sp<cr>|<c-w>j")
normal("sv", ":vsp<cr>|<c-w>l")
-- normal("<leader>sh", ":sp<cr>|<c-w>j|:Telescope find_files<cr>")
-- normal("<leader>sv", ":vsp<cr>|<c-w>l|:Telescope find_files<cr>")

-- Keep search matches in the middle of the window
normal("n", "nzzzv")
normal("N", "Nzzzv")

-- Quickly return to normal mode
insert("jk", "<esc>")
normal("jk", "<esc>")

-- keep text selected after indentation
visual("<", "<gv")
visual(">", ">gv")

-- quickly cancel search highlighting
normal("<leader><space>", ":nohl<cr>")

normal('ta', '<cmd>ToggleAlternate<cr>')

-- Faster saving
-- normal('<leader>w', ':w<cr>')
-- insert('<leader>w', ':w<cr>')

-- Creating a new tab
normal("<leader>T", ":tabnew<cr>")

-- Tab movement
normal("<S-Tab>", ":tabnext<cr>")

normal("<space>", "za")

-- Telescope

normal('<space>t', '<cmd>Telescope git_files<cr>')
normal('<space>ff', '<cmd>Telescope find_files<cr>')

-- }}}

-- Looks {{{

-- Colorscheme
require('nebulous').setup()
-- statusline (bottom)
require('el').setup()

-- }}}
