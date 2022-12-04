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
		use({ 'stevearc/dressing.nvim', event = 'VimEnter' })
		-- lua api of neovim which describes for nvim function
		use({ 'folke/neodev.nvim', ft = { 'lua' } })

		-- plugins for neovim interface
		use('Iron-E/nvim-highlite') -- color scheme
		-- deus
		use({ 'tandy1229/deus.nvim' })
		-- gruvbox
		use({ 'ellisonleao/gruvbox.nvim' })
		-- gs to switch
		use({ 'tandy1229/wordswitch.nvim' })
		-- use 'tandy1229/eleline.vim'  -- statusline interface

		-- interface modules
		-- scrollbar showing with gitsigns and coc
		use({ 'petertriho/nvim-scrollbar', config = req('scrollbar') })
		-- rgb colorizer
		use({ 'uga-rosa/ccc.nvim', config = req('colorizer') })
		-- indentlines plugin
		use({ 'lukas-reineke/indent-blankline.nvim', config = req('indent') })
		-- terminal enchance
		use({ 'akinsho/toggleterm.nvim', tag = '*', config = req('terminal') })
		-- pairs enchance
		use({ 'windwp/nvim-autopairs', event = 'InsertEnter', config = req('autopairs') })
		-- registers preview
		use({ 'tversteeg/registers.nvim', config = req('registers') })
		-- seach enchance
		use({ 'kevinhwang91/nvim-hlslens', config = req('hlslens') })
		-- tabline scheme
		use({
			'romgrk/barbar.nvim',
			requires = {
				'kyazdani42/nvim-web-devicons',
			},
		})
		-- searchbox: search with a good looking
		use({
			'VonHeikemen/searchbox.nvim',
			requires = {
				{ 'MunifTanjim/nui.nvim' },
			},
			after = 'gitsigns.nvim',
		})
		-- use treesitter to pasar
		-- with a good looking of syntax
		use({
			'nvim-treesitter/nvim-treesitter',
			config = req('treesitter'),
			run = ':TSUpdate',
			-- event = 'BufRead',
		})
		use({ 'nvim-treesitter/playground' })
		-- rainbow brackets
		use({ 'p00f/nvim-ts-rainbow', after = 'nvim-treesitter' })
		-- f enchance
		use({ 'ggandor/leap.nvim', config = req('leap') })
		-- s enchance
		use({ 'ggandor/flit.nvim', config = req('flit') })
		-- cursorword
		use({ 'itchyny/vim-cursorword' })
		-- editorconfig
		use({ 'editorconfig/editorconfig-vim' })

		-- git modules
		-- lazygit combine
		use({ 'kdheepak/lazygit.nvim', config = req('lazygit'), event = 'VimEnter' })
		-- gitgutter like
		use({
			'lewis6991/gitsigns.nvim',
			requires = { 'nvim-lua/plenary.nvim' },
			config = req('gitsigns'),
			after = 'plenary.nvim',
		})
		-- :Agit show git commits
		use({ 'cohama/agit.vim', cmd = 'Agit' })
		-- fugitive
		use({ 'tpope/vim-fugitive' })
		use({ 'tpope/vim-dadbod', opt = true })
		use({ 'kristijanhusak/vim-dadbod-ui', opt = true })

		-- lsp modules
		-- coc completion franeworks based on node
		use({ 'neoclide/coc.nvim', branch = 'release', config = req('coc') })
		-- lsp function showing
		use({ 'liuchengxu/vista.vim', config = req('vista'), event = 'VimEnter' })
		-- <leader>j to jump to the location of the function
		use('pechorin/any-jump.vim')
		-- remember the location where you quit
		use('farmergreg/vim-lastplace')

		-- software modules
		-- ranger combine
		use({
			'kevinhwang91/rnvimr',
			config = req('rnvimr'),
		})
		-- fzf combine
		use({ 'ibhagwan/fzf-lua', config = req('fzf-lua'), event = 'VimEnter' })

		-- telescope opt choice
		use({
			'nvim-telescope/telescope.nvim',
			tag = '0.1.0',
			opt = true,
			requires = { { 'nvim-lua/plenary.nvim' } },
			config = req('telescope'),
			-- after = 'plenary.nvim',
		})
		-- beautiful notice
		use({ 'rcarriga/nvim-notify', after = 'plenary.nvim' })

		-- annotation plugin
		use({
			'danymat/neogen',
			config = req('neogen'),
			requires = 'nvim-treesitter/nvim-treesitter',
		})

		-- icon picker
		use({
			'ziontee113/icon-picker.nvim',
			config = req('iconpicker'),
			after = 'dressing.nvim',
		})

		-- gnu-sed combine
		use({ 'nvim-pack/nvim-spectre', config = req('spectre'), event = 'VimEnter' })

		-- DAP
		use({
			{ 'mfussenegger/nvim-dap' },
			{ 'rcarriga/nvim-dap-ui', after = { 'nvim-dap' } },
			{ 'jbyuki/one-small-step-for-vimkind', after = { 'nvim-dap' } },
		})
		-- for neovim plugin debug
		use({ 'bfredl/nvim-luadev', config = req('luadev') })

		-- nvim enchance modules
		-- yskw can change the symbol whose words are surrounded
		use({ 'kylechui/nvim-surround', config = req('surround'), event = 'VimEnter' })
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
		})

		-- quickfix enchance
		use({ 'kevinhwang91/nvim-bqf', ft = 'qf' })
		-- ToDo enchance
		use({
			'folke/todo-comments.nvim',
			requires = 'nvim-lua/plenary.nvim',
			config = req('todo-comment'),
			after = 'plenary.nvim',
		})
		-- undotree plugin
		-- use {'mbbill/undotree', cmd = 'UndotreeToggle'}
		-- super <enter>
		use('gcmt/wildfire.vim')
		-- tabular !!!
		use({ 'godlygeek/tabular', req = 'tabular' })
		-- gc to change code to comment
		-- use 'tomtom/tcomment_vim'
		use({ 'numToStr/Comment.nvim', config = req('comment'), event = 'VimEnter' })
		-- da= function
		use('junegunn/vim-after-object')
		-- multi change plugin!!
		use({ 'mg979/vim-visual-multi', event = 'CursorHold' })
		-- gS & gJ
		use('AndrewRadev/splitjoin.vim')
		-- test time of vimstart
		use({ 'dstein64/vim-startuptime', cmd = 'StartupTime' })
		-- ex mode enchance
		use({
			'gelguy/wilder.nvim',
			requires = { 'romgrk/fzy-lua-native', 'kyazdani42/nvim-web-devicons' },
			config = req('commandline'),
			event = 'CmdlineEnter',
		})
		-- format code plugin
		use({ 'sbdchd/neoformat' })
		-- async run
		use({ 'skywind3000/asyncrun.vim' })
		-- REPL run
		use({ 'michaelb/sniprun', config = req('snip') }) --, run = 'bash install.sh'}

		use({ 'kevinhwang91/nvim-ufo', requires = 'kevinhwang91/promise-async', config = req('ufo') })
		use({ 'ten3roberts/qf.nvim', config = req('quickfix') })

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
