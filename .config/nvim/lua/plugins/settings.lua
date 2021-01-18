vim.cmd [[ augroup illuminate_augroup ]]
vim.cmd [[ autocmd! ]]
vim.cmd [[ autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline ]]
vim.cmd [[ augroup END ]]

vim.g.airline_theme = 'minimalist'
-- vim.g.airline_powerline_fonts = 1
-- vim.g.airline#extensions#tabline#enabled = 1

--vim.g:DevIconsAppendArtifactFix = 1
