local utils = require('utils')

utils.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
utils.map('i', 'jk', '<Esc>')           -- jk to escape
utils.map('n', '<Leader>tt',':15sp +term<CR>a')
utils.map('n', '<Leader>fq',':q<CR>')

