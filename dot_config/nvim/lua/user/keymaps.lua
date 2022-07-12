local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
  return
end

M = {}

local opts = { noremap = true, silent = true }

local function conf(new_opts)
  return vim.tbl_extend("force", opts, new_opts)
end
-- local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)

-- Navigate properly when lines are wrapped
keymap("n", "k", "gk", opts)
keymap("n", "j", "gj", opts)

-- Map Ctrl+S to save in any mode
keymap("n", "<C-S>", ":update<CR>", opts)
keymap("v", "<C-S>", "<C-C>:update<CR>", opts)
keymap("i", "<C-S>", "<C-O>:update<CR>", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Switch between the last two files
keymap("n", "<leader><leader>", "<c-^>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Insert --
-- Press jk fast to enter
keymap("i", "jk", "<ESC>", opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "p", '"_dP', conf { desc = "replace selected area with reg" })

-- Visual Block --
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

-- Packer
keymap(
  "n",
  "<leader>pc",
  "<cmd>PackerCompile<cr>",
  conf { desc = "Compile" }
)
keymap(
  "n",
  "<leader>pi",
  "<cmd>PackerInstall<cr>",
  conf { desc = "Install" }
)
keymap("n", "<leader>ps", "<cmd>PackerSync<cr>", conf { desc = "Sync" })
keymap(
  "n",
  "<leader>pS",
  "<cmd>PackerStatus<cr>",
  conf { desc = "Status" }
)
keymap(
  "n",
  "<leader>pu",
  "<cmd>PackerUpdate<cr>",
  conf { desc = "Update" }
)

-- Git
keymap(
  "n",
  "<leader>gg",
  "<cmd>lua _LAZYGIT_TOGGLE()<CR>",
  conf { desc = "Lazygit" }
)
keymap(
  "n",
  "<leader>gj",
  "<cmd>lua require 'gitsigns'.next_hunk()<cr>",
  conf { desc = "Next Hunk" }
)
keymap(
  "n",
  "<leader>gk",
  "<cmd>lua require 'gitsigns'.prev_hunk()<cr>",
  conf { desc = "Prev Hunk" }
)
keymap(
  "n",
  "<leader>gl",
  "<cmd>lua require 'gitsigns'.blame_line()<cr>",
  conf { desc = "Blame" }
)
keymap(
  "n",
  "<leader>gp",
  "<cmd>lua require 'gitsigns'.preview_hunk()<cr>",
  conf { desc = "Preview Hunk" }
)
keymap(
  "n",
  "<leader>gr",
  "<cmd>lua require 'gitsigns'.reset_hunk()<cr>",
  conf { desc = "Reset Hunk" }
)
keymap(
  "n",
  "<leader>gR",
  "<cmd>lua require 'gitsigns'.reset_buffer()<cr>",
  conf { desc = "Reset Buffer" }
)
keymap(
  "n",
  "<leader>gs",
  "<cmd>lua require 'gitsigns'.stage_hunk()<cr>",
  conf { desc = "Stage Hunk" }
)
keymap(
  "n",
  "<leader>gS",
  "<cmd>lua require 'gitsigns'.stage_buffer()<cr>",
  conf { desc = "Stage Buffer" }
)
keymap(
  "n",
  "<leader>gu",
  "<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
  conf { desc = "Undo Stage Hunk" }
)
keymap(
  "n",
  "<leader>gU",
  "<cmd>lua require 'gitsigns'.reset_buffer_index()<cr>",
  conf { desc = "Undo Buffer Stage" }
)
keymap(
  "n",
  "<leader>go",
  "<cmd>Telescope git_status<cr>",
  conf { desc = "Open Changed Files" }
)
keymap(
  "n",
  "<leader>gb",
  "<cmd>Telescope git_branches<cr>",
  conf { desc = "Checkout Branchs" }
)
keymap(
  "n",
  "<leader>gc",
  "<cmd>Telescope git_commits<cr>",
  conf { desc = "Checkout Commits" }
)
keymap(
  "n",
  "<leader>gD",
  "<cmd>Gitsigns diffthis HEAD<cr>",
  conf { desc = "Diff" }
)

-- LSP

local map = vim.api.nvim_buf_set_keymap

-- Conditional mapping based on server_capabilities
local function map_cond(cap, b, m, key, cmd)
  if cap then
    map(b, m, key, cmd, opts)
  end
end

local function which_cond(dict, cap, key, rhs, desc)
  if cap then
    dict[key] = { rhs, desc }
  end
end

M.lsp_keymaps = function(client, bufnr)
  local rc = client.server_capabilities
  vim.pretty_print(rc)

  -- Goto
  local keymap_g = {
    name = "Goto",
  }
  which_cond(
    keymap_g,
    rc.declarationProvider,
    "D",
    "<cmd>lua vim.lsp.buf.declaration()<CR>",
    "Goto Declaration"
  )
  which_cond(
    keymap_g,
    rc.definitionProvider,
    "d",
    "<cmd>lua vim.lsp.buf.definition()<CR>",
    "Goto Definition"
  )
  which_cond(
    keymap_g,
    rc.implementationProvider,
    "i",
    "<cmd>lua vim.lsp.buf.implementation()<CR>",
    "Goto Implementation"
  )
  which_cond(
    keymap_g,
    rc.typeDefinitionProvider,
    "t",
    "<cmd>lua vim.lsp.buf.type_definition()<CR>",
    "Goto Type Definition"
  )
  vim.pretty_print(keymap_g)
  which_key.register(keymap_g, { buffer = bufnr, prefix = "g" })
  -- Help
  map_cond(
    rc.hoverProvider,
    bufnr,
    "n",
    "K",
    "<cmd>lua vim.lsp.buf.hover()<CR>",
    conf { "Hover" }
  )
  which_cond(
    rc.signatureHelpProvider,
    bufnr,
    "n",
    "<C-k>",
    "<cmd>lua vim.lsp.buf.signature_help()<CR>",
    conf { "Signature Help" }
  )

  -- Code
  local keymap_l = {
    l = {
      name = "LSP",
      i = { "<cmd>LspInfo<cr>", "LSP Info" },
      I = { "<cmd>LspInstallInfo<cr>", "LSP Installer Info" },
      c = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Actions" },
      l = { "<cmd>Telescope diagnostics<CR>", "Diagnostics List" },
      d = {
        '<cmd>lua vim.diagnostic.open_float({border ="rounded" })<CR>',
        "Show Diagnostc",
      },
      q = { "<cmd>lua vim.diagnostic.setloclist()<CR>", "Quickfix" },
    },
  }
  which_cond(
    keymap_l.l,
    next(rc.codeActionProvider.codeActionKinds) ~= nil,
    "a",
    "<cmd>lua vim.lsp.buf.code_action()<CR>",
    "Code Actions"
  )
  which_cond(
    keymap_l.l,
    rc.documentFormattingProvider,
    "f",
    "<cmd>lua vim.lsp.buf.format { async=true }<CR>",
    "Format"
  )
  which_cond(
    keymap_l.l,
    rc.referencesProvider,
    "r",
    "<cmd>Telescope lsp_references<CR>",
    "References"
  )
  which_cond(
    keymap_l.l,
    rc.renameProvider.prepareProvider,
    "R",
    "<cmd>lua vim.lsp.buf.rename()<CR>",
    "Rename"
  )
  which_cond(
    keymap_l.l,
    rc.documentSymbolProvider,
    "s",
    "<cmd>Telescope lsp_document_symbols<cr>",
    "Document Symbols"
  )
  which_cond(
    keymap_l.l,
    rc.workspaceSymbolProvider,
    "S",
    "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
    "Workspace Symbols"
  )
  which_key.register(keymap_l, { buffer = bufnr, prefix = "<leader>" })
  -- Diagnostics
  map(
    bufnr,
    "n",
    "[d",
    '<cmd>lua vim.diagnostic.goto_prev({ border = "rounded" })<CR>',
    opts
  )
  map(
    bufnr,
    "n",
    "]d",
    '<cmd>lua vim.diagnostic.goto_next({ border = "rounded" })<CR>',
    opts
  )
  -- Workspace
  map(
    bufnr,
    "n",
    "<leader>wa",
    "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>",
    opts
  )
  map(
    bufnr,
    "n",
    "<leader>wr",
    "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>",
    opts
  )
  map(
    bufnr,
    "n",
    "<leader>wl",
    "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>",
    opts
  )

  -- you can use <leader>lf for formatting
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.format {async = true}' ]]
end
-- URL handling
-- source: https://sbulav.github.io/vim/neovim-opening-urls/
if vim.fn.has "mac" == 1 then
  keymap(
    "",
    "gx",
    '<Cmd>call jobstart(["open", expand("<cfile>")], {"detach": v:true})<CR>',
    {}
  )
elseif vim.fn.has "unix" == 1 then
  keymap(
    "",
    "gx",
    '<Cmd>call jobstart(["xdg-open", expand("<cfile>")], {"detach": v:true})<CR>',
    {}
  )
else
  keymap[""].gx = {
    '<Cmd>lua print("Error: gx is not supported on this OS!")<CR>',
  }
end
-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

return M
