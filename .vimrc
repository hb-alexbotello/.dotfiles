set nu
inoremap jj <Esc>
inoremap <C-;> <C-L>

set encoding=utf-8
set relativenumber
map <Space> <leader>

set autochdir


call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/tpope/vim-commentary.git'
Plug 'https://github.com/vim-scripts/ReplaceWithRegister.git'
Plug 'https://github.com/preservim/nerdtree.git'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'davidhalter/jedi-vim'
Plug 'https://github.com/leafgarland/typescript-vim.git'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'vim-airline/vim-airline'
call plug#end()


syntax enable
colorscheme gruvbox

nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>

nmap <Leader>b :Buffers<CR>
nmap <Leader>h :History<CR>

nmap <Leader>/ :Ag<Space>
nmap <Leader>/ :Rg<Space>

set laststatus=2
set statusline=%f "tail of the filename
map <C-n> :NERDTreeToggle<CR>
autocmd InsertLeave * write

augroup SyntaxSettings
    autocmd!
    autocmd BufNewFile,BufRead *.tsx set filetype=typescript
augroup END

au BufRead,BufNewFile *.py,*pyw set shiftwidth=4
au BufRead,BufNewFile *.py,*.pyw set expandtab

au BufRead,BufNewFile *.js,*jsx,*tsx set shiftwidth=2

autocmd FileType typescript setlocal formatprg=prettier\ --parser\ typescript

set autoread
let g:NERDTreeShowHidden=1


command! -bang -nargs=* Find call fzf#vim#grep('rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)
nnoremap \ :Rg<Space>

