" Jetpacka install plugins
call plug#begin()

" color theme
Plug 'ulwlu/elly.vim'
Plug 'morhetz/gruvbox'
Plug 'EdenEast/nightfox.nvim'
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

" tab bar
" Plug 'nanozuki/tabby.nvim'
Plug 'akinsho/bufferline.nvim'

" status bar
Plug 'nvim-lualine/lualine.nvim'
Plug 'kyazdani42/nvim-web-devicons'

" editor
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jeetsukumaran/vim-indentwise'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'ntpeters/vim-better-whitespace'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim', { 'do': { -> fzf#install() } }
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'ron-rs/ron.vim'
" Plug 'SirVer/ultisnips'
Plug 'easymotion/vim-easymotion'
Plug 'andrewradev/linediff.vim'

Plug 'kyazdani42/nvim-tree.lua'

" Git
Plug 'airblade/vim-gitgutter'

" test
Plug 'vim-test/vim-test'
Plug 'tpope/vim-dispatch'

" tmux
Plug 'christoomey/vim-tmux-navigator'

"""""""""""""""""""""
" Language specific "
"""""""""""""""""""""
" LSP
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Golang
Plug 'mattn/vim-goimports'
" YAML
Plug 'neoclide/coc-yaml'

call plug#end()

set encoding=UTF-8
set number
set clipboard+=unnamed
set tabstop=4
set shiftwidth=4
set noswapfile
set nobackup
set noundofile
set re=0

" neovim-remote
let nvrcmd      = "nvr --remote-wait"
let $VISUAL     = nvrcmd
let $GIT_EDITOR = nvrcmd

autocmd FileType netrw setl bufhidden=wipe
let g:netrw_fastbrowse = 0

" theme
let g:catppuccin_flavour = 'frappe'
lua << EOF
require('catppuccin').setup {
  integarations = {
  	coc_nvim = true,
	gitgutter = true,
	nvimtree = true,
	bufferline = true,
  },
}
EOF
colorscheme catppuccin
set termguicolors

let g:linediff_diffopt='iwhite'

lua << EOF
require('lualine').setup {
  options = {
	  theme = 'catppuccin',
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = {
      { 'mode', separator = { left = '' }, right_padding = 2 },
    },
    lualine_b = {
      { 'filetype', icon_only = true, separator = { left = '' } },
      { 'filename', path = 1, symbols = {
          modified = ' ', readonly = ' ', unnamed = '...', newfile = ' ',
      }},
    },
    lualine_c = { 'diagnostics' },
    lualine_x = {
      { 'branch', separator = { left = '' } },
      'diff',
    },
    lualine_y = { 'filetype', 'encoding', 'fileformat', 'progress' },
    lualine_z = {
      { 'location', separator = { right = '' }, left_padding = 2 },
    },
  },
  inactive_sections = {
    lualine_a = { 'filename' },
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { 'location' },
  },
  tabline = {},
  extensions = {},
}
require('bufferline').setup {
  options = {
    offsets = {
      {
        filetype = "NvimTree",
        text = function()
        return vim.fn.getcwd()
        end,
        highlight = 'Directory',
        text_align = 'left',
      }
    },
    separator_style = 'slant',
    highlight = {gui = "underline", guisp = "blue"},
	diagnostics = 'coc',
    diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local icon = level:match("error") and " " or " "
      return " " .. icon .. count
    end,
  }
}
require('nvim-tree').setup()
EOF

"
" coc.nvim
"
" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <space> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <Space>rn <Plug>(coc-rename)

" Formatting selected code.

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <Space>a  <Plug>(coc-codeaction-selected)
nmap <Space>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <Space>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <Space>.  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <Space>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let g:coc_global_extensions = [
  \ 'coc-yaml',
  \ 'coc-toml',
  \ 'coc-json',
  \ 'coc-html',
  \ 'coc-prettier',
  \ 'coc-eslint',
  \ 'coc-tsserver',
  \ 'coc-docker',
  \ 'coc-go',
  \ 'coc-diagnostic',
  \ ]

"
" FZF
"
command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, {'source': 'ag --hidden --ignore .git -g ""'}, <bang>0)
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --no-heading --color=always --smart-case --hidden -- '.shellescape(<q-args>), 1,
  \   fzf#vim#with_preview(), <bang>0)

let g:fzf_action = {
  \ 'ctrl-y': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ }

"
" vim-test
"
let test#strategy='dispatch'
let test#go#runner='gotest'
let test#vim#term_position='belowright'

"
" fern.vim
"
let g:fern#renderer = "nerdfont"
let g:fern#default_hidden=1

"
" my keyboar mapping
"
let mapleader = ","
nmap <silent> <S-Tab> :BufferLineCyclePrev<CR>
nmap <silent> <Tab> :BufferLineCycleNext<CR>
nmap <silent> <Space>bd :CloseBufferWithoutClosingWindow<CR>
" nmap <silent> [h <Plug>(IndentWisePreviousLesserIndent)
nmap <silent> <c-[> <Plug>(IndentWisePreviousEqualIndent)
" nmap <silent> [l <Plug>(IndentWisePreviousGreaterIndent)
" nmap <silent> ]h <Plug>(IndentWiseNextLesserIndent)
nmap <silent> <c-]> <Plug>(IndentWiseNextEqualIndent)
" nmap <silent> ]l <Plug>(IndentWiseNextGreaterIndent)
" nmap <silent> <Space>[_ <Plug>(IndentWisePreviousAbsoluteIndent)
" nmap <silent> <Space>]_ <Plug>(IndentWiseNextAbsoluteIndent)
nmap <silent> [% <Plug>(IndentWiseBlockScopeBoundaryBegin)
nmap <silent> ]% <Plug>(IndentWiseBlockScopeBoundaryEnd)
nmap <silent> <Space>tt :CocCommand go.test.toggle<CR>
nnoremap <silent> <Space>fs :Files<CR>
nnoremap <silent> <Space>rg :Rg<CR>
xmap <Space>ff <Plug>(coc-format-selected)
nmap <Space>ff :Format<CR>
nmap <Space>ft :NvimTreeToggle<CR>
nmap <Space>ev :e ~/.vimrc<CR>
nmap <Space>sv :source ~/.vimrc<CR>
nmap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nmap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
nmap <silent><nowait><expr> j coc#float#has_scroll() ? coc#float#scroll(1, 1) : "\j"
nmap <silent><nowait><expr> k coc#float#has_scroll() ? coc#float#scroll(0, 1) : "\k"
nmap <silent><nowait><expr> <ESC> coc#float#has_scroll() ? coc#float#close_all() : "\<ESC>"
vnoremap <silent> <C-a> :s/\%V-\=\d\+/\=submatch(0)+1/g<CR>
vnoremap <silent> <C-x> :s/\%V-\=\d\+/\=submatch(0)-1/g<CR>
nmap <Space>ww <Plug>(easymotion-w)

"
" my functions
"
function! s:ShowErr(msg)
  echohl ErrorMsg
  echo a:msg
  echohl NONE
endfunction

function! s:CloseBufferWithoutClosingWindow(bang, buffer)
" detect target which you want to close
  if empty(a:buffer)          " current window
    let target = bufnr('%')
  elseif a:buffer ~= '^\d\+$' " buffer number specified
    let target = bufnr(str2nr(a:buffer))
  else                        " buffer name
    let target = bufnr(a:buffer)
  endif
  if target < 0
    call s:ShowErr('No buffer:' . a:buffer)
    return
  endif
  if empty(a:bang) && getbufvar(a:buffer, '&modified')
    call s:ShowErr('Now editing. Please save:' . a:buffer)
    return
  endif
  let windows = filter(range(1, winnr('$')), 'winbufnr(v:val) == target')
  if len(windows) > 1
    call s:ShowErr('Other windows use this buffer')
    return
  endif
  let currentWindow = winnr()
  for w in windows
    execute w.'wincmd w'
    let prevBuf = bufnr('#')
    echo prevBuf
    if prevBuf > 0 && buflisted(prevBuf) && prevBuf != target
      buffer #
    else
      bprevious
    endif
    if target == bufnr('%') " window has only current buffer
      execute 'enew' . a:bang
    endif
  endfor
  execute 'bdelete' . a:bang . ' ' . target
  execute currentWindow.'wincmd w'
endfunction
command! -bang -complete=buffer -nargs=? CloseBufferWithoutClosingWindow call <SID>CloseBufferWithoutClosingWindow(<q-bang>, <q-args>)
