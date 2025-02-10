-- Load configuration files from lua/ directory
require("keymaps")  -- loads lua/keymaps.lua
require("options")  -- loads lua/options.lua

-- Reload init.lua
local function reload_init()
    vim.cmd("source $MYVIMRC") -- Reloads the main configuration file
    print("Configuration reloaded!")
end

-- Expose the function via a command
vim.api.nvim_create_user_command('ReloadInit', function() reload_init() end, {})

-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Configure plugins using lazy.nvim
require("lazy").setup({
    { "wbthomason/packer.nvim" }, -- Optional, if needed
    { "nvim-lua/plenary.nvim" },
    { "neovim/nvim-lspconfig" },
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    {
        "kdheepak/lazygit.nvim",
        dependencies = { "nvim-lua/plenary.nvim" }, -- For floating window borders
    },
    {
	require("plugins.avante"),
	require("plugins.coq"),
    },
    -- Add vim-maximizer plugin
    {
        "szw/vim-maximizer",
        config = function()
            -- Optional key mapping for toggling maximizer
            vim.api.nvim_set_keymap("n", "<Leader>m", ":MaximizerToggle<CR>", { noremap = true, silent = true })
        end
    }
})

-- LSP Configuration
require('lspconfig').pyright.setup{
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
            },
        },
    },
}

