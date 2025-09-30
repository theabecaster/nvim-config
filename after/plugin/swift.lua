-- Swift Development Configuration

-- Configure SourceKit-LSP for Swift
local sourcekit_setup = function()
  vim.lsp.config('sourcekit', {
    cmd = { "sourcekit-lsp" },
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    filetypes = { 'swift' },
    root_markers = { "Package.swift", "*.xcodeproj", "*.xcworkspace", "*.swift", ".git" },
    settings = {
      sourcekit = {
        diagnostics = true,
        indexing = {
          enabled = true
        }
      }
    },
  })
end

-- Configure SourceKit
sourcekit_setup()

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