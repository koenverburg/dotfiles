au BufEnter * if &buftype == 'terminal' | :startinsert | endif
autocmd BufEnter term://* startinsert
autocmd TermOpen * set bufhidden=hide

autocmd BufNewFile,BufRead *.ts setlocal filetype=typescript
autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx
