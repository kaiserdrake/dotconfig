local wk = require('which-key')
local bind = require('keymap.bind')
local map_cr = bind.map_cr
local map_cu = bind.map_cu
local map_cmd = bind.map_cmd
local map_args = bind.map_args
require('keymap.config')

-- Mapping not requiring registration into which-key
local plug_map = {
    ["i|<TAB>"]          = map_cmd('v:lua.tab_complete()'):with_expr():with_silent(),
    ["i|<S-TAB>"]        = map_cmd('v:lua.s_tab_complete()'):with_silent():with_expr(),
    ["i|<CR>"]           = map_cmd([[compe#confirm({ 'keys': "\<Plug>delimitMateCR", 'mode': '' })]]):with_noremap():with_expr():with_nowait(),
   -- Lsp mapp work when insertenter and lsp start
    ["n|<leader>li"]     = map_cr("LspInfo"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>ll"]     = map_cr("LspLog"):with_noremap():with_silent():with_nowait(),
    ["n|<leader>lr"]     = map_cr("LspRestart"):with_noremap():with_silent():with_nowait(),
    ["n|<C-f>"]          = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|<C-b>"]          = map_cmd("<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>"):with_silent():with_noremap():with_nowait(),
    ["n|[e"]             = map_cr('Lspsaga diagnostic_jump_next'):with_noremap():with_silent(),
    ["n|]e"]             = map_cr('Lspsaga diagnostic_jump_prev'):with_noremap():with_silent(),
    ["n|K"]              = map_cr("Lspsaga hover_doc"):with_noremap():with_silent(),
    ["n|ga"]             = map_cr("Lspsaga code_action"):with_noremap():with_silent(),
    ["v|ga"]             = map_cu("Lspsaga range_code_action"):with_noremap():with_silent(),
    ["n|gd"]             = map_cr('Lspsaga preview_definition'):with_noremap():with_silent(),
    ["n|gD"]             = map_cmd("<cmd>lua vim.lsp.buf.implementation()<CR>"):with_noremap():with_silent(),
    ["n|gs"]             = map_cr('Lspsaga signature_help'):with_noremap():with_silent(),
    ["n|gr"]             = map_cr('Lspsaga rename'):with_noremap():with_silent(),
    ["n|gh"]             = map_cr('Lspsaga lsp_finder'):with_noremap():with_silent(),
    ["n|gt"]             = map_cmd("<cmd>lua vim.lsp.buf.type_definition()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>cw"]     = map_cmd("<cmd>lua vim.lsp.buf.workspace_symbol()<CR>"):with_noremap():with_silent(),
    ["n|<Leader>ce"]     = map_cr('Lspsaga show_line_diagnostics'):with_noremap():with_silent(),
    ["n|<Leader>ct"]     = map_args("Template"),
    ["n|<Leader>tf"]     = map_cu('DashboardNewFile'):with_noremap():with_silent(),
    -- Plugin Telescope
    ["n|<Leader>fa"]     = map_cu('DashboardFindWord'):with_noremap():with_silent(),
    ["n|<Leader>fb"]     = map_cu('Telescope file_browser'):with_noremap():with_silent(),
    ["n|<Leader>fg"]     = map_cu('Telescope git_files'):with_noremap():with_silent(),
    ["n|<Leader>fw"]     = map_cu('Telescope grep_string'):with_noremap():with_silent(),
    ["n|<Leader>fh"]     = map_cu('DashboardFindHistory'):with_noremap():with_silent(),
    ["n|<Leader>fl"]     = map_cu('Telescope loclist'):with_noremap():with_silent(),
    ["n|<Leader>fc"]     = map_cu('Telescope git_commits'):with_noremap():with_silent(),
    ["n|<Leader>ft"]     = map_cu('Telescope help_tags'):with_noremap():with_silent(),
    ["n|<Leader>fd"]     = map_cu('Telescope dotfiles path='..os.getenv("HOME")..'/.dotfiles'):with_noremap():with_silent(),
    ["n|<Leader>fs"]     = map_cu('Telescope gosource'):with_noremap():with_silent(),
    -- Plugin acceleratedjk
    ["n|j"]              = map_cmd('v:lua.enhance_jk_move("j")'):with_silent():with_expr(),
    ["n|k"]              = map_cmd('v:lua.enhance_jk_move("k")'):with_silent():with_expr(),
};

-- Register mappings to which-key
wk.register({
  -- Files
  ["<leader>f"] = {name = "+file"},
  ["<leader>ff"] = {"<cmd>Telescope find_files<cr>", "Find File"},
  ["<leader>fd"] = {"<cmd>Telescope dotfiles path="..os.getenv("HOME").."/.dotfiles<cr>", "Find Dotfile"},
  ["<leader>fb"] = {"<cmd>Telescope file_browser<cr>", "Browse File"},
  -- Buffer
  ["<leader>b"] = {name = "+buffer"},
  ["<leader>bb"] = {"<cmd>Telescope buffers<cr>", "Find Buffer"},
  -- Tools
  ["<leader>t"] = {name = "+tools"},
  ---- Packer
  ["<leader>tp"] = {name = "+packer"},
  ["<leader>tpu"] = {"<cmd>PackerUpdate<cr>", "PackerUpdate"},
  ["<leader>tpi"] = {"<cmd>PackerInstall<cr>", "PackerInstall"},
  ["<leader>tpc"] = {"<cmd>PackerCompile<cr>", "PackerCompile"},
  ["<leader>tpd"] = {"<cmd>PackerClean<cr>", "PackerClean"},
  ["<leader>tps"] = {"<cmd>PackerSync<cr>", "PackerSync"},
})

bind.nvim_load_mapping(plug_map)
