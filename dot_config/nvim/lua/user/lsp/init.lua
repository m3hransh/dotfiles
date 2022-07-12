local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

local servers = require("user.lsp.lsp-installer").servers
require("user.lsp.lspconfig").setup(servers)
require "user.lsp.null-ls"
require "user.lsp.go"
-- require "user.lsp.dap"
-- For debuging other than GO use this
-- require "user.lsp.dap"
