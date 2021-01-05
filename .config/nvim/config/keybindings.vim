" Execute this file, taken from TJ De Vries https://github.com/tjdevries/config_manager/blob/master/xdg_config/nvim/plugin/keymaps.vim
function! s:save_and_exec() abort
  if &filetype == 'vim'
    :silent! write
    :source %
  elseif &filetype == 'lua'
    :silent! write
    :luafile %
  endif

  return
endfunction

nnoremap <leader><leader>x :call <SID>save_and_exec()<CR>
