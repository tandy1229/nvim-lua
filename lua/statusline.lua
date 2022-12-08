local M = {}
local fn, api, loop = vim.fn, vim.api, vim.loop
local space = ' '

local mode = setmetatable({
	n = { 'N', '%#StatusLineNormal#' },
	no = { 'N', '%#StatusLineNormal#' },
	v = { 'V', '%#StatusLineVisual#' },
	V = { 'VL', '%#StatusLineVisual#' },
	['\x16'] = { 'VB', '%#StatusLineVisual#' },
	s = { 'S', '%#StatusLineVisual#' },
	S = { 'SL', '%#StatusLineVisual#' },
	['\x13'] = { 'SB', '%#StatusLineVisual#' },
	i = { 'I', '%#StatusLineInsert#' },
	ic = { 'I', '%#StatusLineInsert#' },
	ix = { 'I', '%#StatusLineInsert#' },
	R = { 'R', '%#StatusLineReplace#' },
	Rv = { 'VR', '%#StatusLineReplace#' },
	c = { 'C', '%#StatusLineCommand#' },
	cv = { 'Vim Ex', '%#StatusLineCommand#' },
	ce = { 'Ex', '%#StatusLineCommand#' },
	r = { 'P', '%#StatusLineCommand#' },
	rm = { 'More', '%#StatusLineCommand#' },
	['!'] = { '!', '%#StatusLineCommand#' },
	t = { 'T', '%#StatusLineTerminal#' },
}, {
	__index = function(t, k)
		return t[k:sub(1, 1)] or t['n']
	end,
})

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

local function filename(width)
	local bufname = api.nvim_buf_get_name(0)
	local fugitive_name = vim.b.fugitive_fname
	if not fugitive_name then
		if bufname:match('^fugitive:') and fn.exists('*FugitiveReal') == 1 then
			fugitive_name = fn.fnamemodify(fn.FugitiveReal(bufname), ':t') .. ' '
			vim.b.fugitive_fname = fugitive_name
		end
	end

	local fname
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
				fname = ('%s (%s)'):format(fname, ft)
			end
		end
	end
	if bt == '' then
		fname = fname .. ' %m'
	end
	return '%#StatusLine' .. (vim.bo.modified and 'FileModified#' or 'FileName#') .. fname .. '%#StatusLine#'
end

local function readonly(bufnr)
	local ret
	if vim.bo[bufnr].readonly then
		ret = loop.fs_stat(api.nvim_buf_get_name(bufnr or 0)) and '' or ''
	end
	if ret then
		return ret
	else
		return ''
	end
end

local function coc_status()
	local status = vim.trim(vim.g.coc_status or '')
	if status then
		return '%#StatusLineCocStatus#' .. status .. '%#StatusLine#'
	end
	return ''
end

local function coc_diagnostic()
	local ret
	local list = {}
	local info = vim.b.coc_diagnostic_info
	if info and (info.warning > 0 or info.error > 0) then
		if info.error > 0 then
			local error = '' .. space .. info.error
			table.insert(list, '%#StatusLineHunkRemove#' .. error)
		end
		if info.warning > 0 then
			local warning = '' .. space .. info.warning
			table.insert(list, '%#StatusLineHunkChange#' .. warning)
		end
		if info.information > 0 then
			local information = '' .. space .. info.information
			table.insert(list, '%#StatusLineInformation#' .. information)
		end
		if info.hint > 0 then
			local hint = '' .. space .. info.hint
			table.insert(list, '%#StatusLineHint#' .. hint)
		end
		ret = table.concat(list, space) .. '%#StatusLine#'
	end
	return ret
end

local function gitsigns()
	local ret
	local ginfo = vim.b.gitsigns_status_dict
	if ginfo then
		local branch = ginfo.head
		local list = { '%#StatusLineBranch#' .. branch }
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
		ret = table.concat(list, space) .. '%#StatusLine#'
	end
	return ret
end

local function show_function()
	local func
	local coc = vim.g.coc_enabled
	local coc_function = vim.b.coc_current_function
	local vista = vim.b.vista_nearest_method_or_function
	if coc and coc_function then
		func = coc_function
	elseif vista then
		func = vista
	end
	if func then
		func = '%#StatusLineHunkAdd#' .. func .. '%#StatusLine#'
	end
	return func or ''
end

local function file_size(file)
	local size = fn.getfsize(file)
	if size == 0 or size == -1 or size == -2 then
		return ''
	end
	if size < 1024 then
		size = size .. 'B'
	elseif size < 1024 * 1024 then
		size = string.format('%0.1f', size / 1024) .. 'KB'
	elseif size < 1024 * 1024 * 1024 then
		size = string.format('%0.1f', size / 1024 / 1024) .. 'GB'
	end
	return size
end

local function get_file_size()
	local file = fn.expand('%:p')
	if string.len(file) == 0 then
		return ''
	end
	return file_size(file)
end

local function fileformat(bufnr)
	local icon
	if vim.bo[bufnr].fileformat == 'unix' then
		icon = jit.os == 'OSX' and '' or 'ﱦ'
	else
		icon = ''
	end
	return bufnr == 0 and '%#StatusLineFormat#' .. icon .. '%#StatusLine#' or icon
end

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

function M.statusline()
	local stl = {}
	local curmode = api.nvim_get_mode().mode
	local mode_name, mode_highlight = unpack(mode[curmode])
	local width = api.nvim_win_get_width(vim.g.statusline_winid)

	if api.nvim_get_current_win() == vim.g.statusline_winid then
		table.insert(stl, mode_highlight)
		table.insert(stl, mode_name .. checkmode())
		table.insert(stl, '%#StatusLine#') -- statusline group
		table.insert(stl, get_file_size())
		table.insert(stl, filename(width) .. readonly(0) .. '%<')
		table.insert(stl, coc_status())
		table.insert(stl, coc_diagnostic())

		table.insert(stl, '%=')
		table.insert(stl, show_function())
		table.insert(stl, gitsigns())

		table.insert(stl, fileformat(0))
		table.insert(stl, mode_highlight)
		table.insert(stl, ' %l/%L%v ')
	else
		local winid = vim.g.statusline_winid
		local bufnr = api.nvim_win_get_buf(winid)
		table.insert(stl, '  ')
		table.insert(stl, '%#StatusLine#')
		table.insert(stl, vim.bo[bufnr].bt == 'quickfix' and quickfix(winid) or '%t %m')
		table.insert(stl, readonly(bufnr))

		table.insert(stl, '%<%=')

		table.insert(stl, fileformat(bufnr))
		table.insert(stl, ' %l/%L%v ')
	end
	return table.concat(stl, space)
end

api.nvim_create_autocmd({
	'VimEnter',
	'BufDelete',
	'CursorHold',
	'BufWinEnter',
	'ShellCmdPost',
	'BufWritePost',
	'FileChangedShellPost',
	'ColorScheme',
	'FileReadPre',
	'ShellCmdPost',
	'FileWritePost',
}, {
	callback = function()
		vim.wo.statusline = [[%!v:lua.require'statusline'.statusline()]]
	end,
})

return M
