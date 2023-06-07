local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		'git',
		'clone',
		'--filter=blob:none',
		'https://github.com/folke/lazy.nvim.git',
		'--branch=stable', -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- Source a Lua file
local function req(plugin)
	return function()
		require('plugin.' .. plugin)
	end
end

require('lazy').setup({
	{
		-- from packer.nvim moving to lazy
		'folke/lazy.nvim',
		tag = 'stable',
	},

	{
		-- lua api which any lua plugins are relying
		'nvim-lua/plenary.nvim',
		event = 'VimEnter',
	},

	{
		'stevearc/dressing.nvim',
	},

	{
		-- lua api of neovim which describes for nvim function
		'folke/neodev.nvim',
		ft = { 'lua' },
	},

	{
		-- ui component
		'MunifTanjim/nui.nvim',
	},

	{
		-- beautiful notice
		'rcarriga/nvim-notify',
	},

	{
		-- plugin for neovim interface
		dir = '~/Downloads/deus.nvim',
		-- 'tandy1229/deus.nvim',
		lazy = false,
		priority = 1000,
		config = function()
			vim.api.nvim_command('colorscheme deus')
		end,
	},

	-- {
	-- 	'folke/tokyonight.nvim',
	-- 	lazy = false,
	-- 	priority = 1000,
	-- 	config = function()
	-- 		vim.api.nvim_command('colorscheme tokyonight')
	-- 	end,
	-- },

	{
		-- gs to switch
		'tandy1229/wordswitch.nvim',
		event = 'BufReadPost',
	},

	-- interface modules
	{
		-- scrollbar showing working with gitsigns and coc
		'petertriho/nvim-scrollbar',
		config = req('scrollbar'),
	},

	{
		-- rgb colorizer and color picker
		'uga-rosa/ccc.nvim',
		config = req('colorizer'),
		event = 'BufRead',
	},

	{
		-- terminal enchance
		'akinsho/toggleterm.nvim',
		version = '*',
		config = req('terminal'),
		event = 'UIEnter',
	},

	{
		-- autopairs enchance
		'windwp/nvim-autopairs',
		config = req('autopairs'),
		event = 'InsertEnter',
	},

	{
		-- registers preview
		'tversteeg/registers.nvim',
		config = req('registers'),
		keys = {
			{ '"', mode = { 'n', 'v' } },
			{ '<C-R>', mode = 'i' },
		},
	},

	{
		-- searching enchance
		'kevinhwang91/nvim-hlslens',
		config = req('hlslens'),
		event = 'BufRead',
	},

	{
		-- tabline theme
		'romgrk/barbar.nvim',
		dependencies = {
			'nvim-tree/nvim-web-devicons',
		},
		event = { 'BufRead', 'BufNewFile' },
	},

	{
		-- jk enchance
		'rainbowhxch/accelerated-jk.nvim',
		event = 'BufReadPost',
		config = req('jk'),
	},

	-- treesitter modules
	{
		-- pasar with treesitter
		-- with a good looking of syntax
		'nvim-treesitter/nvim-treesitter',
		config = req('treesitter'),
		build = ':TSUpdate',
		event = { 'BufRead', 'BufNewFile' },--[[ , ]]
	},

	{
		'nvim-treesitter/playground',
	},
	{
		-- rainbow bracket
		-- the ts-rainbow is not longer maintained so change to this one
		'HiPhish/nvim-ts-rainbow2',
		config = req('rainbow'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		-- regex
		'bennypowers/nvim-regexplainer',
		config = req('regex'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		-- autotag
		'windwp/nvim-ts-autotag',
		config = req('autotag'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		'RRethy/nvim-treesitter-endwise',
		config = req('endwise'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		config = req('context'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		'andymass/vim-matchup',
		config = req('matchup'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},
	{
		-- annotation plugin
		'danymat/neogen',
		config = req('neogen'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
	},

	{
		-- startup
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = req('alpha'),
		event = 'BufWinEnter',
	},

	{
		-- ranger integrate
		'kevinhwang91/rnvimr',
		config = req('rnvimr'),
		event = 'VimEnter',
	},

	{
		-- indentline
		'lukas-reineke/indent-blankline.nvim',
		config = req('indent'),
	},

	{
		-- s enchance
		'ggandor/leap.nvim',
		config = req('leap'),
		event = 'BufRead',
	},

	{
		-- f enchance
		'ggandor/flit.nvim',
		config = req('flit'),
		event = 'BufRead',
	},

	{
		-- cursor word
		'itchyny/vim-cursorword',
	},

	{
		-- editorconfig
		'editorconfig/editorconfig-vim',
		event = 'BufRead',
	},

	{
		-- lazygit integrate
		'kdheepak/lazygit.nvim',
		config = req('lazygit'),
		event = { 'BufRead', 'BufNewFile' },
	},

	{
		-- gitsigns
		'lewis6991/gitsigns.nvim',
		config = req('gitsigns'),
		event = { 'BufRead', 'BufNewFile' },
	},

	{
		-- :Agit shows the git commits
		'cohama/agit.vim',
		cmd = 'Agit',
	},

	{
		-- fugitive
		'tpope/vim-fugitive',
		cmd = { 'Git', 'G' },
	},

	{
		'neovim/nvim-lspconfig',
		event = { 'BufReadPre', 'BufNewFile' },
		config = req('lsp'),
	},

	{
		'j-hui/fidget.nvim',
		config = function()
			require('fidget').setup({})
		end,
	},

	{
		'ray-x/lsp_signature.nvim',
		config = function()
			require('lsp_signature').setup({})
		end,
	},

	{
		'romainl/vim-cool',
	},

	{
		-- coc framework bosed on node
		-- 'neoclide/coc.nvim',
		-- branch = 'release',
		-- config = req('coc'),
		-- event = { 'BufRead', 'BufAdd', 'InsertEnter', 'BufNewFile' },
		'hrsh7th/nvim-cmp',
		config = req('cmp'),
		dependencies = {
			'f3fora/cmp-spell',
			'hrsh7th/cmp-path',
			'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'saadparwaiz1/cmp_luasnip',
		},
		event = 'InsertEnter',
	},

	{
		'jose-elias-alvarez/null-ls.nvim',
		config = function()
			local null_ls = require('null-ls')
			null_ls.setup({
				sources = {
					null_ls.builtins.formatting.stylua,
					null_ls.builtins.diagnostics.eslint,
					null_ls.builtins.completion.spell,
				},
			})
		end,
	},

	{
		'folke/trouble.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},

	{
		'L3MON4D3/LuaSnip',
		-- follow latest release.
		-- install jsregexp (optional!).
		build = 'make install_jsregexp',
		dependencies = { 'rafamadriz/friendly-snippets' },
	},

	{
		-- <leader>j to jump to the location of the function
		'pechorin/any-jump.vim',
		event = 'BufRead',
	},

	{
		-- remember the location where you quit
		'farmergreg/vim-lastplace',
	},

	{
		-- no need to explain fzf
		'ibhagwan/fzf-lua',
		config = req('fzf-lua'),
		event = 'BufRead',
	},

	{
		-- gnu-sed integrate
		'nvim-pack/nvim-spectre',
		config = req('spectre'),
		event = 'BufRead',
	},

	{
		-- tpope wheels
		'kylechui/nvim-surround',
		config = req('surround'),
		event = 'BufRead',
	},

	{
		-- dot enchance
		'tpope/vim-repeat',
	},

	{
		-- change the root to the location of the buffer file
		'airblade/vim-rooter',
	},

	{
		-- quickfix enchance
		'kevinhwang91/nvim-bqf',
		dependencies = { 'junegunn/fzf' },
		ft = 'qf',
	},

	{
		-- TODO enchance
		'folke/todo-comments.nvim',
		dependencies = 'nvim-lua/plenary.nvim',
		config = req('todo-comment'),
		event = 'BufRead',
	},

	{
		-- super <Enter>
		'gcmt/wildfire.vim',
		event = 'BufRead',
	},

	{
		-- tabular !!!
		'godlygeek/tabular',
		config = req('tabular'),
		event = 'BufRead',
	},

	{
		-- gc to change code to comment
		'numToStr/Comment.nvim',
		config = req('comment'),
		event = { 'BufRead', 'BufNewFile' },
	},

	{
		-- da= function
		'junegunn/vim-after-object',
	},

	{
		'junegunn/vim-easy-align',
	},

	{
		-- multi cursors !!!
		'mg979/vim-visual-multi',
		event = 'CursorHold',
	},

	{
		-- gS & gJ
		'AndrewRadev/splitjoin.vim',
	},

	{
		'Wansmer/treesj',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = req('treesj'),
		event = 'BufRead',
	},

	{
		-- StartupTime
		'dstein64/vim-startuptime',
		cmd = 'StartupTime',
		init = function()
			vim.g.startuptime_tries = 10
		end,
	},

	{
		-- ex mode enchance
		'gelguy/wilder.nvim',
		dependencies = { 'romgrk/fzy-lua-native' },
		config = req('commandline'),
		event = 'CmdlineEnter',
	},

	{
		-- code format
		'sbdchd/neoformat',
		event = 'BufRead',
	},

	{
		-- coc enchance
		'kevinhwang91/nvim-ufo',
		dependencies = {
			'kevinhwang91/promise-async',
			-- 'neoclide/coc.nvim',
		},
		config = req('ufo'),
		event = 'BufRead',
	},

	{
		-- REPL
		'michaelb/sniprun',
		config = req('snip'),
		build = 'sh ./install.sh',
	},

	{
		-- go
		'fatih/vim-go',
		ft = { 'go' },
	},

	{
		-- markdown
		'preservim/vim-markdown',
		ft = { 'markdown' },
		config = req('markdown'),
	},

	{
		-- tex
		'lervag/vimtex',
	},

	{
		'yianwillis/vimcdoc',
		event = 'VimEnter',
	},
})
