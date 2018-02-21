"########### デフォルトvim設定 ###########
" Color Setting
autocmd ColorScheme * highlight LineNr ctermfg=48
colorscheme inkpot
let g:molokai_original = 1
let g:rehash256 = 1
set background=dark
set cursorline

set number " 行番号を常に表示
set showmatch  "括弧入力時に反対側を表示
"ステータスラインにコマンドを表示
set showcmd
"ステータスラインを常に表示
set laststatus=2
"ファイルナンバー表示
set statusline=[%n]
"ホスト名表示
set statusline+=%{matchstr(hostname(),'\\w\\+')}@
"ファイル名表示
set statusline+=%<%F

set expandtab "タブ入力を複数の空白入力に置き換える
set tabstop=2 "画面上でタブ文字が占める幅
set shiftwidth=2 "自動インデントでずれる幅
set softtabstop=2 "連続した空白に対してタブキーやバックスペースキーでカーソルが動く幅
set autoindent "改行時に前の行のインデントを継続する
set smartindent "改行時に入力された行の末尾に合わせて次の行のインデントを増減する"
set formatoptions-=ro "コメントアウトなどを開業時に自動挿入しない"
filetype plugin indent on "ファイルに応じたインデントオン"


"########### プラグイン & dein.vim設定 ###########
" dein自体の自動インストール
let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'
if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif
let &runtimepath = s:dein_repo_dir .",". &runtimepath"

if &compatible
  set nocompatible
endif
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})

call dein#add('scrooloose/nerdtree') 	"ディレクトリツリーの表示
call dein#add('tomasr/molokai')   "カラースキーマ
call dein#add('Townk/vim-autoclose')  "括弧を自動で挿入してくれる
call dein#add('Shougo/neocomplcache') "自動補完
call dein#add('thinca/vim-visualstar') "ビジュアルで選択したものを検索してくれる
call dein#add('drillbits/nyan-modoki.vim') "エンジニアの寿命のためのプラグイン

"文法チェック系
call dein#add('scrooloose/syntastic')  "チェックツール
call dein#add('leafgarland/typescript-vim')
call dein#add('pmsorhaindo/syntastic-local-eslint.vim')
call dein#add('hail2u/vim-css3-syntax') "cssのシンタックス

call dein#end()

"dein 不足プラグイン　自動インストール
if dein#check_install()
  call dein#install()
endif

syntax on  "シンタックスハイライトをオンにする(これは最後に持ってこないと効かない

"########### プラグイン独自設定 ###########
let g:syntastic_typescript_checks=['tsc', 'tslint']
let g:syntastic_typescript_tsc_fname = ''
"let g:syntastic_typescript_tsc_args = '--target ES5'
let g:syntastic_javascript_checkers=['eslint']
" エラー行に sign を表示
let g:syntastic_enable_signs = 1
" location list を常に更新
let g:syntastic_always_populate_loc_list = 0
" location list を常に表示
let g:syntastic_auto_loc_list = 0
" ファイルを開いた時にチェックを実行する
let g:syntastic_check_on_open = 1
" :wq で終了する時もチェックする
let g:syntastic_check_on_wq = 0
" 補完候補が表示されている場合は確定。そうでない場合は改行
"inoremap <expr><CR>  pumvisible() ? neocomplcache#close_popup() : "<CR>"
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction

"#### NERDTree設定 #### 
nnoremap <silent><C-e> :NERDTreeToggle<CR>  "<C-e>でnerdTreeを開閉
" NERDTress ファイルの種類別カラースキーマ
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction
call NERDTreeHighlightFile('py',     'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('md',     'blue',    'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml',    'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('config', 'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('conf',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('json',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('html',   'yellow',  'none', 'yellow',  '#151515')
call NERDTreeHighlightFile('styl',   'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('css',    'cyan',    'none', 'cyan',    '#151515')
call NERDTreeHighlightFile('rb',     'Red',     'none', 'red',     '#151515')
call NERDTreeHighlightFile('js',     'Red',     'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php',    'Magenta', 'none', '#ff00ff', '#151515')
call NERDTreeHighlightFile('ts',     'Red',     'none', '#DD0031', '#000000')

"#### neocomplcache設定 ####
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
    \ 'default' : ''
    \ }

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"ファイル名指定なしで起動された場合にNERDTreeを起動
autocmd StdinReadPre * let s:std_in=1

"ウィンドウ状態の保存
"" 現在のディレクトリ直下の .vimsessions/ を取得 
"let s:local_session_directory = xolox#misc#path#merge(getcwd(), '.vimsessions')
"" 存在すれば
"if isdirectory(s:local_session_directory)
"  " session保存ディレクトリをそのディレクトリの設定
"  let g:session_directory = s:local_session_directory
"  " vimを辞める時に自動保存
"  let g:session_autosave = 'yes'
"  " 引数なしでvimを起動した時にsession保存ディレクトリのdefault.vimを開く
"  let g:session_autoload = 'yes'
"  " 1分間に1回自動保存
"  let g:session_autosave_periodic = 1
"else
"  let g:session_autosave = 'no'
"  let g:session_autoload = 'no'
"endif
"unlet s:local_session_directory



"癒やし
set laststatus=2
set statusline=%F%m%r%h%w[%{&ff}]%=%{g:NyanModoki()}(%l,%c)[%P]
let g:nyan_modoki_select_cat_face_number = 2
let g:nayn_modoki_animation_enabled= 1
