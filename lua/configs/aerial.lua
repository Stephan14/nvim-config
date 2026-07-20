local M = {}

function M.config()
    -- Code outline: shows the classes/functions/symbols implemented in a file.
    -- Uses Treesitter first, falls back to LSP; this keeps outlines working for
    -- languages where no LSP is attached but a parser is installed.
    require("aerial").setup({
        -- Prefer treesitter so outlines still work without an active LSP,
        -- then fall back to LSP / markdown headings.
        backends = { "treesitter", "lsp", "markdown", "man" },
        -- Auto-open the outline when opening a file that actually has symbols.
        -- The list also refreshes automatically whenever you switch buffers.
        open_automatic = function(bufnr)
            local aerial = require("aerial")
            return aerial.num_symbols(bufnr) > 0
                -- Respect a manual close: don't keep re-opening after `q`.
                and not aerial.was_closed()
        end,
        layout = {
            -- Right-side panel that does not replace the code buffer.
            default_direction = "right",
            min_width = 30,
            max_width = { 40, 0.25 },
        },
        -- Keep the outline focused on the current window's file.
        attach_mode = "window",
        -- Highlight the symbol under the cursor and follow it as you move.
        highlight_on_hover = true,
        show_guides = true,
        filter_kind = false, -- show all symbol kinds (classes, functions, fields, ...)
        -- Jump to the symbol on <cr>, preview with a single click.
        keymaps = {
            ["<cr>"] = "actions.jump",
            ["o"] = "actions.jump",
            ["<tab>"] = "actions.scroll",
            ["p"] = "actions.scroll", -- preview without leaving the outline
            ["q"] = "actions.close",
        },
    })

    -- Optional: let telescope fuzzy-search the outline symbols.
    pcall(function()
        require("telescope").load_extension("aerial")
    end)
end

return M
