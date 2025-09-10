" ============================
" Neovim plugin-specific config (Lua inside init.vim)
" ============================
if has('nvim')
lua << 'EOF'
-- Helper: safe require
local function okreq(mod)
  local ok, m = pcall(require, mod)
  return ok and m or nil
end

-- ============================
-- Theme (dracula)
-- ============================
vim.cmd.colorscheme('dracula')

-- ============================
-- nvim-tree (file explorer)
-- ============================
local nvimtree = okreq('nvim-tree')
if nvimtree then
  nvimtree.setup({
    disable_netrw = true,
    hijack_netrw = true,
    hijack_cursor = true,
    sync_root_with_cwd = true,
    update_focused_file = { enable = true, update_root = false },
    filters = { dotfiles = false, custom = { '.git', '__pycache__', '.DS_Store', '.terraform' } },
    view = { width = 35, preserve_window_proportions = true },
    renderer = {
      highlight_git = true,
      icons = { show = { file = true, folder = true, git = true } },
    },
    actions = { open_file = { quit_on_open = false } },
  })

  -- Auto-open on "nvim <dir>" and on empty start (no stdin, no args)
  local function should_open()
    return vim.fn.argc() == 0 and vim.fn.exists('s:std_in') == 0
  end
  vim.api.nvim_create_autocmd('VimEnter', {
    callback = function()
      if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
        vim.cmd('cd ' .. vim.fn.fnameescape(vim.fn.argv(0)))
        require('nvim-tree.api').tree.open()
        return
      end
      if should_open() then
        require('nvim-tree.api').tree.open()
        vim.cmd('wincmd p')
      end
    end
  })
  -- Quit neovim if nvim-tree is the last window
  vim.api.nvim_create_autocmd('BufEnter', {
    callback = function()
      local wins = #vim.api.nvim_list_wins()
      local bufname = vim.api.nvim_buf_get_name(0)
      if wins == 1 and bufname:match('NvimTree_') then
        vim.cmd('quit')
      end
    end
  })
end

-- Keymaps for nvim-tree
vim.keymap.set('n', '<leader>nn', '<cmd>NvimTreeToggle<CR>', { silent = true, desc = 'NvimTree Toggle' })
vim.keymap.set('n', '<leader>nf', '<cmd>NvimTreeFindFile<CR>', { silent = true, desc = 'NvimTree Find File' })
vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { silent = true })
vim.keymap.set('n', '<C-f>', '<cmd>NvimTreeFindFile<CR>', { silent = true })

-- ============================
-- Telescope (files / ripgrep / buffers / help)
-- ============================
local telescope = okreq('telescope')
if telescope then
  local actions = require('telescope.actions')
  telescope.setup({
    defaults = {
      mappings = {
        i = { ['<esc>'] = actions.close },
      },
      file_ignore_patterns = { '.git/', 'node_modules/', '__pycache__/' },
      layout_strategy = 'flex',
    }
  })
  -- fzf-native extension (if compiled)
  pcall(telescope.load_extension, 'fzf')
end

-- Define :Rg using Telescope (respects .gitignore)
vim.api.nvim_create_user_command('Rg', function(opts)
  require('telescope.builtin').live_grep({ default_text = table.concat(opts.fargs, ' ') })
end, { nargs = '*', complete = 'file' })

-- Telescope keymaps
local tb = require('telescope.builtin')
vim.keymap.set('n', '<leader>f', tb.find_files, { silent = true, desc = 'Files' })
vim.keymap.set('n', '<leader>g', tb.live_grep,  { silent = true, desc = 'Grep' })
vim.keymap.set('n', '<leader>b', tb.buffers,    { silent = true, desc = 'Buffers' })
vim.keymap.set('n', '<leader>h', tb.help_tags,  { silent = true, desc = 'Help' })
vim.keymap.set('n', '<leader><leader>', tb.resume, { silent = true, desc = 'Resume' })

-- Improve :grep (ripgrep)
if vim.fn.executable('rg') == 1 then
  vim.o.grepprg   = "rg --vimgrep --smart-case --hidden --glob '!.git'"
  vim.o.grepformat= "%f:%l:%c:%m"
end

-- ============================
-- Git: gitsigns + fugitive
-- ============================
local gitsigns = okreq('gitsigns')
if gitsigns then
  gitsigns.setup({
    signs = {
      add = { text = '│' }, change = { text = '│' }, delete = { text = '_' },
      topdelete = { text = '‾' }, changedelete = { text = '~' },
    },
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true, desc = desc })
      end
      map('n', ']c', gs.next_hunk, 'Next hunk')
      map('n', '[c', gs.prev_hunk, 'Prev hunk')
      map('n', '<leader>hs', gs.stage_hunk, 'Stage hunk')
      map('n', '<leader>hr', gs.reset_hunk, 'Reset hunk')
      map('n', '<leader>hb', gs.blame_line, 'Blame line')
    end,
  })
