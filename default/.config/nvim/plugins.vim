"Start Dein (plugin manager)
let s:config_dir = substitute(expand('<sfile>:p:h'), '\', '/', 'g')
let s:bundle_dir = s:config_dir . "/bundle"
let s:dein_dir = s:bundle_dir . "/repos/github.com/Shougo/dein.vim"
let s:do_update = 0

if !isdirectory(s:dein_dir)
	call mkdir(fnamemodify(s:dein_dir, "h"), "p")
	execute '!git clone --depth 1 --branch master "https://github.com/Shougo/dein.vim" "' . s:dein_dir . '"'
	let s:do_update = 1
endif
execute("set runtimepath+=" . s:dein_dir)

if dein#load_state(s:bundle_dir)
	call dein#begin(s:bundle_dir)
	call dein#add('https://github.com/Shougo/dein.vim')

	" To be used everywhere, even in terminal
	call dein#add('https://github.com/chrisbra/Recover.vim')
	call dein#add('https://github.com/Shougo/denite.nvim')
	call dein#add('https://github.com/Shougo/neomru.vim',            {'depends': 'denite.nvim'})
	" Incsearch is a very nice plugin but it breaks macros. Maybe re-enable it
	" later? https://github.com/haya14busa/incsearch.vim/issues/138
	"call dein#add('https://github.com/haya14busa/incsearch.vim',    {'hook_add': '
	"	\ let g:incsearch#auto_nohlsearch = 1
	"	\| nmap / <Plug>(incsearch-forward)
	"	\| nmap ? <Plug>(incsearch-backward)
	"	\| nmap n <Plug>(incsearch-nohl-n)
	"	\| nmap N <Plug>(incsearch-nohl-N)'})

	" New pending operators, functions and motions
	call dein#add('https://github.com/tommcdo/vim-exchange')
	call dein#add('https://github.com/tpope/vim-commentary.git')
	call dein#add('https://github.com/tpope/vim-repeat')
	call dein#add('https://github.com/tpope/vim-surround')
	call dein#add('https://github.com/wellle/targets.vim')
	call dein#add('https://github.com/junegunn/vim-easy-align',      {'hook_add': 'nmap ga <Plug>(EasyAlign) | vmap ga <Plug>(EasyAlign)' })

	" New text objects
	call dein#add('https://github.com/kana/vim-textobj-user')
	call dein#add('https://github.com/thinca/vim-textobj-between')
	call dein#add('https://github.com/glts/vim-textobj-comment')
	call dein#add('https://github.com/kana/vim-textobj-entire')
	call dein#add('https://github.com/Julian/vim-textobj-variable-segment')
	call dein#add('https://github.com/rbonvall/vim-textobj-latex',   {'hook_add': '
				\  omap iE <Plug>(textobj-latex-environment-i)
				\| xmap iE <Plug>(textobj-latex-environment-i)
				\| omap aE <Plug>(textobj-latex-environment-a)
				\| xmap aE <Plug>(textobj-latex-environment-a)' })

	" Autocompletion plugins
	call dein#add('https://github.com/Shougo/deoplete.nvim',         {'on_path': '^\(.*term:\/\/\)\@!.*$', 'hook_add': 'inoremap <silent> <CR> <C-r>=My_cr_function()<CR>'})
	call dein#add('https://github.com/Shougo/neoinclude.vim',        {'depends': 'deoplete.nvim', 'on_path': '^\(.*term:\/\/\)\@!.*$'})
	call dein#add('https://github.com/zchee/deoplete-clang',         {'depends': 'deoplete.nvim', 'on_ft': ['c', 'cpp']})
	call dein#add('https://github.com/zchee/deoplete-go',            {'depends': 'deoplete.nvim', 'on_ft': ['go'], 'build': {'unix': 'make'}})
	call dein#add('https://github.com/zchee/deoplete-jedi',          {'depends': 'deoplete.nvim', 'on_ft': ['python']})
	call dein#add('https://github.com/carlitux/deoplete-ternjs',     {'depends': 'deoplete.nvim', 'on_ft': ['javascript']})
	call dein#add('https://github.com/Shougo/neco-vim',              {'depends': 'deoplete.nvim', 'on_ft': ['vim']})
	call dein#add('https://github.com/zchee/deoplete-zsh',           {'depends': 'deoplete.nvim', 'on_ft': ['sh', 'zsh'],
				\ 'hook_add': 'au FileType zsh au BufUnload <buffer> silent exec "!rm -f ~/.zcompdump_capture"'})

	" Tags generation
	call dein#add('https://github.com/ludovicchabant/vim-gutentags', {'hook_add': '
				\  let s:xdg_data_home = $XDG_DATA_HOME
				\| if s:xdg_data_home == ""
				\|     let s:xdg_data_home = $HOME . "/.local/share"
				\| endif
				\| let s:tag_dir = s:xdg_data_home . "/nvim/tags"
				\| if !isdirectory(s:tag_dir)
				\|     call mkdir(s:tag_dir,             "p")
				\| endif
				\| let g:gutentags_project_root = ["build.xml"]
				\| let g:gutentags_cache_dir = s:tag_dir'})

	" Snippets plugins
	call dein#add('https://github.com/Shougo/neosnippet.vim')
	call dein#add('https://github.com/Shougo/neosnippet-snippets')

	" Automatically build files and show errors
	call dein#add('https://github.com/neomake/neomake',              {'hook_add': "
				\  let g:neomake_error_sign   = {'text': '»', 'texthl': 'NeomakeErrorSign'}
				\| let g:neomake_warning_sign = {'text': '»', 'texthl': 'NeomakeWarningSign'}
				\| let g:neomake_message_sign = {'text': '»', 'texthl': 'NeomakeMessageSign'}
				\| let g:neomake_info_sign    = {'text': '»', 'texthl': 'NeomakeInfoSign'}
				\| let g:neomake_tex_enabled_makers = ['pdflatex']
				\| au BufWritePost * Neomake
				\| au User NeomakeFinished call UpdateLatexPdfDisplay()"})

	" Echoes documentation in the command line when possible
	call dein#add('https://github.com/Shougo/echodoc.vim',           {'hook_add': 'let g:echodoc_enable_at_startup = 1'})

	" Various language-specific plugins
	call dein#add('https://github.com/sheerun/vim-polyglot')
	call dein#add('https://github.com/shiracamus/vim-syntax-x86-objdump-d')
	call dein#add('https://github.com/ap/vim-css-color')

	" Complete matching pairs and be smart about it
	call dein#add('https://github.com/jiangmiao/auto-pairs')

	" Configures indentation settings
	call dein#add('https://github.com/tpope/vim-sleuth.git')

	" Rainbow parentheses
	call dein#add('https://github.com/kien/rainbow_parentheses.vim', {'hook_add': 'au BufEnter *.{clj,cljc} execute("RainbowParenthesesActivate") | execute("RainbowParenthesesLoadRound")'})

	" Git gud
	call dein#add('https://github.com/tpope/vim-fugitive',           {'on_path': '^\(.*term:\/\/\)\@!.*$'})

	call dein#end()
	call dein#save_state()
