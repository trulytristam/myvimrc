-- Initialize Packer
local packer = require('packer')

packer.startup(function()
    	-- Packer can manage itself
    	use 'wbthomason/packer.nvim'
    	use 'neovim/nvim-lspconfig' -- Neovim LSP client

    	use 'ggandor/leap.nvim'
    	use 'nvim-lua/plenary.nvim'
    	use 'nvim-telescope/telescope.nvim'
   	use 'rust-lang/rust.vim' -- Rust syntax and integration

    	use 'simrat39/rust-tools.nvim' -- Rust tools integration

    -- LSP and completion
    	
    	use 'hrsh7th/nvim-cmp' -- Completion framework
    	use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
	use 'hrsh7th/cmp-vsnip'
	use 'hrsh7th/vim-vsnip-integ'
    	use 'hrsh7th/vim-vsnip' -- Snippets support
	use 'preservim/nerdtree'


    	require('leap').setup({})
    	require('leap').create_default_mappings()

	-- nvim-cmp configuration
	vim.o.completeopt = 'menu,menuone,noselect'

	local cmp = require('cmp')
	cmp.setup({
	  snippet = {
	    expand = function(args)
	      vim.fn["vsnip#anonymous"](args.body)
	    end,
	  },

	  mapping = cmp.mapping.preset.insert({
	    ['<Tab>'] = cmp.mapping(function(fallback)
	      if cmp.visible() then
		cmp.select_next_item()
	      elseif vim.fn['vsnip#jumpable'](1)  == 1 then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-expand-or-jump)', true, true, true), '')
	      else
		fallback()  -- The actual key to be sent if none of the above conditions are met
	      end
	    end, { 'i', 's' }),

	    ['<S-Tab>'] = cmp.mapping(function(fallback)
	      if cmp.visible() then
		cmp.select_prev_item()
	      elseif vim.fn['vsnip#jumpable'](-1) == 1 then
		vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>(vsnip-jump-prev)', true, true, true), '')
	      else
		fallback()
	      end
	    end, { 'i', 's' }),
	    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
	    ['<C-f>'] = cmp.mapping.scroll_docs(4),
	    ['<C-Space>'] = cmp.mapping.complete(),
	    ['<C-e>'] = cmp.mapping.close(),
	    ['<CR>'] = cmp.mapping.confirm({ select = true }),
	  }),
	  sources = cmp.config.sources({
	    { name = 'nvim_lsp' },
	    { name = 'buffer' },
	    { name = 'vsnip' },
	    { name = 'path' }
	  })
	})

	-- You can set up specific configurations for different command-line modes
	cmp.setup.cmdline(':', {
	  sources = cmp.config.sources({
	    { name = 'path' }
	  }, {
	    { name = 'cmdline' }
	  })
	})

	use 'folke/tokyonight.nvim'           -- Tokyo Night
	use 'morhetz/gruvbox'                 -- Gruvbox
	use 'dracula/vim'                     -- Dracula
	use 'arcticicestudio/nord-vim'        -- Nord
	use 'mhartington/oceanic-next'        -- Oceanic Next
	use 'rebelot/kanagawa.nvim' 	      -- Kanagawa
	use 'joshdick/onedark.vim'            -- One Dark
	use 'altercation/vim-colors-solarized'-- Solarized
	use 'crusoexia/vim-monokai'           -- Monokai
	use 'rose-pine/neovim'                -- Rose Pine
	use 'sainnhe/everforest'              -- Everforest
	use 'ayu-theme/ayu-vim'               -- Ayu
	use 'sainnhe/gruvbox-material'        -- Gruvbox Material
	use 'navarasu/onedark.nvim'           -- OneDark (Neovim)
	use 'catppuccin/nvim'                 -- Catppuccin
	use 'ellisonleao/gruvbox.nvim'        -- Gruvbox (Neovim)
	use 'EdenEast/nightfox.nvim'          -- Nightfox
	use 'shaunsingh/nord.nvim'            -- Nord (Neovim)
	use 'projekt0n/github-nvim-theme'     -- GitHub theme for Neovim
	use 'marko-cerovac/material.nvim'     -- Materialk
	use 'ribru17/bamboo.nvim'             -- bamboo


	--fonts
	use 'tonsky/FiraCode'                 --firacode
end)

--Init LSP section
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local lspconfig = require('lspconfig')

lspconfig.rust_analyzer.setup({
	settings = {
		["rust-analyzer"]= {
			
		}
	}
})
vim.keymap.set('n', 'gd', '<cmd> lua vim.lsp.buf.definition() <CR>', {})
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>fm', '<cmd>lua vim.lsp.buf.formatting()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>dn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>dp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap=true, silent=true })
vim.api.nvim_set_keymap('n', '<leader>dl', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap=true, silent=true })


function SwitchTheme(theme)
  vim.cmd('colorscheme ' .. theme)
end
vim.cmd('colorscheme kanagawa')
vim.cmd [[
  hi Normal guibg=NONE ctermbg=NONE
  hi NormalNC guibg=NONE ctermbg=NONE
]]
--setting font
vim.g.neovide_font = "FiraCode"
--setup cmp with rust-analyzer

vim.opt.swapfile = false
vim.opt.number = true
vim.g.mapleader = ' '
vim.api.nvim_set_keymap('n', '<Leader>;', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', ':quit<CR>', {noremap = true, silent = true})

vim.api.nvim_create_user_command('SwitchTheme', function(opts) SwitchTheme(opts.args) end, {nargs=1})

--window navigation
vim.keymap.set('n', '<leader>wh','<C-w>h',{})
vim.keymap.set('n', '<leader>wj','<C-w>j',{})
vim.keymap.set('n', '<leader>wk','<C-w>k',{})
vim.keymap.set('n', '<leader>wl','<C-w>l',{})
vim.keymap.set('n', '<leader>o','<C-o>',{})
vim.keymap.set('n', '<leader>i','<C-i>',{})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
-- Open NERDTree with <Leader>n
vim.api.nvim_set_keymap('n', '<Leader>n', ':NERDTreeToggle<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '<leader>c', ':nohlsearch<CR>')
-- Show hidden files in NERDTree by default
vim.g.NERDTreeShowHidden = 1

vim.wo.wrap = false
vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'

--vim.api.nvim_buf_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', {noremap = true, silent = true}) 

vim.keymap.set('n', '<leader>rc', ':source $MYVIMRC <CR>') 
vim.keymap.set('n', '<leader>ps', ':PackerSync <CR>') 
vim.keymap.set('n', '<leader>pi', ':PackerInstall <CR>') 
vim.keymap.set('n', 'gs', '^') 
vim.keymap.set('n', 'gl', '$') 


