-- Claude Code integration setup
require('claudecode').setup({
    -- Set a custom name with PID to distinguish multiple instances
    name = function()
        local cwd = vim.fn.getcwd()
        local project_name = vim.fn.fnamemodify(cwd, ':t')
        local pid = vim.fn.getpid()
        return string.format("Neovim [%s] #%d", project_name, pid)
    end,
})