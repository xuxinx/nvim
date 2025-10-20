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
        -- model = "claude-3.7-sonnet",
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
    })
end

return M
