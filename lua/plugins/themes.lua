-- [nfnl] Compiled from fnl/plugins/themes.fnl by https://github.com/Olical/nfnl, do not edit.
local my = _G.my
local function _1_()
  return (require("plugins.config.themer")).setup()
end
local function _2_()
  vim.g.lush_jsx_contrast_dark = "hard"
  vim.g.lush_jsx_contrast_light = "hard"
  return (require("lush_jsx")).setup({langs = {"clojure", "css", "html", "js", "json", "jsx", "lua", "markdown", "python", "typescript", "viml", "xml"}, plugins = {"cmp", "gitsigns", "lsp", "lspsaga", "neogit", "telescope", "treesitter"}})
end
local function _3_()
  vim.g.monokaipro_filter = "spectrum"
  vim.g.monokaipro_italic_functions = true
  vim.g.monokaipro_sidebars = {"aerial"}
  vim.g.monokaipro_flat_term = true
  return nil
end
local function _4_()
  local auto_dark_mode = require("auto-dark-mode")
  local function _5_()
    return vim.api.nvim_set_option("background", "dark")
  end
  local function _6_()
    return vim.api.nvim_set_option("background", "light")
  end
  auto_dark_mode.setup({set_dark_mode = _5_, set_light_mode = _6_, update_interval = 1000})
  return vim.schedule(auto_dark_mode.init)
end
local function _7_()
  local function _8_(colors)
    return {Comment = {fg = colors.pink, italic = true}, ErrorMsg = {bg = my.color.my.red, fg = "black", standout = true}, Normal = {bg = colors.lmao}, NormalFloat = {link = my.color.my.lmao}}
  end
  return (require("one_monokai")).setup({colors = {blue = my.color.my.aqua, green = my.color.my.green, lmao = my.color.util.darken(my.color.util.desaturate(my.color.my.purple, 50), ((((vim.opt.background):get() == "light") and 0) or 90)), pink = my.color.util.desaturate(my.color.my.magenta, 50), roman = my.color.my.magenta}, themes = _8_, transparent = true})
end
local function _9_()
  vim.g.moonlight_italic_comments = true
  vim.g.moonlight_italic_keywords = true
  vim.g.moonlight_italic_functions = true
  vim.g.moonlight_italic_variables = false
  vim.g.moonlight_contrast = true
  vim.g.moonlight_borders = false
  vim.g.moonlight_disable_background = false
  return nil
end
local function _10_()
  return (require("ofirkai")).setup({})
end
local function _11_()
  vim.g.calvera_italic_keywords = true
  vim.g.calvera_borders = true
  vim.g.calvera_contrast = true
  vim.g.calvera_hide_eob = true
  vim.g.calvera_custom_colors = {contrast = "#0f111a"}
  vim.g.calvera_borders = false
  vim.g.calvera_disable_background = false
  vim.g.transparent_bg = true
  return nil
end
local function _12_()
  return (require("material")).setup({async_loading = true, contrast = {cursor_line = true, filetypes = {}, floating_windows = true, non_current_windows = true, sidebars = true, terminal = true}, custom_colors = nil, custom_highlights = {}, disable = {term_colors = false, borders = false, eob_lines = false, background = false, colored_cursor = false}, high_visibility = {darker = true, lighter = true}, lualine_style = "default", plugins = {"dap", "gitsigns", "hop", "indent-blankline", "neogit", "nvim-cmp", "nvim-navic", "nvim-web-devicons", "telescope", "trouble", "which-key"}, styles = {comments = {italic = true}, functions = {bold = true, italic = true}, keywords = {bold = true}, operators = {bold = true}, strings = {}, types = {italic = true}, variables = {italic = true}}})
end
local function _13_()
  return vim.cmd("        let g:PaperColor_Theme_Options = {\n          \\   'theme': {\n          \\     'default': {\n          \\       'allow_bold': 1,\n          \\       'allow_italic': 1\n          \\     }\n          \\   }\n          \\ }\n      ")
end
local function _14_()
  local fm = require("fluoromachine")
  local function _15_(_, d)
    return {alt_bg = d(my.color.my.vimode[vim.fn.mode()], 75), bg = my.color.my[(vim.opt.background):get()], cyan = my.color.my.aqua, orange = my.color.my.orange, pink = my.color.my.magenta, purple = my.color.my.purple, red = my.color.my.red, yellow = my.color.my.yellow}
  end
  return fm.setup({brightness = 0.2, colors = _15_, glow = true, overrides = {["@comment"] = {italic = true}, ["@constant"] = {bold = true, italic = false}, ["@field"] = {italic = true}, ["@function"] = {bold = true, italic = true}, ["@keyword"] = {bold = true, italic = false}, ["@parameter"] = {italic = true}, ["@type"] = {italic = true, bold = false}, ["@variable"] = {italic = true}}, theme = "retrowave", transparent = false})
end
return {{"themercorp/themer.lua", config = _1_}, {"savq/melange"}, {"joehannes-ux/lush-jsx.nvim", config = _2_}, {"akai54/2077.nvim"}, {"Abstract-IDE/Abstract-cs"}, {"olimorris/onedarkpro.nvim"}, {"pineapplegiant/spaceduck"}, {as = "monokaipro", config = _3_, dir = "https://gitlab.com/__tpb/monokai-pro.nvim"}, {"pappasam/papercolor-theme-slim"}, {"catppuccin/nvim", as = "catppuccin"}, {"joehannes-ux/kat.nvim"}, {"meijieru/edge.nvim", dependencies = {"rktjmp/lush.nvim"}}, {"folke/tokyonight.nvim"}, {"B4mbus/oxocarbon-lua.nvim"}, {"f-person/auto-dark-mode.nvim", config = _4_}, {"cpea2506/one_monokai.nvim", config = _7_}, {"theniceboy/nvim-deus"}, {"shaunsingh/moonlight.nvim", config = _9_}, {"yorik1984/newpaper.nvim", config = true}, {"ofirgall/ofirkai.nvim", config = _10_}, {"yashguptaz/calvera-dark.nvim", config = _11_}, {"marko-cerovac/material.nvim", config = _12_}, {"sainnhe/sonokai"}, {"NLKNguyen/papercolor-theme", config = _13_}, {"maxmx03/fluoromachine.nvim", config = _14_}}
