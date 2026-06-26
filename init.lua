-- Shared Neovim config. On Linux this file is sufficient on its own; windows.lua
-- is not needed. On Windows, this file sources windows.lua at the bottom to
-- apply platform-specific settings. The two Windows-specific hooks in this file
-- are the toggleterm shell option (see comment there) and the require("windows")
-- call at the bottom.

-- Disable built-in netrw file explorer (replaced by nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Set <leader> to space (must be set before lazy.setup so plugin keymaps see it)
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Double-leader toggles between the two most recent buffers
vim.keymap.set("n", "<leader><leader>", "<C-^>", { desc = "Toggle alternate buffer" })

-- Line numbers (absolute on current line, relative elsewhere)
vim.opt.number = true
vim.opt.relativenumber = true

-- Navigate between splits with Ctrl + h/j/k/l (instead of <C-w> h/j/k/l)
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left split" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to split below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to split above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right split" })

-- Clear search highlight (was <C-l>'s default before the remap above)
vim.keymap.set("n", "<leader>l", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Exit terminal-mode with <Esc><Esc> (double-tap, avoids shadowing a single Esc in the shell)
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Exit insert mode by typing jk or kj quickly (avoids reaching for <Esc>)
vim.opt.timeoutlen = 350
vim.keymap.set("i", "jk", "<Esc>")
vim.keymap.set("i", "kj", "<Esc>")

-- Show a vertical guide at column 80 to flag long lines
vim.opt.colorcolumn = "80"

-- Indentation: 4-space soft tabs
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.smartindent = true

-- Case-insensitive search unless the pattern contains uppercase
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Editor UX
vim.opt.scrolloff = 8                 -- keep 8 lines of context above/below cursor
vim.opt.signcolumn = "yes"            -- always show sign column to avoid layout shift
vim.opt.termguicolors = true          -- enable 24-bit colors
vim.opt.undofile = true               -- persistent undo across sessions
vim.opt.clipboard = "unnamedplus"     -- use system clipboard for yank/paste

-- What :mksession captures (buffers, tabs, window layout, cwd, folds, terminals
-- winpos, and localoptions)
vim.opt.sessionoptions = "buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Spellcheck language (enabled per-filetype below)
vim.opt.spelllang = "en_us"

-- Bootstrap lazy.nvim plugin manager: clone it on first launch if missing
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Plugins
require("lazy").setup({
    -- File tree sidebar, toggled with <leader>e
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup({})
            vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<cr>", { desc = "Toggle file tree" })
        end,
    },
    -- Fuzzy finder
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        keys = {
            { "<leader>ff", function() require("fzf-lua").files() end,        desc = "Find files" },
            { "<leader>fg", function() require("fzf-lua").live_grep() end,    desc = "Live grep" },
            { "<leader>fb", function() require("fzf-lua").buffers() end,      desc = "Buffers" },
            { "<leader>fh", function() require("fzf-lua").help_tags() end,    desc = "Help tags" },
            { "<leader>fr", function() require("fzf-lua").oldfiles() end,     desc = "Recent files" },
            { "<leader>fw", function() require("fzf-lua").grep_cword() end,   desc = "Grep word under cursor" },
            { "<leader>fl", function() require("fzf-lua").blines() end,       desc = "Search lines in buffer" },
            { "<leader>fz", function() require("fzf-lua").resume() end,       desc = "Resume last search" },
        },
        config = function()
            require("fzf-lua").setup({ "default" })
        end,
    },
    -- Buffer tabline
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        event = "VeryLazy",
        keys = {
            { "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
            { "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
            { "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete buffer" },
            { "<leader>bp", "<cmd>BufferLinePick<cr>", desc = "Pick buffer" },
        },
        opts = {
            options = {
                diagnostics = "nvim_lsp",
                offsets = {
                    { filetype = "NvimTree", text = "File Explorer", separator = true },
                },
                show_buffer_close_icons = true,
                show_close_icon = false,
            },
        },
    },
    -- Auto-save / restore the session per working directory
    {
        "folke/persistence.nvim",
        event = "BufReadPre",
        opts = {},
        keys = {
            { "<leader>qs", function() require("persistence").load() end,                desc = "Restore session (cwd)" },
            { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore last session" },
            { "<leader>qd", function() require("persistence").stop() end,                desc = "Don't save current session" },
        },
    },
    -- VSCode color scheme
    {
       "Mofiqul/vscode.nvim",
       lazy = false,
       priority = 1000,
       config = function()
           require("vscode").setup({
               style = "dark",
               italic_comments = true,
           })
          vim.cmd.colorscheme("vscode")
      end,
    },
    -- Popup showing available keybindings after <leader>
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        opts = {
            -- Group labels for your <leader> prefixes (shown in the popup)
            spec = {
                { "<leader>f", group = "Find (fzf)" },
                { "<leader>b", group = "Buffer" },
                { "<leader>q", group = "Session" },
                { "<leader>d", group = "Diagnostics" },
                { "<leader>r", group = "Rename/Refactor" },
                { "<leader>c", group = "Code" },
            },
        },
        keys = {
            {
                "<leader>?",
                function() require("which-key").show({ global = false }) end,
                desc = "Buffer-local keymaps (which-key)",
            },
        },
    },
    -- Treesitter: better syntax highlighting + indentation
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "lua", "vim", "vimdoc", "python", "markdown", "markdown_inline", "bash", "json", "yaml", "matlab" },
                auto_install = true,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },
    -- Mason: manages external tools (LSP servers, formatters, linters)
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        build = ":MasonUpdate",
        opts = {},
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
        opts = {
            ensure_installed = { "lua_ls", "pyright" },
            automatic_installation = true,
        },
    },
    -- Statusline
    {
        "itchyny/lightline.vim",
        event = "VeryLazy",
        init = function()
            -- Redundant with lightline's own mode indicator; avoid the duplicate.
            vim.opt.showmode = false
        end,
        config = function()
            vim.g.lightline = {
                colorscheme = "wombat",
                -- Let bufferline manage the tabline and lightline manage the
                -- statusline.
                enable = { statusline = 1, tabline = 0 },
                active = {
                    left = {
                        { "mode", "paste" },
                        { "readonly", "filename", "modified" },
                    },
                },
            }
        end,
    },
    -- Toggleable floating terminal (full overlay, no split)
    {
        "akinsho/toggleterm.nvim",
        version = "*",
        keys = {
            { "<C-\\>", "<cmd>ToggleTerm<cr>", desc = "Toggle terminal" },
            { "<C-\\>", "<cmd>ToggleTerm<cr>", mode = "t", desc = "Toggle terminal" },
        },
        opts = {
            direction = "float",
            start_in_insert = true,
            -- lazy.nvim evaluates this opts table at lazy.setup() time, before
            -- windows.lua runs, so vim.o.shell would still be cmd.exe by then.
            -- Detect Windows here directly so the correct shell is captured early.
            shell = vim.fn.has("win32") == 1 and "powershell" or vim.o.shell,
            float_opts = {
                border = "curved",
                width = function() return math.floor(vim.o.columns * 0.85) end,
                height = function() return math.floor(vim.o.lines * 0.85) end,
            },
        },
    },
    -- LSP configurations (Neovim 0.11+ API: vim.lsp.config / vim.lsp.enable)
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Buffer-local keymaps when an LSP attaches
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local buf = args.buf
                    local map = function(mode, lhs, rhs, desc)
                        vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
                    end
                    map("n", "gd", vim.lsp.buf.definition, "Go to definition")
                    map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
                    map("n", "gr", vim.lsp.buf.references, "References")
                    map("n", "gi", vim.lsp.buf.implementation, "Implementation")
                    map("n", "K",  vim.lsp.buf.hover, "Hover docs")
                    map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
                    map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
                    map("n", "<leader>fm", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
                    map("n", "[d", vim.diagnostic.goto_prev, "Prev diagnostic")
                    map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
                    map("n", "<leader>dl", vim.diagnostic.open_float, "Line diagnostics")
                end,
            })

            -- Apply default capabilities (from nvim-cmp) to every server
            vim.lsp.config("*", { capabilities = capabilities })

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { checkThirdParty = false },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config("pyright", {})

            vim.lsp.enable({ "lua_ls", "pyright" })

            -- MATLAB language server (install separately; not managed by Mason).
            -- Requires `matlab-language-server` on PATH.
            if vim.fn.executable("matlab-language-server") == 1 then
                vim.lsp.config("matlab_ls", {
                    settings = {
                        MATLAB = {
                            indexWorkspace = true,
                            installPath = "/usr/local/MATLAB/R2025b",
                            matlabConnectionTiming = "onDemand",
                            telemetry = false,
                        },
                    },
                })
                vim.lsp.enable("matlab_ls")
            end
        end,
    },
    -- Autocompletion
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            cmp.setup({
                snippet = {
                    expand = function(args) luasnip.lsp_expand(args.body) end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                    ["<C-f>"] = cmp.mapping.scroll_docs(4),
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                }, {
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },
})

