-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

-- delete LazyVim global defaults
vim.keymap.del("n", "<leader>wd")

-- setup own global keymaps
map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save File" })
