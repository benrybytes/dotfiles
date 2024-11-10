-- Define the OpenMarkdownPreview function in Lua
vim.cmd([[
  function! OpenMarkdownPreview(url)
    execute "silent ! open -a Firefox -n --args --new-window " . a:url
  endfunction
]])

-- Set the global markdown preview browser function
vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
