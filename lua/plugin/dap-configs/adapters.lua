local adapters = {}

adapters.codelldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = '~/.vscode/extensions/vadimcn.vscode-lldb-1.9.2/adapter/codelldb',
    args = {"--port", "${port}"},
  }
}

return adapters
