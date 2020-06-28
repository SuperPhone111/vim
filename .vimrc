set nocompatible              " be iMproved, required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'tomasiser/vim-code-dark'
Plugin 'morhetz/gruvbox'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'majutsushi/tagbar'
Plugin 'preservim/nerdtree'
Plugin 'mileszs/ack.vim'
Plugin 'ctrlpvim/ctrlp.vim'

Plugin 'octol/vim-cpp-enhanced-highlight'
"Plugin 'jaxbot/semantic-highlight.vim'

Plugin 'jsfaint/gen_tags.vim'
Plugin 'wesleyche/SrcExpl'

Plugin 'jiangmiao/auto-pairs'
call vundle#end()            " required
filetype plugin indent on    " required

"personal setting
set nocompatible
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8
set cursorline
set clipboard=unnamed
set noswapfile

"highlight word
syntax on
set hlsearch
set number

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set listchars=tab:>-

let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1

"tag
let g:loaded_gentags#ctags=1
let g:loaded_gentags#gtags=0
let g:gen_tags#gtags_default_map=1

"set leader key to ','
let mapleader=","

"set ; to :
nnoremap ; :

nmap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>

inoremap {<CR> {<CR>}<ESC>0
inoremap {{ {

"SemanticHighlight to convert variables into colors jaxbot/semantic-highlight.vim
"nnoremap <Leader>h :SemanticHighlightToggle<cr>

" Search for selected text, forwards or backwards.
vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R>=&ic?'\c':'\C'<CR><C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gVzv:call setreg('"', old_reg, old_regtype)<CR>

"set colorsheme
set t_Co=256
set t_ut=
" colorscheme codedark
colorscheme gruvbox
" 設定色調
set background=dark
" Airline ------------------------------
let g:airline_theme = 'codedark'
"let g:airline_theme = 'luna'
let g:airline_section_c = '%<%F%m %#__accent_red#%{airline#util#wrap(airline#parts#readonly(),0)}%#__restore__#'
"smart tab line
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
"let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" to use fancy symbols for airline, uncomment the following lines and use a
" patched font (more info on the README.rst)
"if !exists('g:airline_symbols')
"   let g:airline_symbols = {}
"endif
"let g:choosewin_overlay_enable = 1
"let g:airline_left_sep = '▶'
"let g:airline_left_alt_sep = '❯'
"let g:airline_right_sep = '◀'
"let g:airline_right_alt_sep = '❮'
"let g:airline_powerline_fonts = 1

"find file
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<leader>p'
let g:ctrlp_cmd = 'CtrlP'
map <leader>f :CtrlPMRU<CR>
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
    \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
    \ }
let g:ctrlp_working_path_mode=0
let g:ctrlp_match_window_bottom=1
let g:ctrlp_max_height=15
let g:ctrlp_match_window_reversed=0
let g:ctrlp_mruf_max=500
let g:ctrlp_follow_symlinks=1

"key mapping
map <silent> <F4> : call MyDisplayToggle()<CR>

function MyDisplayToggle()
    let b:my_display_enabled = exists('b:my_display_enabled') ? !b:my_display_enabled : 0
    if b:my_display_enabled
        set fdc=0
        set nu
        set nopaste
    else
        set fdc=0                                                                   
        set nonu                                                                
        set paste
	endif
"    if exists("g:loaded_Signature")
"        SignatureToggle
"    endif
endfunction

nmap <F5> :TagbarToggle<CR>
map <F6> :NERDTreeToggle<CR>

"map <F3> <ESC>:exec &mouse!=""? "set mouse=" : "set mouse=nv"<CR>

set mouse=nv
nnoremap <F3> :call ToggleMouse()<CR>
function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
        echo "disable mouse"
    "elseif &mouse == 'nv'
    "    " disable mouse
    "    set mouse=
    "    echo "disable mouse"
    elseif &mouse == ''
        set mouse=nv
        echo "mouse nv mode"
    else
        "enable mouse everywhere
        set mouse=a
        echo "mouse enabled"
    endif
endfunc

"move around windows with Ctrl-direction
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-l>l

"设置切换Buffer快捷键
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>

if executable('ag')
  let g:ackprg = 'ag --vimgrep'
  "let g:ackprg = 'ag --nogroup --nocolor --column'
  noremap FF :Ack<Space>
else
  noremap FF :echo "you need to install ack or ag first"<Enter>
endif

"Vim 自動回到檔案最後讀取位置
if has("autocmd")
    autocmd BufRead *.txt set tw=78
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal g'\"" |
    \ endif
endif

nmap <F2> :SrcExplToggle<CR>
let g:SrcExpl_pluginList = [
        \ "__Tag_List__",
        \ "_NERD_tree_",
        \ "Source_Explorer"
    \ ]

" // Set the height of Source Explorer window
let g:SrcExpl_winHeight = 8

" // Set 100 ms for refreshing the Source Explorer
let g:SrcExpl_refreshTime = 100

" // Set "Enter" key to jump into the exact definition context
let g:SrcExpl_jumpKey = "<ENTER>"

" // Set "Space" key for back from the definition context
let g:SrcExpl_gobackKey = "<SPACE>"

" // Enable/Disable the local definition searching, and note that this is not
" // guaranteed to work, the Source Explorer doesn't check the syntax for now.
" // It only searches for a match with the keyword according to command 'gd'
let g:SrcExpl_searchLocalDef = 1

" // Workaround for Vim bug @https://goo.gl/TLPK4K as any plugins using autocmd for
" // BufReadPre might have conflicts with Source Explorer. e.g. YCM, Syntastic etc.
let g:SrcExpl_nestedAutoCmd = 1

" // Do not let the Source Explorer update the tags file when opening
let g:SrcExpl_isUpdateTags = 0

" // Use 'Exuberant Ctags' with '--sort=foldcase -R .' or '-L cscope.files' to
" // create/update the tags file
let g:SrcExpl_updateTagsCmd = "ctags --sort=foldcase -R ."

" // Set "<F11>" key for updating the tags file artificially
let g:SrcExpl_updateTagsKey = "<F11>"

" // Set "<F7>" key for displaying the previous definition in the jump list
let g:SrcExpl_prevDefKey = "<F7>"

" // Set "<F8>" key for displaying the next definition in the jump list
let g:SrcExpl_nextDefKey = "<F8>"

" for nerdcommenter
let g:NERDSpaceDelims=1
let g:NERDAltDelims_java = 1
let g:NERDAltDelims_c = 1
