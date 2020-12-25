" if you prefer it opening in a left-right split:
let g:termbufm_direction_cmd = 'vnew'

" the default configuration
let g:termbufm_code_scripts = {
  \ 'node': { 'build': ['yarn dist'],'run': ['python %s', '%'] },
  \ 'cpp':    { 'build': ['g++ %s', '%'],            'run': ['./a.out'] },
  \ 'java':   { 'build': ['javac %s', '%'],          'run': ['java %s', '%:r'] },
  \ 'c':      { 'build': ['gcc %s', '%'],            'run': ['./a.out'] },
  \ }

" Shell settings
set shell=powershell
set shellcmdflag=-c
set shellquote=\"
set shellxquote=

nnoremap <silent> <leader>tb :TBuild<CR>
nnoremap <silent> <leader>tr :TRun<CR>

" toggle the window (show/hide)
nnoremap <silent> <leader><space> :call TermBufMToggle()<CR>
