let g:startify_session_dir = '~/.config/nvim/session'
let g:startify_session_delete_buffers = 1

let g:startify_lists = [
  \ { 'type': 'sessions',  'header': ['Sessions'] },
  \ { 'type': 'bookmarks', 'header': ['Bookmarks'] },
  \ ]

  " \ { 'type': 'files',     'header': ['Files'] },
  " \ { 'type': 'dir',       'header': ['Current Directory '. getcwd()] },

let g:startify_bookmarks = [
  \ { 'c': '~/code/github/dotfiles' },
  \ { 'i': '~/code/github/koenverburg.dev' },
  \ ]