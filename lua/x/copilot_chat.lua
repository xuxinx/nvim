local M = {}

local go_test_instructions = [[
Additional instructions for Golang tests:
1. Follow the pattern:
func Test<func>(t *testing.T) {
    for _, c := range []struct {
        name string
        <arg>
        <arg2>
        ...
        <expectedXXX1>
        <expectedXXX2>
        ...
    }{
        {},
    }{
        t.Run(c.name, func(t *testing.T) {
            <call func>
            if diff := cmp.Diff(c.<expectedXXX1>, res1); diff != "" {
                t.Fatalf("got diff %s\n", diff)
            }
            if diff := cmp.Diff(c.<expectedXXX2>, res2); diff != "" {
                t.Fatalf("got diff %s\n", diff)
            }
            ...
        })
    }
}
2. Replace <func> with the name of the function you are testing.
3. Replace <arg>, <expectedXXX>, <call func> with actual values.
4. New line for each field of a case.
]]

M.setup = function()
    local chat = require("CopilotChat")

    chat.setup({
        model = "claude-3.7-sonnet",
        show_help = false,
        show_folds = false,
        question_header = ' User ',
        answer_header = ' Copilot ',
        error_header = ' Error ',
        separator = '───',
        mappings = {
            complete = {
                insert = "", -- FIXME: can not work with cmp https://github.com/CopilotC-Nvim/CopilotChat.nvim/issues/291#issuecomment-2181077358
            },
            accept_diff = {
                normal = ",a",
                insert = "",
            },
        },
        prompts = {
            Tests = {
                prompt = [[> /COPILOT_GENERATE

Please generate tests for my code.
                ]] .. go_test_instructions,
            }
        },
        contexts = {
            files = {
                description =
                'Includes all non-hidden files in the current workspace in chat context. Supports input (default list).',
                resolve = function(input, source)
                    local context = require('CopilotChat.context')
                    if vim.fn.isdirectory(input) == 1 then
                        local temp_buf = vim.api.nvim_create_buf(false, true)
                        local temp_win = vim.api.nvim_open_win(temp_buf, false, {
                            relative = 'editor',
                            width = 1,
                            height = 1,
                            row = 0,
                            col = 0,
                            style = 'minimal',
                            focusable = false,
                            noautocmd = true,
                        })
                        vim.api.nvim_win_set_buf(temp_win, temp_buf)
                        vim.bo[temp_buf].buftype = 'nofile'
                        vim.bo[temp_buf].bufhidden = 'wipe'
                        vim.bo[temp_buf].swapfile = false

                        vim.fn.win_execute(temp_win, 'lcd ' .. input)
                        local result = context.files(temp_win, true)
                        vim.defer_fn(function()
                            vim.api.nvim_win_close(temp_win, true)
                        end, 0)
                        return result
                    else
                        return context.files(source.winnr, input == 'full')
                    end
                end,
            },
        },
    })
end

return M
