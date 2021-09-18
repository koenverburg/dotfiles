set list

if !get(g:, 'loaded_cyclist', v:false)
  finish
endif

call cyclist#add_listchar_option_set('default', {
  \ 'eol': '↲',
  \ 'tab': '» ',
  \ 'trail': '·',
  \ 'space': '·',
  \ 'extends': '<',
  \ 'precedes': '>',
  \ 'conceal': '┊',
  \ 'nbsp': '␣',
  \ })


call cyclist#add_listchar_option_set('limited', {
  \ 'eol': '↲',
  \ 'tab': '» ',
  \ 'trail': '·',
  \ 'space': '·',
  \ 'extends': '<',
  \ 'precedes': '>',
  \ 'conceal': '┊',
  \ 'nbsp': '␣',
  \ })

" call cyclist#add_listchar_option_set('busy', {
"         \ 'eol': '↲',
"         \ 'tab': '»·',
"         \ 'space': '·',
"         \ 'trail': '-',
"         \ 'extends': '☛',
"         \ 'precedes': '☚',
"         \ 'conceal': '┊',
"         \ 'nbsp': '☠',
"         \ })

nmap <leader>cl <Plug>CyclistNext
let context_vt_namespace = nvim_create_namespace('context_vt')
