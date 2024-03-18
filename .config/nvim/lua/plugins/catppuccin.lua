return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  config = function()
    local U = require("catppuccin.utils.colors")
    require("catppuccin").setup({
      flavour = vim.env.CATPPUCCIN_FLAVOUR or "mocha",
      dim_inactive = {
        enabled = true,
        shade = "dark",
        percentage = 0.15,
      },
      integrations = {
        alpha = true,
        cmp = true,
        flash = true,
        gitsigns = true,
        hop = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        lsp_trouble = true,
        mason = true,
        mini = { enabled = true },
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true },
        neotest = true,
        noice = true,
        notify = true,
        neotree = true,
        octo = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        which_key = true,
      },
      custom_highlights = function(colors)
        return {
          -- for heirline
          TabLine = { fg = colors.surface2, bg = colors.base },
          TabLineFill = { fg = colors.fg, bg = colors.mantle },
          TabLineSel = { fg = colors.fg, bg = colors.base, italic = true },
          WinBar = { fg = colors.fg, bg = colors.base },
          -- for LSP
          LspInlayHint = { fg = U.blend(colors.overlay0, colors.surface0, 0.5), bg = colors.none },
          -- for folding (ufo)
          FoldCol0 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.95) },
          FoldCol1 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.90) },
          FoldCol2 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.85) },
          FoldCol3 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.80) },
          FoldCol4 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.75) },
          FoldCol5 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.70) },
          FoldCol6 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.65) },
          FoldCol7 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.60) },
          FoldCol8 = { fg = colors.text, bg = U.blend(colors.base, colors.text, 0.55) },
        }
      end,
    })
    vim.cmd.colorscheme("catppuccin")
  end,
}
