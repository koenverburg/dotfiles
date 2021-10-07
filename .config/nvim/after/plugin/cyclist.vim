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

call cyclist#activate_listchars('default')

nmap <leader>cl <Plug>CyclistNext
