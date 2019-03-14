" Nathan Smith's vim configuration


" Overarching Philosophy:
" 1. Prefer the defaults
"
"
"
"
"

" Normally `:set nocp` is not needed, because it is done automatically
" when .vimrc is found.
if &compatible
  " `:set nocp` has many side effects. Therefore this should be done
  " only when 'compatible' is set.
  set nocompatible
endif


" Reset the cursor on exit
" See https://github.com/neovim/neovim/issues/4867#issuecomment-291249173
" and https://github.com/neovim/neovim/wiki/FAQ#cursor-style-isnt-restored-after-exiting-nvim
:au VimLeave * set guicursor=a:ver25-blinkon1

" Map leader
let mapleader = " "

" Disable arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Color Defaults
set background=dark
set termguicolors

" Searching
" Case insensitive by default, case sensitive with an uppercase char
set ignorecase
set smartcase

" Line Numbers
set number

" Whitespace characters settings
" refs:
" - http://vimcasts.org/episodes/tabs-and-spaces/
" - http://vimcasts.org/episodes/show-invisibles/
" View tabs as 2 spaces wide
set tabstop=2
" Ident by 2:
set shiftwidth=2
" Use spaces instead of tabs
set expandtab
" Tab to the current indent level
set smarttab
" Show whitespace characters
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮,trail:·,nbsp:·,space:·


" Buffers
" ref: http://vimcasts.org/episodes/working-with-buffers/
" Enables to switch between unsaved buffers and keep undo history
set hidden

" Windows
" ref: http://vimcasts.org/episodes/working-with-windows/
"


" More sensible window splits
set splitbelow
set splitright
" Split help windows vertically, on the right
autocmd FileType help wincmd L

" Use system clipboard
set clipboard+=unnamed

" grep with ripgrep
" https://github.com/BurntSushi/ripgrep
" if executable('rg')
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case
set grepformat=%f:%l:%c:%m
" endif

set mouse=a

" Spell checking
" refs:
" - http://vimcasts.org/episodes/spell-checking/
" Spell file location
set spellfile=~/.config/nvim/spell/dictionary.utf-8.add
" 'Murican English
set spelllang=en_us
" No spelling by default
" Toggable by keyboard settings in unimpaired
" [os to enable
" ]os to disable
" =os to toggle
set nospell

" Config comman
command! Config execute ":vsplit $MYVIMRC"
" Auto source vimrc on save
" autocmd bufwritepost init.vim source $MYVIMRC

" Default to all code unfolded
set foldlevel=99

" Autosave on InsertLeave, TextChanged, or buffer change, etc.
" Inspired by https://github.com/907th/vim-auto-save/
" ref: https://vi.stackexchange.com/questions/2545/how-can-i-run-an-autocmd-when-starting-vim-with-no-file-a-non-existing-file-or
" if @% != ""
"   autocmd InsertLeave * update
"   autocmd TextChanged * update
"   set autowrite
" end

" ==================================================
" Plugins
" Package manager: Minpac, https://github.com/k-takata/minpac
" ref: Modern Vim, tip 6
" ==================================================
" Easy to use commands
packadd minpac

command! PacInstall source $MYVIMRC | call minpac#update('', {'do': 'call minpac#status()'})
command! PacClean source $MYVIMRC | call minpac#clean()
command! PacStatus source $MYVIMRC | call minpac#status()

