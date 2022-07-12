local M = {}

local status_ok, lspconfig = pcall(require, "lspconfig")
if not status_ok then
  return
end

local handlers = require "user.lsp.handlers"

local function config(_config)
  return vim.tbl_deep_extend("force", {
    capabilities = handlers.capabilities,
    on_attach = handlers.on_attach,
  }, _config or {})
end

M.setup = function(servers)
  -- all the general lspconfig config is in handlers
  handlers.setup()
  local opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }
  for _, server in pairs(servers) do
    if server == "sumneko_lua" then
      lspconfig[server].setup(
        config(require "user.lsp.settings.sumneko_lua")
      )
    elseif server == "jsonls" then
      lspconfig[server].setup(config(require "user.lsp.settings.jsonls"))
    elseif server == "gopls" then
      local go_opts = require("go.lsp").config()
      opts = vim.tbl_deep_extend("force", opts, go_opts)
      lspconfig[server].setup(config())
    else
      lspconfig[server].setup(config())
    end
  end
end

return M
