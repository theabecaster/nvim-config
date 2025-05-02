-- Swift Development Configuration

-- Configure SourceKit-LSP for Swift
local sourcekit_setup = function()
  local lspconfig = require('lspconfig')
  
  -- Setup SourceKit-LSP
  lspconfig.sourcekit.setup {
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    -- Enable file watching for Swift files
    capabilities = {
      workspace = {
        didChangeWatchedFiles = {
          dynamicRegistration = true,
        },
      },
    },
    -- Set the sourcekit-lsp root dir to find project file structure correctly
    root_dir = function(filename, _)
      return lspconfig.util.root_pattern("Package.swift", "*.xcodeproj", "*.xcworkspace")(filename)
        or lspconfig.util.root_pattern("*.swift")(filename)
        or lspconfig.util.find_git_ancestor(filename)
    end,
    -- Ensure sourcekit can find the Swift compiler and tools
    cmd = {
      "sourcekit-lsp"
    },
    -- Add settings to improve symbol resolution
    settings = {
      sourcekit = {
        diagnostics = true,
        indexing = {
          enabled = true
        }
      }
    },
    on_attach = function(client, bufnr)
      -- Custom handling for Swift files
      vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
      
      -- Force indexing of the project on buffer open
      vim.defer_fn(function()
        if client.name == "sourcekit" then
          client.request("workspace/executeCommand", {
            command = "sourcekit.index"
          })
        end
      end, 1000)
    end
  }
end

-- Only configure SourceKit if LSP is available
if pcall(require, 'lspconfig') then
  sourcekit_setup()
end

-- Add Swift snippets
if pcall(require, 'luasnip') then
  local ls = require('luasnip')
  
  -- Add Swift snippets
  ls.add_snippets("swift", {
    -- Public access control
    ls.snippet("pub", {
      ls.text_node("public "),
      ls.insert_node(0)
    }),
    
    -- Private access control
    ls.snippet("priv", {
      ls.text_node("private "),
      ls.insert_node(0)
    }),
    
    -- If statement
    ls.snippet("if", {
      ls.text_node("if "),
      ls.insert_node(1),
      ls.text_node(" {"),
      ls.text_node({"", "  "}),
      ls.insert_node(2),
      ls.text_node({"", "}"}),
      ls.insert_node(0)
    }),
    
    -- If let
    ls.snippet("ifl", {
      ls.text_node("if let "),
      ls.insert_node(1),
      ls.text_node(" = "),
      ls.insert_node(2, ""),
      ls.text_node(" {"),
      ls.text_node({"", "  "}),
      ls.insert_node(3),
      ls.text_node({"", "}"}),
      ls.insert_node(0)
    }),
    
    -- Function declaration
    ls.snippet("func", {
      ls.text_node("func "),
      ls.insert_node(1),
      ls.text_node("("),
      ls.insert_node(2),
      ls.text_node(") "),
      ls.insert_node(3),
      ls.text_node("{"),
      ls.text_node({"", "  "}),
      ls.insert_node(0),
      ls.text_node({"", "}"})
    }),
    
    -- Async function declaration
    ls.snippet("funca", {
      ls.text_node("func "),
      ls.insert_node(1),
      ls.text_node("("),
      ls.insert_node(2),
      ls.text_node(") async "),
      ls.insert_node(3),
      ls.text_node("{"),
      ls.text_node({"", "  "}),
      ls.insert_node(0),
      ls.text_node({"", "}"})
    }),
    
    -- Guard statement
    ls.snippet("guard", {
      ls.text_node("guard "),
      ls.insert_node(1),
      ls.text_node(" else {"),
      ls.text_node({"", "  "}),
      ls.insert_node(2),
      ls.text_node({"", "}"}),
      ls.insert_node(0)
    }),
    
    -- Main entry point
    ls.snippet("main", {
      ls.text_node("@main public struct "),
      ls.insert_node(1, "App"),
      ls.text_node(" {"),
      ls.text_node({"", "  "}),
      ls.text_node("public static func main() {"),
      ls.text_node({"", "    "}),
      ls.insert_node(2),
      ls.text_node({"", "  }"}),
      ls.text_node({"", "}"}),
      ls.insert_node(0)
    }),
  })
end 