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
		lazy = true,
	},

	{
		'stevearc/dressing.nvim',
		lazy = true,
	},

	{
		-- ui component
		'MunifTanjim/nui.nvim',
		lazy = true,
	},

	{
		-- beautiful notice
		'rcarriga/nvim-notify',
		lazy = true,
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
		event = 'BufReadPost',
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
		keys = { '<C-T>', mode = { 'n', 'i' } },
		-- event = 'UIEnter',
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
		-- with the plugin hlslens
		'romainl/vim-cool',
		event = 'FileType',
	},

	{
		'akinsho/bufferline.nvim',
		version = '*',
		dependencies = 'nvim-tree/nvim-web-devicons',
		event = { 'BufRead', 'BufNewFile' },
		config = function()
			require('bufferline').setup({
				options = {
					indicator = {
						style = 'underline',
					},
				},
			})
		end,
	},

	-- {
	-- 	-- tabline theme
	-- 	'romgrk/barbar.nvim',
	-- 	dependencies = {
	-- 		'nvim-tree/nvim-web-devicons',
	-- 	},
	-- 	event = { 'BufRead', 'BufNewFile' },
	-- },

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
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},

	{
		'nvim-treesitter/playground',
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},
	{
		-- textobjects
		'nvim-treesitter/nvim-treesitter-textobjects',
		config = req('textobjects'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},
	{
		-- rainbow bracket
		-- the ts-rainbow is not longer maintained so change to this one
		'HiPhish/nvim-ts-rainbow2',
		config = req('rainbow'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},
	{
		-- regex
		'bennypowers/nvim-regexplainer',
		config = req('regex'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},
	{
		-- autotag
		'windwp/nvim-ts-autotag',
		config = req('autotag'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},
	{
		'RRethy/nvim-treesitter-endwise',
		config = req('endwise'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},
	{
		'nvim-treesitter/nvim-treesitter-context',
		config = req('context'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},
	{
		'andymass/vim-matchup',
		config = req('matchup'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},
	{
		-- annotation plugin
		'danymat/neogen',
		config = req('neogen'),
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},

	{
		-- startup
		'goolord/alpha-nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = req('alpha'),
		event = 'BufWinEnter',
	},

	{
		'theniceboy/joshuto.nvim',
		config = req('joshuto'),
		keys = { 'R', mode = { 'n' } },
	},

	{
		'shellRaining/hlchunk.nvim',
		-- event = { 'UIEnter' },
		event = 'BufRead',
		config = req('hlchunk'),
	},

	{
		'folke/flash.nvim',
		event = 'VeryLazy',
		---@type Flash.Config
		opts = {},
		keys = {
			{
				's',
				mode = { 'n', 'x', 'o' },
				function()
					require('flash').jump()
				end,
				desc = 'Flash',
			},
			{
				',s',
				mode = { 'n', 'o', 'x' },
				function()
					require('flash').treesitter()
				end,
				desc = 'Flash Treesitter',
			},
			{
				'r',
				mode = 'o',
				function()
					require('flash').remote()
				end,
				desc = 'Remote Flash',
			},
			{
				'R',
				mode = { 'o', 'x' },
				function()
					require('flash').treesitter_search()
				end,
				desc = 'Treesitter Search',
			},
			{
				'<c-s>',
				mode = { 'c' },
				function()
					require('flash').toggle()
				end,
				desc = 'Toggle Flash Search',
			},
		},
	},

	{
		'williamboman/mason.nvim',
		config = function()
			require('mason').setup()
		end,
		event = 'BufRead',
	},

	{
		'jay-babu/mason-nvim-dap.nvim',
		config = req('mason-dap'),
		dependencies = { 'williamboman/mason.nvim' },
		event = 'BufRead',
	},

	{
		'jiaoshijie/undotree',
		dependencies = {
			'nvim-lua/plenary.nvim',
		},
		config = function()
			vim.keymap.set('n', '<leader>u', require('undotree').toggle, { noremap = true, silent = true })
			require('undotree').setup()
		end,
		event = { 'BufRead', 'BufNewFile' }, --[[ , ]]
	},

	{
		-- cursor word
		'itchyny/vim-cursorword',
		event = { 'BufRead', 'BufNewFile' },
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
		config = req('lsp.lspconfig'),
		dependencies = {
			-- lua api of neovim which describes for nvim function
			'folke/neodev.nvim',
		},
	},

	{
		'stevearc/aerial.nvim',
		dependencies = {
			'nvim-treesitter/nvim-treesitter',
			'nvim-tree/nvim-web-devicons',
		},
		config = req('aerial'),
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		-- statusline of the function
		'Bekaboo/dropbar.nvim',
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		-- lsp text
		'j-hui/fidget.nvim',
		tag = 'legacy',
		config = req('fidget'),
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		-- function showing the para
		'ray-x/lsp_signature.nvim',
		init = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(event)
					require('lsp_signature').on_attach({}, event.buf)
				end,
			})
		end,
		lazy = true,
	},

	{
		-- just guess indent
		'NMAC427/guess-indent.nvim',
		config = function()
			require('guess-indent').setup({})
		end,
		event = { 'BufReadPre', 'BufNewFile' },
	},

	{
		-- now change to the nvim inner
		'hrsh7th/nvim-cmp',
		config = req('cmp'),
		dependencies = {
			'f3fora/cmp-spell',
			'hrsh7th/cmp-path',
			-- 'hrsh7th/cmp-cmdline',
			'hrsh7th/cmp-buffer',
			'hrsh7th/cmp-nvim-lsp',
			'hrsh7th/cmp-nvim-lua',
			'saadparwaiz1/cmp_luasnip',
			'rcarriga/cmp-dap',
		},
		event = 'InsertEnter',
	},

	{
		'jose-elias-alvarez/null-ls.nvim',
		event = { 'BufReadPre' },
		-- cmd = {
		-- 	'NullLsLog',
		-- 	'NullLsInfo',
		-- 	'NullLsFormatOnSaveToggle',
		-- },
		dependencies = { 'plenary.nvim' },
		config = req('lsp/null-ls'),
	},

	{
		-- showing the lsp diagnostics
		'folke/trouble.nvim',
		event = { 'BufReadPre', 'FileType' },
		dependencies = { 'nvim-tree/nvim-web-devicons' },
	},

	{
		'L3MON4D3/LuaSnip',
		-- follow latest release.
		-- install jsregexp (optional!).
		build = 'make install_jsregexp',
		event = 'InsertCharPre',
		dependencies = { 'rafamadriz/friendly-snippets' },
		config = function()
			require('luasnip.loaders.from_vscode').lazy_load()
		end,
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
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		dependencies = {
			'plenary.nvim',
			'telescope-fzf-native.nvim',
			'debugloop/telescope-undo.nvim',
			'nvim-telescope/telescope-dap.nvim',
		},
		config = req('telescope'),
	},

	{
		'nvim-telescope/telescope-fzf-native.nvim',
		build = 'make',
		lazy = true,
		dependencies = { 'plenary.nvim', 'telescope.nvim' },
	},

	{
		'debugloop/telescope-undo.nvim',
		lazy = true,
		dependencies = { 'plenary.nvim', 'telescope.nvim' },
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
		'mfussenegger/nvim-dap',
		dependencies = {
			'cmp-dap',
			'nvim-dap-ui',
			'theHamsta/nvim-dap-virtual-text',
		},
		config = req('dap'),
		event = 'BufRead',
	},

	{
		'jbyuki/one-small-step-for-vimkind',
		cmd = 'DapOSVLaunchServer',
		dependencies = 'nvim-dap',
	},

	{
		'rcarriga/nvim-dap-ui',
		lazy = true,
		dependencies = { 'nvim-dap', 'nvim-web-devicons' },
	},

	{
		'theHamsta/nvim-dap-virtual-text',
		lazy = true,
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
		config = req('splitjoin'),
		event = 'BufRead',
	},
	{
		-- gS & gJ with treesitter
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
		cmd = 'Neoformat',
		-- event = 'BufRead',
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
		event = 'BufRead',
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
		'iamcco/markdown-preview.nvim',
		build = 'cd app && npm install',
		ft = 'markdown',
		lazy = true,
		keys = { { 'gm', '<cmd>MarkdownPreviewToggle<cr>', desc = 'Markdown Preview' } },
		config = function()
			vim.g.mkdp_browser = '/Applications/Firefox.app'
			vim.g.mkdp_open_ip = '127.0.0.1'
			vim.g.mkdp_port = '8888'
			vim.g.mkdp_echo_preview_url = true
		end,
	},

	{
		-- tex
		'lervag/vimtex',
	},

	{
		-- chinese vim doc
		'yianwillis/vimcdoc',
		event = 'VimEnter',
	},
})
