local M = {}
local fn, api, loop = vim.fn, vim.api, vim.loop
local space = ' '

--- Vim mode words and Highlights
---@return table
-- stylua: ignore start
local mode = setmetatable({
	n        = { 'N', '%#StatusLineNormal#' },
	no       = { 'N', '%#StatusLineNormal#' },
	v        = { 'V', '%#StatusLineVisual#' },
	V        = { 'VL', '%#StatusLineVisual#' },
	['\x16'] = { 'VB', '%#StatusLineVisual#' },
	s        = { 'S', '%#StatusLineVisual#' },
	S        = { 'SL', '%#StatusLineVisual#' },
	['\x13'] = { 'SB', '%#StatusLineVisual#' },
	i        = { 'I', '%#StatusLineInsert#' },
	ic       = { 'I', '%#StatusLineInsert#' },
	ix       = { 'I', '%#StatusLineInsert#' },
	R        = { 'R', '%#StatusLineReplace#' },
	Rv       = { 'VR', '%#StatusLineReplace#' },
	c        = { 'C', '%#StatusLineCommand#' },
	cv       = { 'Vim Ex', '%#StatusLineCommand#' },
	ce       = { 'Ex', '%#StatusLineCommand#' },
	r        = { 'P', '%#StatusLineCommand#' },
	rm       = { 'More', '%#StatusLineCommand#' },
	['!']    = { 'SH', '%#StatusLineCommand#' },
	t        = { 'T', '%#StatusLineTerminal#' },
}, {
	__index = function(t, k)
		return t[k:sub(1, 1)] or t['n']
	end,
})
-- stylua: ignore end

--- For file is not exist in your computer
--- @return boolean
local function is_tmp_file()
	-- local filename = fn.expand('%:p')
	local bufname = api.nvim_buf_get_name(0) -- use the nvim api
	local pluginfiletype = { 'alpha', 'startify', 'vim-plug', 'agit', 'agit_diff', 'agit_stat', 'vista' }
	local temp_file = fn.index(pluginfiletype, vim.bo.filetype)
	local preview_window = vim.wo.previewwindow -- use the nvim api
	if vim.bo.buftype ~= '' then
		return true
	elseif bufname:match('^/tmp') or bufname:match('^fugitive:') then
		return true
	elseif preview_window then
		return true
	else
		return temp_file > -1 and true or false
	end
end

--- for quickfix settings
--- @param winid integer|nil
--- @return string
local function quickfix(winid)
	winid = winid or api.nvim_get_current_win()
	local qf_type = fn.getwininfo(winid)[1].loclist == 1 and 'loc' or 'qf'
	local what = { nr = 0, size = 0 }
	local info = qf_type == 'loc' and fn.getloclist(0, what) or fn.getqflist(what)
	what = { nr = '$' }
	local nr = (qf_type == 'loc' and fn.getloclist(0, what) or fn.getqflist(what)).nr
	local prefix = qf_type == 'loc' and 'Location' or 'Quickfix'
	local title = vim.w[winid].quickfix_title or ''
	return ('%s (%d/%d) [%d] %s'):format(prefix, info.nr, nr, info.size, title)
end

--- for file icon
--- @return string
local function icon_append()
	local ok, devicons = pcall(require, 'nvim-web-devicons')
	if ok then
		local icon_str, icon_color = devicons.get_icon_color(
			fn.expand('%:t'),
			nil, -- extension is already computed by nvim-web-devicons
			{ default = true }
		)
		api.nvim_set_hl(0, 'StatusLineIcon', { fg = icon_color, bg = '#242a32' })
		return '%#StatusLineIcon#' .. icon_str .. space
	else
		return ''
	end
end