-- Enable spellcheck for prose filetypes only
vim.api.nvim_create_autocmd("FileType", {
    pattern = { "markdown", "gitcommit", "text" },
    callback = function()
        vim.opt_local.spell = true
    end,
})

-- Jump to the last cursor position when reopening a file
vim.api.nvim_create_autocmd("BufReadPost", {
    callback = function(args)
        -- Skip commit/rebase buffers — these should start at the top
        local ft = vim.bo[args.buf].filetype
        if ft == "gitcommit" or ft == "gitrebase" then
            return
        end
        local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
        local line = mark[1]
        local last = vim.api.nvim_buf_line_count(args.buf)
        -- Only jump if the saved line is valid and within the file
        if line > 0 and line <= last then
            vim.api.nvim_buf_set_mark(args.buf, '"', line, mark[2], {})
            pcall(vim.api.nvim_win_set_cursor, 0, { line, mark[2] })
        end
    end,
})

-- Auto-restore the cwd session, but only when nvim is launched with no file
-- arguments (so `nvim somefile.m` still opens just that file).
vim.api.nvim_create_autocmd("VimEnter", {
    group = vim.api.nvim_create_augroup("persistence_restore", { clear = true }),
    nested = true,
    callback = function()
        if vim.fn.argc(-1) == 0 then
            require("persistence").load()
        end
    end,
})

-- Load platform-specific settings. windows.lua lives alongside this file and
-- adds anything that only makes sense on Windows (e.g. PowerShell as the shell).
if vim.fn.has("win32") == 1 then
    require("windows")
end
