local dapconfig = {}

dapconfig.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
}

return dapconfig
