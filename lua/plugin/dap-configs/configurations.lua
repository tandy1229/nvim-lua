local dapconfig = {}

local cache = {
  python = {
    args = {},
  },
  sh = {
    args = {},
  },
  cpp = {
    args = {},
  },
}

dapconfig.cpp = {
  {
    type = 'codelldb',
    name = 'Launch file',
    request = 'launch',
    program = function()
      local program
      vim.ui.input({
        prompt = 'Enter path to executable: ',
        default = vim.fs.find({ vim.fn.expand('%:t:r'), 'a.out' }, {
          path = vim.fn.expand('%:p:h'),
          upward = true,
        })[1] or cache.cpp.program,
        completion = 'file',
      }, function(input)
        program = input
        cache.cpp.program = program
        vim.cmd.stopinsert()
      end)
      return vim.fn.fnamemodify(program, ':p')
    end,
    args = function()
      local args = ''
      local fpath_base = vim.fn.expand('%:p:r')
      vim.ui.input({
        prompt = 'Enter arguments: ',
        default = cache.cpp.program and cache.cpp.args[cache.cpp.program] or cache.cpp.args[fpath_base],
        completion = 'file',
      }, function(input)
        args = input
        cache.cpp.args[cache.cpp.program or fpath_base] = args
        vim.cmd.stopinsert()
      end)
      return vim.split(args, ' ')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
  },
}

dapconfig.c = dapconfig.cpp

return dapconfig
