local base = require("plugins.configs.lspconfig")
local on_attach = base.on_attach
local capabilities = base.capabilities

local lspconfig = require("lspconfig")

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    client.server_capabilities.signatureHelpProvider = false
    on_attach(client, bufnr)
  end,
  capabilities = capabilities,
}

local function organize_imports()
  local params = {
    command = "_typescript.organizeImports",
    arguments = {vim.api.nvim_buf_get_name(0)},
  }
  vim.lsp.buf.execute_command(params)
end

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  init_options = {
    preferences = {
      disableSuggestions = true,
    }
  },
  commands = {
    OrganizeImports = {
      organize_imports,
      description = "Organize Imports",
    }
  }
}

-- Install @angular/language-server and @angular/language-service globally
local node_path = "/usr/lib/node_modules"
local node_cmd = {"ngserver", "--stdio", "--tsProbeLocations", node_path , "--ngProbeLocations", node_path}
lspconfig.angularls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  cmd = node_cmd,
  on_new_config = function(new_config, new_root_dir)
    new_config.cmd = node_cmd
  end,
}