--- file name module
--- @param width integer
--- @return string
local function filename(width)
	local bufname = api.nvim_buf_get_name(0)
	local fugitive_name = vim.b.fugitive_fname
	if not fugitive_name then
		if bufname:match('^fugitive:') and fn.exists('*FugitiveReal') == 1 then
			fugitive_name = fn.fnamemodify(fn.FugitiveReal(bufname), ':t') .. ' '
			vim.b.fugitive_fname = fugitive_name
		end
	end

	local fname, fileicon
	local path = fn.expand('%:~:.')
	local bt = vim.bo.bt
	if fugitive_name then
		fname = fugitive_name
	elseif bufname == '' and bt == '' then
		fname = '[No Name]'
	elseif bt == 'quickfix' then
		fname = quickfix():sub(1, width * 2 / 3)
	elseif is_tmp_file() then
		fname = ''
	else
		fname = fn.expand('%:t')
		local ft = vim.bo.ft
		if fn.expand('%:e') == '' or ft == '' then
			if ft ~= '' then
				fileicon = icon_append()
				fname = ('%s (%s)'):format(fname, ft)
			end
		end
	end
	if bt == '' then
		fname = (#path > width / 2 and fname or path) .. ' %m'
		fileicon = icon_append()
	end
	return (fileicon and fileicon or '')
		.. '%#StatusLine'
		.. (vim.bo.modified and 'FileModified#' or 'FileName#')
		.. fname
		.. '%#StatusLine#'
end

--- readonly symbol
--- @param bufnr integer
--- @return string
local function readonly(bufnr)
	local ret
	if vim.bo[bufnr].readonly then
		ret = loop.fs_stat(api.nvim_buf_get_name(bufnr or 0)) and '' or '󰌿'
	end
	if ret then
		return ret
	else
		return ''
	end
end

--- for native lsp diagnostic
--- @return string|nil
local function lsp_diagnostic()
	local ret
	local list = {}
	local has_vim_diagnostics, _ = pcall(require, 'vim.diagnostic')
	local e, w, i, h
	if has_vim_diagnostics then
		local res = { 0, 0, 0, 0 }
		for _, diagnostic in ipairs(vim.diagnostic.get(0)) do
			res[diagnostic.severity] = res[diagnostic.severity] + 1
		end
		e = res[vim.diagnostic.severity.ERROR]
		w = res[vim.diagnostic.severity.WARN]
		i = res[vim.diagnostic.severity.INFO]
		h = res[vim.diagnostic.severity.HINT]
	end
	if e > 0 then
		local error = '' .. space .. e
		table.insert(list, '%#StatusLineError#' .. error)
	end
	if w > 0 then
		local warning = '' .. space .. w
		table.insert(list, '%#StatusLineWarning#' .. warning)
	end
	if i > 0 then
		local information = '' .. space .. i
		table.insert(list, '%#StatusLineInformation#' .. information)
	end
	if h > 0 then
		local hint = '' .. space .. h
		table.insert(list, '%#StatusLineHint#' .. hint)
	end
	if list then
		ret = table.concat(list, space) .. '%#StatusLine#'
	end
	return ret or nil
end

--- for pr_status
--- @return string|nil
local function pr_status()
	local has_pr_status, github_pr = pcall(require, 'pr_status')
	if has_pr_status then
		local status = github_pr.get_last_result_string()
		return status or ''
	end
	return nil
end

--- for gitsigns.nvim  
--- @return string
local function gitsigns()
	local ret
	--- @type table
	--- @diagnostic disable-next-line: undefined-field
	local ginfo = vim.b.gitsigns_status_dict
	if ginfo then
		local branch = ginfo.head
		local list = { '%#StatusLineBranch#' .. space .. '' .. branch }
		local add = ginfo.added
		local change = ginfo.changed
		local remove = ginfo.removed
		if add and add > 0 then
			table.insert(list, '%#StatusLineHunkAdd#+' .. add)
		end
		if change and change > 0 then
			table.insert(list, '%#StatusLineHunkChange#~' .. change)
		end
		if remove and remove > 0 then
			table.insert(list, '%#StatusLineHunkRemove#-' .. remove)
		end
		ret = table.concat(list, space) .. space .. '%#StatusLine#'
	end
	return ret or '%#StatusLine#'
end

--- for file_size deliver
--- @param file string|string[]
--- @return string|nil
local function file_size(file)
	local size = fn.getfsize(file)
	local FileSize
	if size == 0 or size == -1 or size == -2 then
		return nil
	end
	if size < 1024 then
		FileSize = size .. 'B'
	elseif size < 1024 * 1024 then
		FileSize = string.format('%0.1f', size / 1024) .. 'KB'
	elseif size < 1024 * 1024 * 1024 then
		FileSize = string.format('%0.1f', size / 1024 / 1024) .. 'MB'
	else
		FileSize = string.format('%0.1f', size / 1024 / 1024 / 1024) .. 'GB'
	end
	return '' .. space .. FileSize
end

--- get file size
--- @return string|nil
local function get_file_size()
	local file = fn.expand('%:p')
	if not file_size(file) then
		return nil
	end
	return '%#StatusLineFileSize#' .. space .. file_size(file)
end

--- for file encoding    whether it is utf-8 or not
--- @return string|nil
local function encoding()
	local enc = vim.opt.fileencoding:get()
	if enc == 'utf-8' then
		return nil
	else
		return enc
	end
end

--- for OS   󰀶
--- @return string|nil
local function fileformat(bufnr)
	local icon
	if vim.bo[bufnr].fileformat == 'unix' then
		icon = jit.os == 'OSX' and '%#StatusLineApple#' or '%#StatusLineLinux#'
	else
		icon = '%#StatusLineWindows#'
	end
	return bufnr == 0 and icon .. '%#StatusLine#' or icon
end

--- for spell and paste mode check
--- @return string|nil
local function checkmode()
	local ret
	if vim.wo.spell == true then
		ret = 'SPELL'
	elseif vim.o.paste == true then
		ret = 'PASTE'
	else
		ret = ''
	end
	return ret
end

--- statusline module
--- @return string
function M.statusline()
	local stl = {}
	local curmode = vim.fn.mode()
	local mode_name, mode_highlight = unpack(mode[curmode])
	local width = api.nvim_win_get_width(vim.g.statusline_winid)

	if api.nvim_get_current_win() == vim.g.statusline_winid then
		table.insert(stl, mode_highlight)
		table.insert(stl, mode_name .. checkmode())
		table.insert(stl, gitsigns())
		table.insert(stl, filename(width) .. readonly(0) .. '%<')

		table.insert(stl, '%=')

		if pr_status() then
			table.insert(stl, pr_status())
		end
		table.insert(stl, fileformat(0))
		if encoding() then
			table.insert(stl, encoding())
		end
		if lsp_diagnostic() then
			table.insert(stl, lsp_diagnostic())
		end
		if get_file_size() then
			table.insert(stl, get_file_size())
		end
		table.insert(stl, mode_highlight)
		table.insert(stl, ' %2l/%-2L%2v ')
	else
		local winid = vim.g.statusline_winid
		local bufnr = api.nvim_win_get_buf(winid)
		table.insert(stl, '  ')
		table.insert(stl, '%#StatusLine#')
		table.insert(stl, vim.bo[bufnr].bt == 'quickfix' and quickfix(winid) or '%t %m')
		table.insert(stl, readonly(bufnr))

		table.insert(stl, '%<%=')

		table.insert(stl, fileformat(bufnr))
		table.insert(stl, ' %2l/%-2L%2v ')
	end
	return table.concat(stl, space)
end

api.nvim_create_autocmd({
	'BufDelete',
	'CursorHold',
	'BufWinEnter',
	'BufEnter',
	'ShellCmdPost',
	'BufWritePost',
	'FileChangedShellPost',
	'ColorScheme',
	'FileReadPre',
	'ShellCmdPost',
	'FileWritePost',
}, {
	callback = function()
		vim.wo.statusline = [[%!v:lua.require'core.statusline'.statusline()]]
	end,
})

return M
