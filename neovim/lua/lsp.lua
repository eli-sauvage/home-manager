local lspconfig = require("lspconfig")

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.enable("nil_ls")
vim.lsp.config("nil_ls", {
	capabilities = capabilities,
})

--[[ lspconfig.rust_analyzer.setup({ 
    capabilities = capabilities, 
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                targetDir = true
            },
        },
    },
}) ]]
vim.g.rustaceanvim = {
	-- Plugin configuration
	tools = {},
	-- LSP configuration
	server = {
		on_attach = function(client, bufnr)
			-- you can also put keymaps in here
		end,
		default_settings = {
			-- rust-analyzer language server configuration
			["rust-analyzer"] = {
				check = { command = "check" },
				cargo = { targetDir = true },
			},
		},
	},
	-- DAP configuration
	dap = {},
}

vim.g.rustfmt_autosave = 1

vim.lsp.enable("ts_ls")
vim.lsp.config("ts_ls", { capabilities = capabilities })
--[[ vim.lsp.enable("denols")
vim.lsp.config("denols", {
	capabilities = capabilities,
	-- root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}) ]]

vim.lsp.enable("pyright")
vim.lsp.config("pyright", { capabilities = capabilities })

require("lspsaga").setup({})

vim.api.nvim_set_keymap("n", "<Space>lr", "<cmd>Lspsaga rename<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>d", "<cmd>Lspsaga diagnostic_jump_next<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>D", "<cmd>Lspsaga diagnostic_jump_prev<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>la", "<cmd>Lspsaga code_action<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>ld", "<cmd>Lspsaga goto_definition<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>lD", "<cmd>Lspsaga goto_type_definition<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<Space>lf", "<cmd>Lspsaga finder<cr>", { noremap = true, silent = true })
