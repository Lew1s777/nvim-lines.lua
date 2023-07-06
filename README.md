# NVIM LINES LUA

Fork of [nvim-lines.lua](https://github.com/yaocccc/nvim-lines.lua),but with out of the box config.

simple statusline & tabline plug of nvim  

This plugin requires neovim nightly (>=0.5.0).

![avatar](https://github.com/yaocccc/nvim-lines.lua/raw/master/screenshots/line1.png)

show custom statusline and tabline  

![show](https://github.com/yaocccc/nvim-lines.lua/raw/master/screenshots/show.gif)

## EXAMPLE CONFIG

./init.vim
```vimscript
call plug#begin('~/.config/nvim/plugged')
    Plug 'yaocccc/nvim-lines.lua'
call plug#end()
lua require'nvim-lines'
```

./lua/nvim-lines.lua
```lua
vim.g.line_powerline_enable = 1
vim.g.line_nerdfont_enable = 1
vim.g.line_unnamed_filename='~'
vim.g.line_statusline_getters = {'v:lua.GitInfo', 'v:lua.CocErrCount', 'v:lua.GetFt'}
-- git status base by coc-git
function GitInfo()
    local branch = vim.g.coc_git_status or ''
    local diff = vim.b.coc_git_status or ''
    return (string.len(branch) > 0 and string.format(" %s ", branch) or " none ")
        .. (string.len(diff) > 0 and string.format('%s ', vim.fn.trim(diff)) or '')
end
-- diagnostic info base by coc
function CocErrCount()
    local coc_diagnostic_info = vim.b.coc_diagnostic_info or { error = 0 }
    return string.format(' E%d ', coc_diagnostic_info.error)
end
-- show ft
function GetFt()
    local ft = vim.api.nvim_eval('&ft')
    return string.format(' %s ', string.len(ft) > 0 and ft or '~')
end
```

## options

```options
default_options
  let g:line_statusline_enable = 1          # statusline on/off
  let g:line_tabline_enable = 1             # tabline    on/off
  let g:line_powerline_enable = 0           # statusline & tabline show powerline font
  let g:line_nerdfont_enable = 0            # statusline & tabline show nerd font
  let g:line_dclick_interval = 100          # tabline    dclick can close buffer
  let g:line_modi_mark = '+'                # tabline    modified mark
  let g:line_unnamed_filename = '[unnamed]' # statusline & tabline unnamed filename
  let g:line_statusline_getters = []        # statusline extra some info on statusline getters
  let g:line_mode_map = {"n": "NORMAL",     # statusline mode & display map
                      \  "v": "VISUAL",
                      \  "V": "V-LINE",
                      \  "\<c-v>": "V-CODE",
                      \  "i": "INSERT",
                      \  "R": "R",
                      \  "r": "R",
                      \  "Rv": "V-REPLACE",
                      \  "c": "CMD-IN",
                      \  "s": "SELECT",
                      \  "S": "SELECT",
                      \  "\<c-s>": "SELECT",
                      \  "t": "TERMINAL"}
  let g:line_hl = { 'none': 'NONE', 'light': '24', 'dark': '238', 'break': '244', 'space': '238' } # highlight config
  let g.line_percent_bar = [                # statusline percent_bar symbols
    \   '░░░',
    \   '▒░░',
    \   '█░░',
    \   '█▒░',
    \   '██░',
    \   '██▒',
    \   '███'
    \ ]
  let g.line_statusline_headsymbol = '▒'    # statusline head symbol
  let g.line_tabline_headsymbol = '▒'       # tabline head symbol
```

```usage
if you want to add something to you statusline:

Example:
  let g:line_statusline_getters = ['CocErrCount', 'GitStatus', 'GitInfo']

  coc-diagnostic:
    func! CocErrCount()
        let l:info = get(b:, 'coc_diagnostic_info', {})
        return printf(' E%d ', get(l:info, 'error', 0))
    endf
  vim-gitgutter:
    function! GitStatus()
        let [a,m,r] = GitGutterGetHunkSummary()
        return printf(' +%d ~%d -%d ', a, m, r)
    endfunction
  coc-git:
    func! GitInfo()
        let l:head = get(g:, 'coc_git_status', '')
        let l:head = l:head != '' ? printf(' %s ', l:head) : ''
        let l:status = get(b:, 'coc_git_status', '')
        let l:status = l:status != '' ? printf('%s ', trim(l:status)) : ''
        return l:head . l:status
    endf
  vim-fugitive:
    add 'FugitiveStatusline' to g:line_statusline_getters
  ...
```


## ENJOY IT

## Support

***This is a supporting message from [the original author](https://github.com/yaocccc)***

<a href="https://www.buymeacoffee.com/yaocccc" target="_blank">
  <img src="https://github.com/yaocccc/yaocccc/raw/master/qr.png">
</a>

<br>

<a href="https://www.buymeacoffee.com/yaocccc" target="_blank">
  <img src="https://cdn.buymeacoffee.com/buttons/v2/default-violet.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 200px !important;" >
</a>
