local M = {}
local fn = vim.fn
local api = vim.api
local common = require'nvim-lines.common'

local _mode_map = vim.g.line_mode_map or {}
local line_mode_map = {
    ['n'] = _mode_map['n'] or "NORMAL",
    ['v'] = _mode_map['v'] or "VISUAL",
    ['V'] = _mode_map['V'] or "V-LINE",
    [''] = _mode_map[''] or "V-CODE",
    ['i'] = _mode_map['i'] or "INSERT",
    ['R'] = _mode_map['R'] or "R",
    ['r'] = _mode_map['r'] or "R",
    ['Rv'] = _mode_map['Rv'] or "V-REPLACE",
    ['c'] = _mode_map['c'] or "CMD-IN",
    ['s'] = _mode_map['s'] or "SELECT",
    ['S'] = _mode_map['S'] or "SELECT",
    [''] = _mode_map[''] or "SELECT",
    ['t'] = _mode_map['t'] or "TERMINAL"
}
local line_statusline_getters = vim.g.line_statusline_getters or {}
local line_unnamed_filename = vim.g.line_unnamed_filename or '[unnamed]'
local percent_bar = vim.g.line_percent_bar or {
   '░░░',
   '▒░░',
   '█░░',
   '█▒░',
   '██░',
   '██▒',
   '███',
}
local barlen = #percent_bar
local statusline_headsymbol = vim.g.line_statusline_headsymbol or '▒'

local function get_filename()
    local name = fn.fnamemodify(fn.bufname(), ":~:.")
    local cwd = fn.fnamemodify(fn.getcwd(-1)  .. '/', ":~:.")
    return common.get_fileicon(api.nvim_eval("&ft"), fn.bufname('%')) .. string.gsub(name, cwd, "")
end

function M.set_statusline(...)
    local infos = {}
    table.insert(infos, { hl = 'VimLine_Light', text = statusline_headsymbol .. ' ' .. line_mode_map[fn.mode()] .. ' ' })
    table.insert(infos, { hl = common.get_powerline_hl(next(infos) ~= nil and 'VimLine_Light_Dark' or 'VimLine_Light_None'), text = common.get_powerline_text('light_right') })

    for _,getter in pairs(line_statusline_getters) do
        table.insert(infos, { hl = 'VimLine_Dark', text = '%{' .. getter .. '()}' })
        if next(line_statusline_getters, _) == nil then
            table.insert(infos, { hl = common.get_powerline_hl('VimLine_Dark_None'), text = common.get_powerline_text('light_right') })
        else
            table.insert(infos, { hl = common.get_powerline_hl('VimLine_Dark_Break'), text = common.get_powerline_text('dark_right') })
        end
    end

    table.insert(infos, { text = '%<' })
    table.insert(infos, { hl = 'VimLine_None' })
    table.insert(infos, { text = '%=' })
    table.insert(infos, { hl = common.get_powerline_hl('VimLine_Dark_None'), text = common.get_powerline_text('light_left') })
    table.insert(infos, { hl = 'VimLine_Dark', text =  string.format(' %s ', get_filename()) })
    table.insert(infos, { hl = common.get_powerline_hl('VimLine_Light_Dark'), text = common.get_powerline_text('light_left') })
    table.insert(infos, { hl = 'VimLine_Light', text = ' %l:%L:%v ' })
    table.insert(infos, { hl = 'VimLine_Light', text = percent_bar[math.ceil(barlen * fn.line('.') / fn.line('$'))] })
    table.insert(infos, { hl = 'VimLine_None' })

    local statusline = ''
    for _,info in pairs(infos) do
        statusline = statusline .. common.info_to_text(info)
    end
    return statusline
end

return M
