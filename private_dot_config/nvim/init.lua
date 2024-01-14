--- @diagnostic disable: undefined-global
vim.g.mapleader = " "

require("init_lazy")
require("settings")
require("keymaps")
require("autocmds")
--local swiss_cheese = require("discipline.swiss_cheese")
--swiss_cheese.discipline()