endif

" Denite
nnoremap Z :Denite buffer file_rec file_mru<CR>
nnoremap zh :Denite -default_action=split buffer file_rec file_mru<CR>
nnoremap zv :Denite -default_action=vsplit buffer file_rec file_mru<CR>
nnoremap zg :Denite grep:::!<CR>
nnoremap zt :Denite outline<CR>
" The two ifs here are a workaround to a windows bug.
if exists('*denite#custom#map()')
	call denite#custom#map('insert', '<C-n>', '<denite:move_to_next_line>', 'noremap')
	call denite#custom#map('insert', '<C-p>', '<denite:move_to_previous_line>', 'noremap')
endif
if exists('*denite#custom#var()')
	" Add wildignored patterns to denite's ignored patterns
	let wildignored_patterns = []
	for elem in split(&wildignore, ',')
		let elem = substitute(elem, '*.', '*', 'g')
		let wildignored_patterns += ['--ignore', tolower(elem)]
		let wildignored_patterns += ['--ignore', toupper(elem)]
	endfor
	call denite#custom#var('file_rec', 'command',
				\ ['ag', '--follow', '--nocolor', '--nogroup', '--hidden', '-g', '',
				\ '--ignore-dir', '.git/',    '--ignore-dir', '.hg/',          '--ignore-dir', '.bzr/',
				\ '--ignore-dir', '.svn/',    '--ignore-dir', 'undodir/',      '--ignore-dir', 'images/',
				\ '--ignore-dir', 'fonts/',   '--ignore-dir', 'music/',        '--ignore-dir', 'img/',
				\ '--ignore-dir', '.mozilla/','--ignore-dir', 'node_modules/', '--ignore-dir', 'img/',
				\ '--ignore-dir', 'bundle/',  '--ignore-dir', 'spell/',        '--ignore-dir', '.cache/',
				\ '--ignore-dir', 'swapdir/', '--ignore-dir', '.metadata/'] + wildignored_patterns)
endif

" Neosnippets
imap <expr> <Tab> exists('*neosnippet#expandable_or_jumpable()') && neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_jump_or_expand)" : "\<Tab>"
let g:neosnippet#disable_runtime_snippets = {'_' : 1}
let g:neosnippet#snippets_directory= [ s:config_dir . '/custom_snippets' , s:bundle_dir . '/repos/github.com/Shougo/neosnippet-snippets/neosnippets']

" Deoplete
" <CR> when autocompleting creates a new line
function! My_cr_function() abort
	return deoplete#close_popup() . "\<CR>"
endfunction
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_smart_case = 1
let g:deoplete#auto_complete_delay = 0
if !exists('g:deoplete#omni_patterns')
	let g:deoplete#omni_patterns = {}
end
let g:deoplete#omni_patterns.erlang = [
			\ '[^. *\t]:\w*',
			\ '^\s*-\w*'
			\ ]
let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.erlang = 'erlang_complete#Complete'
let g:deoplete#sources = {}
let g:deoplete#sources._ = []
let g:deoplete#sources#clang#libclang_path=system("find /usr/lib64/ -name libclang.so -print -quit")[0:-2]
let g:deoplete#sources#clang#clang_header="/usr/lib64/clang/"
let g:deoplete#sources#go#gocode_binary=$HOME . "/.gopath/bin/gocode"

