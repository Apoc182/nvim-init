
vim.g.mapleader = " " -- This guy tells nvim what to use as the qualifier for the below custom commands.

-- Telescope Keybindings
vim.keymap.set('n', '<leader>ff', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fb', ':Telescope buffers<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>gd', ':Telescope lsp_definitions<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ls', ':Telescope lsp_document_symbols<CR>', { noremap = true, silent = true })

-- setup mapping to call :LazyGit
vim.api.nvim_set_keymap("n", "<leader>gg", ":LazyGit<CR>", { noremap = true, silent = true })


-- We dont want up and down (j and k) to go to the end of single line text.
vim.keymap.set("n", "j", "gj")
vim.keymap.set("n", "k", "gk")
vim.keymap.set("n", "<Down>", "gj")
vim.keymap.set("n", "<Up>", "gk")

-- Keybinding for copying to the system keyboard
vim.keymap.set('n', '<leader>clip', '"+y', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>clip', '"+y', { noremap = true, silent = true })