end

-- ============================
-- UI: lualine / bufferline / which-key / indent guides
-- ============================
local lualine = okreq('lualine')
if lualine then
  lualine.setup({ options = { theme = 'dracula', section_separators = '', component_separators = '' } })
end

local bufferline = okreq('bufferline')
if bufferline then
  bufferline.setup({})
  vim.keymap.set('n', '<S-l>', '<cmd>BufferLineCycleNext<CR>', { silent = true })
  vim.keymap.set('n', '<S-h>', '<cmd>BufferLineCyclePrev<CR>', { silent = true })
end

local whichkey = okreq('which-key')
if whichkey then whichkey.setup({}) end

local ibl = okreq('ibl') or okreq('indent_blankline')
if ibl and ibl.setup then ibl.setup({}) end

-- ============================
-- Editing QoL (Lua versions)
-- ============================
local comment = okreq('Comment')
if comment then comment.setup({}) end

local surround = okreq('nvim-surround')
if surround then surround.setup({}) end

local autopairs = okreq('nvim-autopairs')
if autopairs then autopairs.setup({}) end

local leap = okreq('leap')
if leap then leap.add_default_mappings(true) end

-- Keep bbye, eunuch, abolish, rooter, editorconfig without extra setup

-- ============================
-- Treesitter
-- ============================
local ts = okreq('nvim-treesitter.configs')
if ts then
  ts.setup({
    ensure_installed = { 'lua','vim','vimdoc','bash','json','yaml','markdown','markdown_inline',
                         'html','css','javascript','typescript','tsx','python','go','rust','dockerfile' },
    highlight = { enable = true },
    indent = { enable = true },
    textobjects = { select = { enable = true } },
  })
end

-- ============================
-- LSP + Mason + nvim-cmp (minimal)
-- ============================
local lsp = okreq('lspconfig')
local mason = okreq('mason')
local mason_lsp = okreq('mason-lspconfig')
local cmp = okreq('cmp')
local cmp_lsp = okreq('cmp_nvim_lsp')

if mason and mason_lsp and lsp then
  mason.setup({})
  mason_lsp.setup({
    ensure_installed = { 'lua_ls','tsserver','pyright','bashls','dockerls','gopls','rust_analyzer','yamlls','terraformls','jsonls','html','cssls' },
    automatic_installation = false,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if cmp_lsp then
    capabilities = cmp_lsp.default_capabilities(capabilities)
  end

  mason_lsp.setup_handlers({
    function(server)
      lsp[server].setup({ capabilities = capabilities })
    end,
  })
end

-- nvim-cmp (basic)
if cmp then
  local luasnip = okreq('luasnip')
  if luasnip then require('luasnip.loaders.from_vscode').lazy_load() end
  cmp.setup({
    snippet = {
      expand = function(args) if luasnip then luasnip.lsp_expand(args.body) end end
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<CR>']      = cmp.mapping.confirm({ select = true }),
      ['<Tab>']     = cmp.mapping.select_next_item(),
      ['<S-Tab>']   = cmp.mapping.select_prev_item(),
    }),
    sources = {
      { name = 'nvim_lsp' }, { name = 'path' }, { name = 'buffer' },
    },
  })
end

-- ============================
-- Trouble / TODO / Conform / Toggleterm
-- ============================
local trouble = okreq('trouble')
if trouble then trouble.setup({}) end
vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', { silent = true, desc = 'Trouble: diagnostics' })

local todoc = okreq('todo-comments')
if todoc then todoc.setup({}) end
vim.keymap.set('n', '<leader>td', '<cmd>TodoTrouble<CR>', { silent = true, desc = 'TODOs in Trouble' })

local conform = okreq('conform')
if conform then
  conform.setup({
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black', 'isort' },
      javascript = { 'prettier' }, typescript = { 'prettier' },
      json = { 'prettier' }, yaml = { 'prettier' }, markdown = { 'prettier' },
      terraform = { 'terraform_fmt' },
    },
  })
  vim.keymap.set('n', '<leader>fm', function() conform.format({ async = true }) end,
    { silent = true, desc = 'Format (conform)' })
end

local toggleterm = okreq('toggleterm')
if toggleterm then
  toggleterm.setup({})
  vim.keymap.set({ 'n', 't' }, '<C-`>', '<cmd>ToggleTerm<CR>', { silent = true, desc = 'Toggle terminal' })
end
EOF
endif
