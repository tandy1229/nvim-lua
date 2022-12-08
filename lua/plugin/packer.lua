local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

-- Source a Lua file
local function req(plugin)
	return 'require "plugin/' .. plugin .. '"'
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost packer.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({
	function(use)
		-- package manager plugin
		use({ 'wbthomason/packer.nvim' })

		-- lua plugin acclater
		use('lewis6991/impatient.nvim')
		-- lua api which any lua plugins are relying
		use({ 'nvim-lua/plenary.nvim', event = 'VimEnter' })
		-- neovim ui api
		use({ 'stevearc/dressing.nvim', event = 'BufRead' })
		-- lua api of neovim which describes for nvim function
		use({ 'folke/neodev.nvim', ft = { 'lua' } })
		-- ui component
		use({ 'MunifTanjim/nui.nvim' })
		-- beautiful notice
		use({ 'rcarriga/nvim-notify' })

		-- plugins for neovim interface
		-- use('Iron-E/nvim-highlite') -- color scheme
		-- deus
		use({ 'tandy1229/deus.nvim' })
		-- gruvbox
		use({ 'ellisonleao/gruvbox.nvim' })
		-- gs to switch
		use({ 'tandy1229/wordswitch.nvim', event = 'BufReadPost' })
		-- use 'tandy1229/eleline.vim'  -- statusline interface

		-- interface modules
		-- scrollbar showing with gitsigns and coc
		use({
			'petertriho/nvim-scrollbar',
			config = req('scrollbar'),
			after = 'nvim-hlslens',
		})
		-- rgb colorizer
		use({
			'uga-rosa/ccc.nvim',
			config = req('colorizer'),
			event = 'BufRead',
		})
		-- terminal enchance
		use({ 'akinsho/toggleterm.nvim', tag = '*', config = req('terminal'), event = 'UIEnter' })
		-- pairs enchance
		use({
			'windwp/nvim-autopairs',
			config = req('autopairs'),
			event = 'InsertEnter',
		})
		-- registers preview
		use({
			'tversteeg/registers.nvim',
			config = req('registers'),
			keys = { { 'n', '"' }, { 'i', '<c-r>' } },
		})
		-- seach enchance
		use({
			'kevinhwang91/nvim-hlslens',
			config = req('hlslens'),
			event = 'BufRead',
		})
		-- tabline scheme
		use({
			'romgrk/barbar.nvim',
			requires = {
				'kyazdani42/nvim-web-devicons',
			},
			event = 'BufRead',
		})
		use({ 'rainbowhxch/accelerated-jk.nvim', event = 'BufWinEnter', config = req('jk') })
		-- use treesitter to pasar
		-- with a good looking of syntax
		use({
			'nvim-treesitter/nvim-treesitter',
			config = req('treesitter'),
			run = ':TSUpdate',
			event = 'BufRead',--[[ , ]]
		})
		use({ 'nvim-treesitter/playground', after = 'nvim-treesitter' })
		-- rainbow brackets
		use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter', config = req('rainbow') })
		use({ 'bennypowers/nvim-regexplainer', after = 'nvim-treesitter', config = req('regex') })
		use({ 'windwp/nvim-ts-autotag', after = 'nvim-treesitter', config = req('autotag') })
		use({ 'RRethy/nvim-treesitter-endwise', after = 'nvim-treesitter', config = req('endwise') })
		use({ 'andymass/vim-matchup', after = 'nvim-treesitter', config = req('matchup') })
		use({
			'JoosepAlviste/nvim-ts-context-commentstring',
			after = 'nvim-treesitter',
			config = req('commentstring'),
		})
		-- annotation plugin
		use({
			'danymat/neogen',
			config = req('neogen'),
			after = 'nvim-treesitter',
		})
		-- indentlines plugin
		use({
			'lukas-reineke/indent-blankline.nvim',
			config = req('indent'),
			after = 'nvim-treesitter',
		})

		-- f enchance
		use({ 'ggandor/leap.nvim', config = req('leap'), event = 'BufRead' })
		-- s enchance
		use({ 'ggandor/flit.nvim', config = req('flit'), event = 'BufRead' })
		-- cursorword
		use({ 'itchyny/vim-cursorword' })
		-- editorconfig
		use({ 'editorconfig/editorconfig-vim', event = 'BufRead' })

		-- git modules
		-- lazygit combine
		use({ 'kdheepak/lazygit.nvim', config = req('lazygit'), event = 'BufRead' })
		-- gitgutter like
		use({
			'lewis6991/gitsigns.nvim',
			requires = { 'nvim-lua/plenary.nvim' },
			config = req('gitsigns'),
			event = { 'BufRead', 'BufNewFile' },
		})
		-- :Agit show git commits
		use({ 'cohama/agit.vim', cmd = 'Agit' })
		-- fugitive
		use({ 'tpope/vim-fugitive', cmd = { 'Git', 'G' } })
		use({ 'tpope/vim-dadbod', opt = true })
		use({ 'kristijanhusak/vim-dadbod-ui', opt = true })

		-- lsp modules
		-- coc completion franeworks based on node
		use({
			'neoclide/coc.nvim',
			branch = 'release',
			config = req('coc'),
			event = { 'BufRead', 'BufAdd', 'InsertEnter' },
		})
		-- lsp function showing
		use({ 'liuchengxu/vista.vim', config = req('vista'), event = 'BufRead' })
		-- <leader>j to jump to the location of the function
		use({ 'pechorin/any-jump.vim', event = 'BufRead' })
		-- remember the location where you quit
		use('farmergreg/vim-lastplace')

		-- software modules
		-- ranger combine
		use({
			'kevinhwang91/rnvimr',
			config = req('rnvimr'),
			event = 'VimEnter',
		})
		-- fzf combine
		use({ 'ibhagwan/fzf-lua', config = req('fzf-lua'), event = 'BufRead' })

		-- telescope opt choice
		use({
			'nvim-telescope/telescope.nvim',
			tag = '0.1.0',
			opt = true,
			requires = { { 'nvim-lua/plenary.nvim' } },
			config = req('telescope'),
			cmd = 'Telescope',
			-- after = 'nvim-treesitter',
		})

		-- icon picker
		use({
			'ziontee113/icon-picker.nvim',
			config = req('iconpicker'),
			opt = true,
			event = 'BufRead',
		})

		-- gnu-sed combine
		use({ 'nvim-pack/nvim-spectre', config = req('spectre'), event = 'BufRead' })

		-- DAP
		use({
			{
				'mfussenegger/nvim-dap',
				cmd = {
					'DapSetLogLevel',
					'DapShowLog',
					'DapContinue',
					'DapToggleBreakpoint',
					'DapToggleRepl',
					'DapStepOver',
					'DapStepInto',
					'DapStepOut',
					'DapTerminate',
				},
				opt = true,
			},
			{ 'rcarriga/nvim-dap-ui', after = { 'nvim-dap' } },
			{ 'jbyuki/one-small-step-for-vimkind', after = { 'nvim-dap' } },
		})
		-- for neovim plugin debug
		-- use({ 'bfredl/nvim-luadev', config = req('luadev') })

		-- nvim enchance modules
		-- yskw can change the symbol whose words are surrounded
		use({
			'kylechui/nvim-surround',
			config = req('surround'),
			event = 'BufRead',
		})
		-- dot enchance
		use('tpope/vim-repeat')
		-- change the root to the location of the buffer file
		use('airblade/vim-rooter')
		-- vim start shows
		-- use 'mhinz/vim-startify'
		use({
			'goolord/alpha-nvim',
			requires = { 'kyazdani42/nvim-web-devicons' },
			config = req('alpha'),
			-- event = 'BufWinEnter'
		})

		-- quickfix enchance
		use({ 'kevinhwang91/nvim-bqf', ft = 'qf' })
		-- ToDo enchance
		use({
			'folke/todo-comments.nvim',
			requires = 'nvim-lua/plenary.nvim',
			config = req('todo-comment'),
			event = 'BufRead',
		})
		-- undotree plugin
		-- use {'mbbill/undotree', cmd = 'UndotreeToggle'}
		-- super <enter>
		use({ 'gcmt/wildfire.vim', event = 'BufRead' })
		-- tabular !!!
		use({ 'godlygeek/tabular', req = 'tabular', event = 'BufRead' })
		-- gc to change code to comment
		-- use 'tomtom/tcomment_vim'
		use({
			'numToStr/Comment.nvim',
			config = req('comment'),
			event = 'BufRead',
		})
		-- da= function
		use('junegunn/vim-after-object')
		-- multi change plugin!!
		use({ 'mg979/vim-visual-multi', event = 'CursorHold' })
		-- gS & gJ
		use({ 'AndrewRadev/splitjoin.vim' })
		-- test time of vimstart
		use({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
		-- helpful
		use({ 'tweekmonster/helpful.vim', cmd = 'HelpfulVersion' })
		-- ex mode enchance
		use({
			'gelguy/wilder.nvim',
			requires = { { 'romgrk/fzy-lua-native', after = 'wilder.nvim' } },
			config = req('commandline'),
			event = 'CmdlineEnter',
		})
		-- format code plugin
		use({ 'sbdchd/neoformat', event = 'BufRead' })
		-- async run
		use({ 'skywind3000/asyncrun.vim', event = 'BufRead' })
		-- REPL run
		use({ 'michaelb/sniprun', config = req('snip'), cmd = { 'SnipRun', "'<,'>SnipRun" } }) --, run = 'bash install.sh'}

		use({
			'kevinhwang91/nvim-ufo',
			requires = 'kevinhwang91/promise-async',
			config = req('ufo'),
			after = 'coc.nvim',
		})
		use({
			'ten3roberts/qf.nvim',
			config = req('quickfix'),
			event = 'BufRead',
		})

		-- go languange suppport
		use({ 'fatih/vim-go', ft = { 'go' } })
		-- markdown preview in neovim with the command :Glow
		use({ 'ellisonleao/glow.nvim', ft = { 'markdown' }, cmd = 'Glow' })
		-- markdown plugin
		use({ 'preservim/vim-markdown', ft = { 'markdown' }, config = req('markdown') })
		-- tex
		use({ 'lervag/vimtex' })

		-- vim doc with Chinese
		use({ 'yianwillis/vimcdoc', event = 'VimEnter' })
		if packer_bootstrap then
			require('packer').sync()
		end
	end,
	config = {
		profile = {
			enable = true,
			threshold = 0, -- the amount in ms that a plugin's load time must be over for it to be included in the profile
		},
		display = {
			open_fn = function()
				return require('packer.util').float({ border = 'single' })
			end,
		},
	},
})
