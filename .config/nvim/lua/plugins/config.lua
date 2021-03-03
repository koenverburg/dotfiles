vim.cmd [[ augroup illuminate_augroup ]]
vim.cmd [[ autocmd! ]]
vim.cmd [[ autocmd VimEnter * hi illuminatedWord cterm=underline gui=underline ]]
vim.cmd [[ augroup END ]]

vim.g.DevIconsAppendArtifactFix = 1

local linterAndFixers = {'eslint', 'gofmt', 'golint', 'terraform', 'terraform-ls', 'ansible-lint', 'stylelint', 'spectral'}
vim.b.ale_fixers = linterAndFixers
vim.b.ale_linters = linterAndFixers

vim.g.ale_sign_column_always = 1
vim.g.ale_echo_msg_error_str = 'E'
vim.g.ale_echo_msg_warning_str = 'W'
vim.g.ale_echo_msg_format = '[%linter%] %s [%severity%]'
vim.g.ale_sign_error = '●'
vim.g.ale_sign_warning = '.'