if exists('*minpac#init')
  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " Types of Plugins
  " Improvements: Overwrite Vim's default behaviour
  " Extensions: Extend Vim's functionality

  " Color Scheme
  call minpac#add('tyrannicaltoucan/vim-quantum')
  colorscheme quantum
  let g:quantum_italics=1

  " Sensible defaults
  " See https://github.com/tpope/vim-sensible for the full list
  " Use <C-L> to turn off highlighting after search
  call minpac#add('tpope/vim-sensible')

  " Easy commenting
  " This really should be a default, I don't know where I'd be without it
  call minpac#add('tpope/vim-commentary')

  " Quoting/Parenthesis made simple
  " Also should be a default
  call minpac#add('tpope/vim-surround')

  " Use `.` for plugins (Like commentary and surround)
  call minpac#add('tpope/vim-repeat')

  " Easier shortcuts for lots of miscellanea
  call minpac#add('tpope/vim-unimpaired')

  " Autodetect indentation
  " call minpac#add('tpope/vim-sleuth')

  " Git commands in Vim
  call minpac#add('tpope/vim-fugitive')
  " Fugitive extensions for GitHub
  call minpac#add('tpope/vim-rhubarb')

  " Pluses and minuses in the sidebar!
  call minpac#add('airblade/vim-gitgutter')

  " Editorconfig support
  call minpac#add('editorconfig/editorconfig-vim')
  " Make editorconfig play nice with Fugitive
  let g:EditorConfig_exclude_patterns = ['fugitive://.*']

  " Return to the last cursor position of a file on reopen.
  " Similar to commands like those in Gary Berhardt's dotfiles and :help last-position-jump,
  " but a little more fully featured
  " See for details:
  " https://vim.fandom.com/wiki/Restore_cursor_to_file_position_in_previous_editing_session
  call minpac#add('farmergreg/vim-lastplace')

  " Helpful character metadata on `ga` 😍
  call minpac#add('tpope/vim-characterize')

  " Ctrl-a, ctrl-x for dates, times, etc.
  call minpac#add('tpope/vim-speeddating')

  " Dash Integration
  call minpac#add('rizzatti/dash.vim')

  " Fuzzy finding with FZF
  " refs:
  " - https://github.com/junegunn/fzf
  " - https://github.com/junegunn/fzf.vim
  " Source FZF from the homebrew install
  set rtp+=/usr/local/opt/fzf
  call minpac#add('junegunn/fzf.vim')
  " Using FZF
  nnoremap <silent> <leader>p :Files<CR>
  nnoremap <silent> <leader>b :Buffers<CR>


  " Airline Status Bar
  " ref: https://github.com/vim-airline/vim-airline
  call minpac#add('vim-airline/vim-airline')
  " Enable buffer tab line
  let g:airline#extensions#tabline#enabled = 1
  " Square buffer tabs
  let g:airline#extensions#tabline#left_sep = ' '
  let g:airline#extensions#tabline#left_alt_sep = '|'
  " Tab path formatting
  let g:airline#extensions#tabline#formatter = 'jsformatter'
  let g:airline_theme='quantum'

  " Rainbow Parentheses
  " There are many different plugins out there for rainbow parentheses, this one is the most
  " maintained.
  " refs: https://github.com/luochen1990/rainbow
  " call minpac#add('luochen1990/rainbow')
  let g:rainbow_active = 1
  let g:rainbow_conf = {
  \  'guifgs': ['#ffd700', '#da70d6', '#87cefa']
  \}

  " ALE
  call minpac#add('w0rp/ale')
  let g:ale_fix_on_save = 1
  let g:airline#extensions#ale#enabled = 1
  let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint', 'prettier'],
\   'typescript': ['eslint', 'prettier'],
\   'javascript.jsx': ['eslint', 'prettier'],
\   'typescript.tsx': ['eslint', 'prettier'],
\   'css': ['prettier'],
\   'scss': ['prettier'],
\   'less': ['prettier'],
\   'md': ['prettier'],
\   'json': ['prettier'],
\   'graphql': ['prettier'],
\}
  let g:ale_linter_aliases = {'typescriptreact': 'typescript'}
  let g:ale_javascript_eslint_suppress_missing_config = 1

  "
  " Languages
  " Most of these are from vim-polyglot
  " (https://github.com/sheerun/vim-polyglot)
  "
  " Markdown
  " TODO: evaluate whether plasticboy's repo is worth using
  " https://github.com/plasticboy/vim-markdown
  " call minpac#add('tpope/vim-markdown')
  " let g:markdown_fenced_languages = ['coffee', 'css', 'erb=eruby', 'javascript', 'js=javascript', 'ruby', 'sass', 'xml', 'html']

  " C improvements
  call minpac#add('vim-scripts/aftersyntaxc.vim')
  " Fish
  call minpac#add('dag/vim-fish')
  " HTML
  call minpac#add('othree/html5.vim')
  " CSS
  call minpac#add('JulesWang/css.vim')
  " call minpac#add('hail2u/vim-css3-syntax')
  " Sass
  call minpac#add('cakebaker/scss-syntax.vim')
  " Less
  call minpac#add('groenewege/vim-less')
  " Better JS support (indent, syntax, etc)
  call minpac#add('pangloss/vim-javascript')
  " JSX syntax
  call minpac#add('mxw/vim-jsx', { 'for': ['jsx', 'javascript.jsx'] })
  " JSDoc generation
  call minpac#add('heavenshell/vim-jsdoc')
  " CSS-in-JS Support
  call minpac#add('styled-components/vim-styled-components', {'branch': 'main'})
  " TypeScript Syntax
  " call minpac#add('leafgarland/typescript-vim')
  call minpac#add('HerringtonDarkholme/yats.vim') " YATS is better
  " TSX Support
  " call minpac#add('ianks/vim-tsx')
  " call minpac#add('peitalin/vim-jsx-typescript')
  " Add Flow support
  call minpac#add('flowtype/vim-flow')
  " JSON
  call minpac#add('elzr/vim-json')
  " GraphQL
  call minpac#add('jparise/vim-graphql')

else
  colorscheme elflord

endif
