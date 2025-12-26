return {
  'NvChad/ui',
  branch = 'v3.0',
  lazy = false,
  after = 'base46',
  config = function()
    require('nvchad')
  end,
}
