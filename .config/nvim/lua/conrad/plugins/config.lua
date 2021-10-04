vim.cmd [[ augroup illuminate_augroup ]]
vim.cmd [[ autocmd! ]]
vim.cmd [[ autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline ]]
vim.cmd [[ augroup END ]]

vim.g.DevIconsAppendArtifactFix = 1

-- Markdown
vim.g.vim_markdown_frontmatter = 1
vim.g.vim_markdown_folding_disabled = 1

-- json
vim.g.vim_json_syntax_conceal = 0
