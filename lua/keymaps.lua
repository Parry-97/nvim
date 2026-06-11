vim.g.mapleader = " "

vim.keymap.set("n", "qq", ":nohl<CR>", { desc = "Clear highlights", silent = true })
vim.keymap.set("n", "<C-c>", ":lua MiniSnippets.session.stop()<CR>", { desc = "Clear highlights", silent = true })

vim.keymap.set("n", "L", ":bNext<CR>", { desc = "Next Buffer", silent = true })
vim.keymap.set("n", "H", ":bprevious<CR>", { desc = "Previous Buffer", silent = true })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer", silent = true })

vim.keymap.set("v", "<", "<gv", { desc = "Indent left and keep selection", silent = true })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right and keep selection", silent = true })
vim.keymap.set("n", "<leader>qq", ":q<CR>", { desc = "Quit", silent = true })

vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })

vim.keymap.set({ "n", "x", "o" }, "s", function()
	require("flash").jump()
end, { desc = "Flash Jump" })
