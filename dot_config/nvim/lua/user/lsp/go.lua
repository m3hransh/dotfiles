local go_ok, go = pcall(require, "go")
if not go_ok then
  return
end
local path = require "nvim-lsp-installer.core.path"
local install_root_dir = path.concat { vim.fn.stdpath "data", "lsp_servers" }

go.setup {
  gopls_cmd = { install_root_dir .. "/go/gopls" },
  fillstruct = "gopls",
  dap_debug = true,
  dap_debug_gui = true,
}
