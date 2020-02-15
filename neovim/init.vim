" .vimrc
" Author: Koen Verburg <creativekoen@gmail.com>
" Source: https://github.com/koenverburg/dotfiles

source $localappdata/nvim/scripts/plugins.vim
source $localappdata/nvim/scripts/general.vim
source $localappdata/nvim/scripts/autocmd.vim
source $localappdata/nvim/scripts/search.vim
source $localappdata/nvim/scripts/ag.vim
source $localappdata/nvim/scripts/shortcuts.vim

let g:enable_bold_font = 1                                                      "Enable bold font in colorscheme
let g:enable_italic_font = 0                                                    "Enable italic font in colorscheme
let mapleader = ","

set background=dark
colorscheme gruvbox
syntax enable    " enable syntax highlighting

" plugin setting ----------------------------------------------------------- {{{

" typescript and react
" dark red
  hi tsxTagName guifg=#E06C75

  " orange
  hi tsxCloseString guifg=#F99575
  hi tsxCloseTag guifg=#F99575
  hi tsxCloseTagName guifg=#F99575
  hi tsxAttributeBraces guifg=#F99575
  hi tsxEqual guifg=#F99575

  " yellow
  hi tsxAttrib guifg=#F8BD7F cterm=italic
  " light-grey
  hi tsxTypeBraces guifg=#999999
  " dark-grey
  hi tsxTypes guifg=#666666

  hi ReactState guifg=#C176A7
  hi ReactProps guifg=#D19A66
  hi ApolloGraphQL guifg=#CB886B
  hi Events ctermfg=204 guifg=#56B6C2
  hi ReduxKeywords ctermfg=204 guifg=#C678DD
  hi ReduxHooksKeywords ctermfg=204 guifg=#C176A7
  hi WebBrowser ctermfg=204 guifg=#56B6C2
  hi ReactLifeCycleMethods ctermfg=204 guifg=#D19A66

  let g:indentLine_enabled = 0
  let g:indentLine_setColors = 0
  let g:indentLine_leadingSpaceEnabled = 1

  let g:EditorConfig_exec_path = 'editorconfig'

  " Json
  let g:vim_json_syntax_conceal = 0                                             " I want to see the quote's

  " Airline
  let g:airline_theme = 'gruvbox'
  let g:airline#extensions#tabline#enabled = 1

  let g:conflict_marker_enable_mappings = 0
  let g:gitgutter_sign_added = '│'
  let g:gitgutter_sign_modified = '│'
  let g:gitgutter_sign_removed = '│'
  let g:gitgutter_sign_removed_first_line = '│'
  let g:gitgutter_sign_modified_removed = '│'

  let g:javascript_plugin_flow = 1
  let g:javascript_plugin_jsdoc = 1
  let g:jsx_ext_required = 1
  let g:vim_json_syntax_conceal = 0
  let g:tigris#enabled = 1

  let g:airline_powerline_fonts = 1
  let g:airline#extensions#tabline#enabled = 1

  let NERDTreeShowHidden = 1
  let NERDTreeShowLineNumbers = 0

  nnoremap <silent><leader>nn :NERDTreeToggle<cr>
  inoremap <silent><leader>nn :NERDTreeToggle<cr>

  autocmd BufEnter NERD_tree* :LeadingSpaceDisable

  " WordJumping like in vscode and resharper
  imap <silent> <S-Left> <C-o><Plug>CamelCaseMotion_b
  imap <silent> <S-Right> <C-o><Plug>CamelCaseMotion_w

  map <silent> w <Plug>CamelCaseMotion_w
  map <silent> b <Plug>CamelCaseMotion_b
  map <silent> e <Plug>CamelCaseMotion_e
  map <silent> ge <Plug>CamelCaseMotion_ge
  sunmap w
  sunmap b
  sunmap e
  sunmap ge

" }}}

" COC settings ------------------------------------------------------------- {{{
  let g:coc_global_extensions = [ 'coc-tslint-plugin', 'coc-tsserver', 'coc-emmet', 'coc-css', 'coc-html', 'coc-json', 'coc-yank', 'coc-prettier', 'coc-actions', 'coc-elixir']

  " let g:coc_user_config = {}
  " let g:coc_user_config['coc.preferences.hoverTarget'] = 'echo'
  " let g:coc_user_config['signature.target'] = 'echo'

  " nmap <silent> gd <Plug>(coc-definition)
  " " Remap for do codeAction of selected region
  " function! s:cocActionsOpenFromSelected(type) abort
  "   execute 'CocCommand actions.open ' . a:type
  " endfunction
  " xmap <silent> <leader>a :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
  " nmap <silent> <leader>a :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
" }}}

" Airline customization ---------------------------------------------------- {{{

  function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create_left(['%P'])
    let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']

    let g:airline_section_x = airline#section#create(['hunks','%P',' ','branch'])
    let g:airline_section_y = airline#section#create(['filetype'])
    let g:airline_section_z = airline#section#create_right(['%l','%c'])
  endfunction

  autocmd VimEnter * call AirlineInit()
" }}}
