let g:startify_session_dir = '~/.config/nvim-data/session'
let g:startify_session_delete_buffers = 1


nnoremap <leader>ss :SSave<CR>
nnoremap <leader>sc :SClose<CR>

let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['   Sessions'] },
  \ { 'type': 'dir', 'header': ['   Github'] },
  \ ]

  " \ { 'type': 'files',     'header': ['Files'] },
  " \ { 'type': 'dir',       'header': ['Current Directory '. getcwd()] },

"let g:startify_bookmarks = [
  "\ { 'c': '~/code/github/dotfiles' },
  "\ { 'i': '~/code/github/koenverburg.dev' },
  "\ ]

" let g:startify_bookmarks = systemlist("ls ~/code/github")
function! s:gitModified()
  let files = systemlist('git ls-files -m 2 > $null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" same as above, but show untracked files, honouring .gitignore
function! s:gitUntracked()
  let files = systemlist('git ls-files -o --exclude-standard 2 > $null')
  return map(files, "{'line': v:val, 'path': v:val}")
endfunction

" function! s:lsGithubDir()
"   let files = systemlist('(ll ~/code/github).name')
"   return map(files, "{'line': v:val, 'path': v:val}")
" endfunction

"let g:startify_lists = [
  "\ { 'type': function('s:gitModified'),  'header': ['   git modified']},
  "\ { 'type': function('s:gitUntracked'), 'header': ['   git untracked']},
  "\ { 'type': 'sessions',  'header': ['   Sessions']       },
  "\ { 'type': 'files',     'header': ['   MRU']            },
  "\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
   "\ { 'type': function('s:lsGithubDir'),  'header': ['   Github projects']},
  "\ ]
