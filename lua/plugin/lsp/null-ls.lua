local null_ls = require('null-ls')
null_ls.setup({
	sources = {
		-- null_ls.builtins.formatting.stylua,
		null_ls.builtins.formatting.stylua.with({
			condition = function(utils)
				return utils.root_has_file({ 'stylua.toml', '.stylua.toml' })
			end,
		}),

		null_ls.builtins.diagnostics.eslint,
		-- null_ls.builtins.completion.spell,
		null_ls.builtins.code_actions.gitsigns,
		null_ls.builtins.code_actions.gitrebase,
		null_ls.builtins.code_actions.shellcheck,
		-- null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.formatting.shfmt,
		null_ls.builtins.diagnostics.markdownlint,
		null_ls.builtins.formatting.markdown_toc,
		-- null_ls.builtins.formatting.markdownlint,
		-- null_ls.builtins.formatting.mdformat,
		-- null_ls.builtins.formatting.remark,
		null_ls.builtins.formatting.clang_format,
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.diagnostics.pycodestyle,
		null_ls.builtins.diagnostics.pydocstyle,
		null_ls.builtins.diagnostics.mypy,
		null_ls.builtins.diagnostics.ruff,
		null_ls.builtins.diagnostics.cspell.with({
			filetypes = { 'markdown', 'text', 'javascript', 'typescript' },
			extraArgs = { '--language', 'en' },
		}),
		null_ls.builtins.code_actions.cspell,
	},
})
