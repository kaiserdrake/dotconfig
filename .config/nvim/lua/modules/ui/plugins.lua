local ui = {}
local conf = require('modules.ui.config')

ui['hoob3rt/lualine.nvim'] = {
  config = conf.lualine,
  requires = {'kyazdani42/nvim-web-devicons', opt = true}
}

ui['joshdick/onedark.vim'] = {
  config = conf.onedark
}

ui['lewis6991/gitsigns.nvim'] = {
  event = {'BufRead', 'BufNewFile'},
  config = conf.gitsigns,
  requires = {'nvim-lua/plenary.nvim', opt = true}
}

ui['lukas-reineke/indent-blankline.nvim'] = {
  event = 'BufRead',
  branch = 'lua',
  config = conf.indent_blankline
}

ui['folke/which-key.nvim'] = {
  config = conf.which_key
}

return ui
