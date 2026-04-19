-- based on kickstart.nvim https://github.com/nvim-lua/kickstart.nvim
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true

-- [[ Options ]]
--  See `:help vim.o`
vim.o.number = false
vim.o.mouse = 'a'
vim.o.showmode = false
vim.o.showcmd = false
vim.o.breakindent = true

vim.o.undofile = false

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.signcolumn = 'auto'
vim.o.updatetime = 4000
vim.o.timeoutlen = 300
vim.o.splitright = false
vim.o.splitbelow = false
vim.o.list = false
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

vim.o.inccommand = 'split'

vim.o.cursorline = false
vim.o.scrolloff = 0

vim.o.confirm = false

vim.o.formatoptions = 'tcroqlj'
vim.o.textwidth = 80

vim.o.tabstop = 4
vim.o.shiftwidth = 4

-- [[ Keymaps ]]
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
	update_in_insert = false,
	severity_sort = true,
	float = { border = 'rounded', source = 'if_many' },
	underline = { severity = { min = vim.diagnostic.severity.WARN } },

	virtual_text = true,
	virtual_line = false,

	-- Auto open the float; errors are shown when jumping with `[d` and `]d`
	jump = { float = true },
}

vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode with a different shortcut than <C-\><C-n>
-- vim.keymap.set('t', '<Esc><Esc>, '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Switch between windows with <C-hjkl>
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.keymap.set('n', '<C-S-h>', '<C-w>H', { desc = 'Move window to the left' })
vim.keymap.set('n', '<C-S-l>', '<C-w>L', { desc = 'Move window to the right' })
vim.keymap.set('n', '<C-S-j>', '<C-w>J', { desc = 'Move window to the lower' })
vim.keymap.set('n', '<C-S-k>', '<C-w>K', { desc = 'Move window to the upper' })

vim.keymap.set({'n', 'i'}, '<C-A-h>', function() vim.cmd(':tabp') end, { desc = 'Switch to previous tab' })
vim.keymap.set({'n', 'i'}, '<C-A-l>', function() vim.cmd(':tabn') end, { desc = 'Switch to next tab' })
vim.keymap.set({'n', 'i'}, '<C-A-S-h>', function() vim.cmd(':tabm-1') end, { desc = 'Move tab left' })
vim.keymap.set({'n', 'i'}, '<C-A-S-l>', function() vim.cmd(':tabm+1') end, { desc = 'Move tab right' })


-- [[ Autocommands ]]
--  See `:help lua-guide-autocommands`
vim.api.nvim_create_autocmd('TextYankPost', {
	desc = 'Highlight when yanking (copying) text',
	group = vim.api.nvim_create_augroup('mycfg-highlight-yank', { clear = true }),
	callback = function() vim.highlight.on_yank() end,
})

local filetype_group = vim.api.nvim_create_augroup('mycfg-filetype', { clear = true})
vim.api.nvim_create_autocmd('FileType', {
	group = filetype_group,
	pattern = "markdown",
	callback = function()
		vim.bo.expandtab = true
		vim.opt.colorcolumn = "80"
		vim.bo.textwidth = 79
	end
})

vim.api.nvim_create_autocmd('FileType', {
	group = filetype_group,
	pattern = "cmake",
	callback = function()
		vim.opt.colorcolumn = '81'
		vim.bo.formatoptions = 'croqlj'
	end
})


-- [[ Install `lazy.nvim` plugin manager ]]
--  See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
	local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
	if vim.v.shell_error ~= 0 then error('Error cloning lazy.nvim:\n' .. out) end
end

---@type vim.Option
local rtp = vim.opt.rtp
rtp:prepend(lazypath)


-- [[ Configure and install plugins ]]
--
--  Run `:Lazy` for the current plugin status,
--  `:Lazy update` to update the plugins
require('lazy').setup({
	{ 'NMAC427/guess-indent.nvim', opts = {} },

	-- { -- Adds git related signs to the gutter, as well as utilities for managing changes
	-- 	'lewis6991/gitsigns.nvim',
	-- 	---@module 'gitsigns'
	-- 	---@type Gitsigns.Config
	-- 	---@diagnostic disable-next-line: missing-fields
	-- 	opts = {
	-- 		signs = {
	-- 			add = { text = '+' }, ---@diagnostic disable-line: missing-fields
	-- 			change = { text = '~' }, ---@diagnostic disable-line: missing-fields
	-- 			delete = { text = '_' }, ---@diagnostic disable-line: missing-fields
	-- 			topdelete = { text = '‾' }, ---@diagnostic disable-line: missing-fields
	-- 			changedelete = { text = '~' }, ---@diagnostic disable-line: missing-fields
	-- 		},
	-- 	},
	-- },

	{ -- Useful plugin to show you pending keybinds.
		'folke/which-key.nvim',
		event = 'VimEnter',
		---@module 'which-key'
		---@type wk.Opts
		---@diagnostic disable-next-line: missing-fields
		opts = {
			-- delay between pressing a key and opening which-key (milliseconds)
			delay = 300,
			icons = { mappings = vim.g.have_nerd_font },

			-- Document existing key chains
			spec = {
				{ '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
				{ '<leader>t', group = '[T]oggle' },
				{ '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
				{ 'gr', group = 'LSP Actions', mode = { 'n' } },
			},
		},
	},

	{	-- Fuzzy Finder (files, lsp, etc.)
		'nvim-telescope/telescope.nvim',
		version = "0.2.x",
		enabled = true,
		event = 'VimEnter',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make',
				cond = function() return vim.fn.executable 'make' == 1 end,
			},
			{
				'nvim-telescope/telescope-ui-select.nvim'
			},
			{
				'nvim-tree/nvim-web-devicons',
				enabled = vim.g.have_nerd_font
			},
		},
		config = function()
			-- :Telescope help_tags
			-- While in telescope:
			--   - Insert mode: <c-/>
			--   - Normal mode: ?

			-- [[ Configure Telescope ]]
			-- See `:help telescope` and `:help telescope.setup()`
			require('telescope').setup {
				extensions = {
					['ui-select'] = { require('telescope.themes').get_dropdown() },
				},
			}

			-- Enable Telescope extensions if they are installed
			pcall(require('telescope').load_extension, 'fzf')
			pcall(require('telescope').load_extension, 'ui-select')

			-- See `:help telescope.builtin`
			local builtin = require 'telescope.builtin'
			vim.keymap.set('n', '<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
			vim.keymap.set('n', '<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
			vim.keymap.set('n', '<leader>sf', builtin.find_files, { desc = '[S]earch [F]iles' })
			vim.keymap.set('n', '<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
			vim.keymap.set({ 'n', 'v' }, '<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
			vim.keymap.set('n', '<leader>sg', builtin.live_grep, { desc = '[S]earch by [G]rep' })
			vim.keymap.set('n', '<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
			vim.keymap.set('n', '<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
			vim.keymap.set('n', '<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })
			vim.keymap.set('n', '<leader>sc', builtin.commands, { desc = '[S]earch [C]ommands' })
			vim.keymap.set('n', '<leader><leader>', builtin.buffers, { desc = '[ ] Find existing buffers' })

			-- Override default behavior and theme when searching
			vim.keymap.set('n', '<leader>/', function()
				builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
					winblend = 10,
					previewer = false,
				})
			end, { desc = '[/] Fuzzily search in current buffer' })

			-- Additional configuration options
			--  See `:help telescope.builtin.live_grep()`
			vim.keymap.set(
				'n',
				'<leader>s/',
				function()
					builtin.live_grep {
						grep_open_files = true,
						prompt_title = 'Live Grep in Open Files',
					}
				end,
				{ desc = '[S]earch [/] in Open Files' }
			)

			vim.keymap.set(
				'n',
				'<leader>sn',
				function() builtin.find_files { cwd = vim.fn.stdpath 'config' } end,
				{ desc = '[S]earch [N]eovim files' }
			)
		end
	},

	{   -- You can easily change to a different colorscheme.
		-- Change the name of the colorscheme plugin below, and then
		-- change the command in the config to whatever the name of that colorscheme is.
		--
		-- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
		'folke/tokyonight.nvim',
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require('tokyonight').setup {
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			}

			-- Load the colorscheme here.
			-- Like many other themes, this one has different styles, and you could load
			-- any other, such as 'tokyonight-storm', 'tokyonight-moon', or 'tokyonight-day'.
			vim.cmd.colorscheme 'tokyonight-night'
		end,
	},

	-- Highlight todo, notes, etc in comments
	{
		'folke/todo-comments.nvim',
		event = 'VimEnter',
		dependencies = { 'nvim-lua/plenary.nvim' },
		---@module 'todo-comments'
		---@type TodoOptions
		---@diagnostic disable-next-line: missing-fields
		opts = { signs = false },
	},

	-- mini.nvim: a collection of various small independent plugins/modules
	{
		'nvim-mini/mini.nvim',
		config = function()
			-- Better a/i textobjects
			--
			-- Examples:
			--  - va)  - [V]isually select [A]round [)]paren
			--  - yinq - [Y]ank [I]nside [N]ext [Q]uote
			--  - ci'  - [C]hange [I]nside [']quote
			require('mini.ai').setup { n_lines = 500 }

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			--  - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			--  - sd'   - [S]urround [D]elete [']quotes
			--  - sr)'  - [S]urround [R]eplace [)] [']
			require('mini.surround').setup()

			-- Simple and easy statusline
			local statusline = require 'mini.statusline'
			statusline.setup { use_icons = vim.g.have_nerd_font }

			-- Display cursor location as LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function() return '%2l:%-2v' end
		end,
	},

	-- Neo-tree
	{
		'nvim-neo-tree/neo-tree.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-tree/nvim-web-devicons',
				enabled = vim.g.have_nerd_font
			},
			'MunifTanjim/nui.nvim'
		},
		lazy = false,  -- neo-tree will lazily load itself
		keys = {
			{ '\\', ':Neotree reveal<CR>', desc = 'NeoTree reveal', silent = true },
		},
		---@module 'neo-tree
		---@type neotree.Config
		opts = {
			filesystem = {
				window = {
					mappings = {
						['\\'] = 'close_window',
					},
				},
			},
		},
	},
}, {
	ui = {
		-- Default to unicode icons if no nerdfont is avialable
		icons = vim.g.have_nerd_font and {} or {
			cmd = '⌘',
			config = '🛠',
			event = '📅',
			ft = '📂',
			init = '⚙',
			keys = '🗝',
			plugin = '🔌',
			runtime = '💻',
			require = '🌙',
			source = '📄',
			start = '🚀',
			task = '📌',
			lazy = '💤 ',
		},
	},
	rocks = { enabled = false },
	performance = { rtp = { reset = false }},
})
