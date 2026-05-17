require("blckhrt.config")
require("lz.n").load({
    {
        "nvim-autopairs",
        event = "InsertEnter",
        after = function()
            require("nvim-autopairs").setup({})
        end,
    },

    {
        "nvim-treesitter",
        event = { "BufReadPost", "BufNewFile" },
        after = function()
            require("nvim-treesitter.config").setup({
                sync_install = true,
                ensure_installed = { "lua", "python", "markdown", "nix" },
                highlight = { enable = true },
            })
        end,
    },

    {
        "nvim-web-devicons",
        after = function()
            require("nvim-web-devicons").setup {}
        end,
    },

    {
        "blink.cmp",
        event = "InsertEnter",
        after = function()
            local blink = require("blink.cmp")
            blink.setup({
                keymap = {
                    preset = "none",
                    ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
                    ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
                    ["<CR>"] = { "accept", "fallback" },
                },
                appearance = { nerd_font_variant = "normal" },
                sources = { default = { "lsp", "path", "snippets", "buffer" } },
                snippets = { preset = "luasnip" },
                signature = { enabled = true, window = { show_documentation = true } },
                fuzzy = {
                    implementation = "prefer_rust_with_warning",
                },
                completion = {
                    menu = {
                        draw = {
                            columns = { { "kind_icon" }, { "label", gap = 1 } },
                            components = {
                                kind_icon = {
                                    text = function(ctx)
                                        local icon = ctx.kind_icon
                                        if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                            local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                                            if dev_icon then
                                                icon = dev_icon
                                            end
                                        else
                                            icon = require("lspkind").symbol_map[ctx.kind] or ""
                                        end

                                        return icon .. ctx.icon_gap
                                    end,
                                    highlight = function(ctx)
                                        local hl = ctx.kind_hl
                                        if vim.tbl_contains({ "Path" }, ctx.source_name) then
                                            local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                                            if dev_icon then
                                                hl = dev_hl
                                            end
                                        end
                                        return hl
                                    end,
                                },
                                label = {
                                    text = function(ctx)
                                        return require("colorful-menu").blink_components_text(ctx)
                                    end,
                                    highlight = function(ctx)
                                        return require("colorful-menu").blink_components_highlight(ctx)
                                    end,
                                },
                            },
                        },
                    },
                },
            })
            vim.lsp.config("*", {
                capabilities = blink.get_lsp_capabilities(),
            })
        end,
    },

    {
        "nvim-lspconfig",
        after = function()
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local servers = {
                nil_ls = {},
                ruff = {},
                ty = {},
                lua_ls = {},
            }

            for server_name, cfg in pairs(servers) do
                vim.lsp.config(server_name, cfg)
                vim.lsp.enable(server_name)
            end

            local capabilities = vim.lsp.protocol.make_client_capabilities()
            vim.lsp.config('markdown_oxide', {
                capabilities = vim.tbl_deep_extend(
                    'force',
                    capabilities,
                    {
                        workspace = {
                            didChangeWatchedFiles = {
                                dynamicRegistration = true,
                            },
                        },
                    }
                ),
            })

            vim.lsp.enable('markdown_oxide')
        end,
    },

    {
        "oil.nvim",
        keys = {
            {
                "<leader>e",
                function()
                    require("oil").toggle_float(".")
                end,
                desc = "Open File Browser",
            },
        },
        after = function()
            require("oil").setup({
                delete_to_trash = true,
                keymaps = { ["q"] = { "actions.close", mode = "n" } },
                default_file_explorer = true,
                view_options = { show_hidden = true },
                float = { padding = 2, max_width = 60, max_height = 20, border = "rounded" },
            })
        end,
    },

    {
        "snacks.nvim",
        keys = {
            {
                "<leader><leader>",
                function()
                    Snacks.picker.files()
                end,
                desc = "Find Files",
            },
            {
                "<leader>fp",
                function()
                    Snacks.picker.projects()
                end,
                desc = "Projects",
            },
            {
                "<leader>sg",
                function()
                    Snacks.picker.grep()
                end,
                desc = "Grep",
            },
            {
                "<leader>sk",
                function()
                    Snacks.picker.keymaps()
                end,
                desc = "Keymaps",
            },
            {
                "<leader>.",
                function()
                    Snacks.scratch()
                end,
                desc = "Toggle Scratch",
            },
            {
                "<leader>S",
                function()
                    Snacks.scratch.select()
                end,
                desc = "Select Scratch",
            },
            {
                "<leader>sv",
                function()
                    Snacks.picker.files({
                        confirm = function(picker, item)
                            picker:close()
                            if item then
                                vim.cmd("vsplit " .. item.file)
                            end
                        end,
                    })
                end,
                desc = "Split vertically",
            },
            {
                "<leader>sh",
                function()
                    Snacks.picker.files({
                        confirm = function(picker, item)
                            picker:close()
                            if item then
                                vim.cmd("split " .. item.file)
                            end
                        end,
                    })
                end,
                desc = "Split horizontally",
            },
        },

        after = function()
            require("snacks").setup({
                indent = { enabled = true },
                scratch = { enabled = true },
                picker = { enabled = true },
                notifier = { enabled = true },
            })
        end,
    },

    {
        "conform.nvim",
        event = { "BufWritePre" },
        after = function()
            require("conform").setup({
                formatters_by_ft = {
                    lua = { "stylua" },
                    python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
                    nix = { "nixfmt" },
                    markdown = { "prettier" },
                },
                format_on_save = {
                    timeout_ms = 500,
                    lsp_fallback = true,
                },
            })
        end,
    },

    {
        "flash.nvim",
        keys = {
            {
                "s",
                mode = { "n", "x", "o" },
                function()
                    require("flash").jump()
                end,
                desc = "Flash",
            },
        },
        after = function()
            require("flash").setup({})
        end,
    },

    {
        "persistence.nvim",
        event = "VimEnter",
        after = function()
            require("persistence").setup({})
            if vim.fn.argc() == 0 and not vim.g.started_with_stdin then
                require("persistence").load()
            end
        end,
    },

    {
        "toggleterm.nvim",
        keys = {
            { "<C-t>", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
        },
        after = function()
            require("toggleterm").setup({
                size = 20,
                direction = "float",
                open_mapping = [[<c-t>]],
            })
        end,
    },

    {
        "tiny-inline-diagnostic.nvim",
        event = "LspAttach",
        after = function()
            require("tiny-inline-diagnostic").setup()
            vim.diagnostic.config({ virtual_text = false })
        end,
    },

    {
        "render-markdown.nvim",
        ft = "markdown",
        after = function()
            require("render-markdown").setup({})
        end,
    },

    {
        "which-key.nvim",
        after = function()
            require("which-key").setup({
                delay = 0,
            })
        end,
    },

    {
        "lualine.nvim",
        event = "DeferredUIEnter",
        after = function()
            require("lualine").setup({
                options = {
                    theme = "auto",
                    globalstatus = true,
                },
            })
        end,
    },

    {
        "gruvbox-material",
        priority = 1000,
        after = function()
            vim.g.gruvbox_material_transparent_background = 1
            vim.cmd.colorscheme("gruvbox-material")
        end,
    },
})
