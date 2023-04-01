vim.g.bookmark_sign = " "
vim.g.bookmark_annotation_sign = " "
vim.g.bookmark_no_default_key_mappings = 1
vim.g.bookmark_auto_save = 0
vim.g.bookmark_auto_close = 0
vim.g.bookmark_manage_per_buffer = 0
vim.g.bookmark_save_per_working_dir = 0
vim.g.bookmark_show_warning = 0
vim.g.bookmark_center = 1
vim.g.bookmark_location_list = 0
vim.g.bookmark_disable_ctrlp = 1
vim.g.bookmark_display_annotation = 0

require('telescope').extensions.vim_bookmarks.all()
require('telescope').extensions.vim_bookmarks.current_file()

vim.keymap.set('n', 'ma', "<cmd>lua require('telescope').extensions.vim_bookmarks.all()<cr>")
vim.keymap.set('n', 'mn', "<cmd>lua require('telescope').extensions.vim_bookmarks.current_file()<cr>")
