local M = {}

-- 在浮动窗口中展示一段文本，设置为 git filetype 以获得 diff 语法高亮，q 关闭。
local function open_float(lines, title)
    local buf = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
    vim.bo[buf].filetype = "git"
    vim.bo[buf].modifiable = false
    vim.bo[buf].bufhidden = "wipe"

    local width = math.floor(vim.o.columns * 0.8)
    local height = math.floor(vim.o.lines * 0.8)
    local win = vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = math.floor((vim.o.lines - height) / 2),
        col = math.floor((vim.o.columns - width) / 2),
        style = "minimal",
        border = "rounded",
        title = title,
        title_pos = "center",
    })
    vim.wo[win].wrap = false
    vim.wo[win].cursorline = true
    for _, key in ipairs({ "q", "<Esc>" }) do
        vim.keymap.set("n", key, "<cmd>close<cr>", { buffer = buf, silent = true, nowait = true })
    end
end

-- 展示光标所在行所属 commit 的完整改动（git show）。
local function show_commit_under_cursor()
    local file = vim.fn.expand("%:p")
    if file == "" or vim.bo.buftype ~= "" then
        vim.notify("当前 buffer 不是文件", vim.log.levels.WARN)
        return
    end
    local dir = vim.fn.fnamemodify(file, ":h")
    local line = vim.fn.line(".")

    local blame = vim.fn.systemlist(
        { "git", "-C", dir, "blame", "-L", line .. "," .. line, "--porcelain", "--", file }
    )
    if vim.v.shell_error ~= 0 or #blame == 0 then
        vim.notify("无法获取该行的 git 信息（未跟踪或非 git 仓库）", vim.log.levels.WARN)
        return
    end
    local hash = blame[1]:match("^(%x+)")
    if not hash then
        vim.notify("解析 commit hash 失败", vim.log.levels.WARN)
        return
    end
    if hash:match("^0+$") then
        vim.notify("该行尚未提交（本地改动）", vim.log.levels.INFO)
        return
    end

    local out = vim.fn.systemlist({ "git", "-C", dir, "show", "--stat", "--patch", hash })
    if vim.v.shell_error ~= 0 then
        vim.notify("git show 失败: " .. hash, vim.log.levels.ERROR)
        return
    end
    open_float(out, " commit " .. hash:sub(1, 10) .. " ")
end

function M.config()
    require('gitsigns').setup {
        signs                   = {
            add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
            change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
            delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
            changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        },
        signcolumn              = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl                   = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl                  = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff               = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir            = {
            interval = 1000,
            follow_files = true
        },
        attach_to_untracked     = true,
        current_line_blame      = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 300,
            ignore_whitespace = false,
        },
        current_line_blame_formatter = '  <author>, <author_time:%Y-%m-%d> · <summary>',
        sign_priority           = 6,
        update_debounce         = 100,
        status_formatter        = nil, -- Use default
        max_file_length         = 40000,
        preview_config          = {
            -- Options passed to nvim_open_win
            border = 'single',
            style = 'minimal',
            relative = 'cursor',
            row = 0,
            col = 1
        },
        yadm                    = {
            enable = false
        },
    }

    vim.keymap.set("n", "<leader>hv", show_commit_under_cursor,
        { desc = "查看光标所在行所属 commit 的完整改动" })
end

return M
