local white = "#ffffff"
local black = "#1f2328"
local grey_l5 = "#f6f8fa"
local grey_l4 = "#f1f1f2"
local grey_l3 = "#e7eaf0"
local grey_l2 = "#d0d7de"
local grey_l1 = "#9ba3ad"
local grey = "#6e7781"
local grey_d1 = "#57606a"
local grey_d2 = "#4d2d00"
local grey_d3 = "#32383f"
local ash_l1 = "#f9f9f9"
local ash = "#f5f5f5"
local red_l1 = "#fb8181"
local red = "#ff0000"
local red_d1 = "#d1242f"
local red_d2 = "#cf222e"
local grey_red = "#e4b7be"
local green_l2 = "#79f379"
local green_l1 = "#309b4f"
local green = "#116329"
local grey_green = "#b8d0bf"
local yellow = "#ffff00"
local orange = "#fb8f44"
local blue_l4 = "#c2e2ff"
local blue_l3 = "#bddfff"
local blue_l2 = "#218bff"
local blue_l1 = "#5094e4"
local blue = "#0969da"
local blue_d1 = "#0550ae"
local blue_d5 = "#0a3069"
local grey_blue = "#dae9f9"
local purple = "#6639ba"
local magenta = "#8250df"
local cyan = "#0598bc"
local cyan_d1 = "#31badc"
local cyan_d2 = "#1b7c83"
local brown_l1 = "#e1d1b3"
local brown = "#9a6700"
local brown_d1 = "#953800"
local brown_d2 = "#633c01"

local unknown = { bg = "#ef62eb", fg = green, bold = true, underline = true, italic = true }
local comment = { fg = grey, italic = true }

local function set_hls(groups)
    for n, v in pairs(groups) do
        vim.api.nvim_set_hl(0, n, v)
    end
end

-- https://neovim.io/doc/user/syntax.html#group-name
set_hls({
    Comment = comment,                     -- any comment
    Constant = { fg = blue_d1 },           -- any constant
    String = { fg = blue_d5 },             -- a string constant: "this is a string"
    Character = { link = "String" },       -- a character constant: 'c', '\n'
    Number = { fg = blue_d1 },             -- a number constant: 234, 0xff
    Boolean = { link = "Number" },         -- a boolean constant: TRUE, false
    Float = { link = "Number" },           -- a floating point constant: 2.3e10
    Identifier = { fg = black },           -- any variable name
    Function = { fg = purple },            -- function name (also: methods for classes)
    Statement = { fg = red_d2 },           -- any statement
    Conditional = { fg = red_d2 },         -- if, then, else, endif, switch, etc.
    Repeat = { link = "Conditional" },     -- for, do, while, etc.
    Label = { link = "Conditional" },      -- case, default, etc.
    Operator = { fg = blue_d1 },           -- "sizeof", "+", "*", etc.
    Keyword = { fg = red_d2 },             -- any other keyword
    Exception = { link = "keyword" },      -- try, catch, throw
    PreProc = { fg = red_d2 },             -- generic Preprocessor
    Include = { link = "PreProc" },        -- preprocessor #include
    Define = { link = "PreProc" },         -- preprocessor #define
    Macro = { link = "PreProc" },          -- same as Define
    PreCondit = { link = "PreProc" },      -- preprocessor #if, #else, #endif, etc.
    Type = { fg = black },                 -- int, long, char, etc.
    StorageClass = { link = "Type" },      -- static, register, volatile, etc.
    Structure = { link = "Type" },         -- struct, union, enum, etc.
    Typedef = { fg = black },              -- a typedef
    Special = { fg = blue_d1 },            -- any special symbol
    SpecialChar = { link = "Special" },    -- special character in a constant
    Tag = { link = "Special" },            -- you can use CTRL-] on this
    Delimiter = { link = "Special" },      -- character that needs attention
    SpecialComment = { link = "Special" }, -- special things inside a comment
    Debug = { link = "Special" },          -- debugging statements
    Underlined = { underline = true },     -- text that stands out, HTML links
    -- Ignore         = unknown,                      -- left blank, hidden  hl-Ignore
    Error = { fg = red_d1 },               -- any erroneous construct
    Todo = { fg = white, bg = blue },      -- anything that needs extra attention; mostly the keywords TODO FIXME and XXX
    Added = { link = "DiffAdd" },          -- added line in a diff
    Changed = { link = "DiffChange" },     -- changed line in a diff
    Removed = { link = "DiffDelete" },     -- removed line in a diff

    -- custom
    Field = { fg = blue_d1 }
})

-- https://neovim.io/doc/user/syntax.html#highlight-groups
set_hls({
    -- ColorColumn    = { bg = grey_l4 },                 -- Used for the columns set with 'colorcolumn'.
    Conceal = { fg = grey },                       -- Placeholder characters substituted for concealed text (see 'conceallevel').
    CurSearch = { link = "IncSearch" },            -- Used for highlighting a search pattern under the cursor (see 'hlsearch').
    Cursor = { fg = white, bg = black },           -- Character under the cursor.
    lCursor = { link = "Cursor" },                 -- Character under the cursor when language-mapping is used (see 'guicursor').
    CursorIM = { link = "Cursor" },                -- Like Cursor, but used when in IME mode. CursorIM
    CursorColumn = { link = "CursorLine" },        -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine = { bg = ash_l1 },                  -- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.
    Directory = { fg = blue_d1, bold = true },     -- Directory names (and other special names in listings).
    DiffAdd = { fg = green, bg = grey_green },     -- Diff mode: Added line. diff.txt
    DiffChange = { fg = blue_l1, bg = grey_blue }, -- Diff mode: Changed line. diff.txt
    DiffDelete = { fg = red_d1, bg = grey_red },   -- Diff mode: Deleted line. diff.txt
    DiffText = { fg = black, bg = grey_l4 },       -- Diff mode: Changed text within a changed line. diff.txt
    -- EndOfBuffer   = { fg = white },                   -- Filler lines (~) after the end of the buffer. By default, this is highlighted like hl-NonText.
    TermCursor = { link = "Cursor" },              -- Cursor in a focused terminal.
    TermCursorNC = { link = "Cursor" },            -- Cursor in an unfocused terminal.
    ErrorMsg = { fg = red_d1 },                    -- Error messages on the command line.
    WinSeparator = { fg = grey_l2 },               -- Separators between window splits.
    Folded = { fg = grey_d1, bg = grey_l4 },       -- Line used for closed folds.
    FoldColumn = { fg = grey_d1 },                 -- 'foldcolumn'
    SignColumn = { fg = grey_d1 },                 -- Column where signs are displayed.
    IncSearch = { fg = grey_d1, bg = orange },     -- 'incsearch' highlighting; also used for the text replaced with ":s///c".
    Substitute = { link = "Search" },              -- :substitute replacement text highlighting.
    LineNr = { fg = grey },                        -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    -- LineNrAbove    = unknown,                                   -- Line number for when the 'relativenumber' option is set, above the cursor line.
    -- LineNrBelow    = unknown,                                   -- Line number for when the 'relativenumber' option is set, below the cursor line.
    CursorLineNr = { fg = black }, -- Like LineNr when 'cursorline' is set and 'cursorlineopt' contains "number" or is "both", for the cursor line.
    -- CursorLineFold = unknown,                                   -- Like FoldColumn when 'cursorline' is set for the cursor line.
    -- CursorLineSign = unknown,                                   -- Like SignColumn when 'cursorline' is set for the cursor line.
    MatchParen = { fg = black, bg = blue_l3, bold = true }, -- Character under the cursor or just before it, if it is a paired bracket, and its match. pi_paren.txt
    -- ModeMsg       = { fg = brown, bold = true },               -- 'showmode' message (e.g., "-- INSERT -- ").
    -- MsgArea       = { fg = brown },                            -- Area for messages and cmdline.
    -- MsgSeparator   = unknown,                                   -- Separator for scrolled messages msgsep.
    -- MoreMsg       = { fg = blue, bold = true },                -- more-prompt
    NonText = { fg = grey }, --[[  '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text
                                          (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also hl-EndOfBuffer.]]
    Normal = { bg = white, fg = black }, -- Normal text.
    -- NormalFloat   = { bg = grey_l5 },           -- Normal text in floating windows.
    FloatBorder = { fg = grey_l2 },      -- Border of floating windows.
    FloatTitle = { link = "Title" },     -- Title of floating windows.
    -- FloatFooter   = unknown,                    -- Footer of floating windows.
    -- NormalNC      = { link = "Normal" },        -- Normal text in non-current windows.
    Pmenu = { bg = grey_l4 },    -- Popup menu: Normal item.
    PmenuSel = { bg = blue_l4 }, -- Popup menu: Selected item.
    -- PmenuKind     = unknown,              -- Popup menu: Normal item "kind".
    -- PmenuKindSel  = unknown,              -- Popup menu: Selected item "kind".
    -- PmenuExtra    = unknown,              -- Popup menu: Normal item "extra text".
    -- PmenuExtraSel = unknown,              -- Popup menu: Selected item "extra text".
    PmenuSbar = { link = "Pmenu" },  -- Popup menu: Scrollbar.
    PmenuThumb = { bg = grey_blue }, -- Popup menu: Thumb of the scrollbar.
    -- Question      = { link = "MoreMsg" }, -- hit-enter prompt and yes/no questions.
    QuickFixLine = { link = "Visual" }, --[[ Current quickfix item in the quickfix window. Combined with
                                                   hl-CursorLine when the cursor is there.]]
    Search = { bg = yellow, fg = black }, --[[ Last search pattern highlighting (see 'hlsearch').
		                                               Also used for similar items that need to stand out.]]
    -- SpecialKey    = { fg = blue_d5 }, --[[	Unprintable characters: Text displayed differently from what
    --                                   it really is. But not 'listchars' whitespace. hl-Whitespace]]
    -- SpellBad      = { sp = red_d1, undercurl = true }, --[[ Word that is not recognized by the spellchecker. spell
    --                                                    Combined with the highlighting used otherwise.]]
    -- SpellCap      = { sp = brown, undercurl = true }, --[[	Word that should start with a capital. spell
    --                                                   Combined with the highlighting used otherwise.]]
    -- SpellLocal    = { sp = blue, undercurl = true }, --[[ Word that is recognized by the spellchecker as one that is
    --                                                  used in another region. spell Combined with the highlighting used otherwise.]]
    -- SpellRare     = { sp = blue, undercurl = true }, --[[ Word that is recognized by the spellchecker as one that is
    --                                                  hardly ever used. spell Combined with the highlighting used otherwise.]]
    StatusLine = { bg = ash, fg = grey },      -- Status line of current window.
    StatusLineNC = { bg = ash, fg = grey_l2 }, -- Status lines of not-current windows.
    TabLine = { link = "StatusLine" },         -- Tab pages line, not active tab page label.
    TabLineFill = { bg = white },              -- Tab pages line, where there are no labels.
    TabLineSel = { bg = grey, fg = grey_l4 },  -- Tab pages line, active tab page label.
    Title = { fg = blue_d1, bold = true },     -- Titles for output from ":set all", ":autocmd" etc.
    Visual = { bg = grey_blue },               -- Visual mode selection.
    -- VisualNOS    = { link = "Visual" },            -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg = { fg = red_d2 },              -- Warning messages.
    -- Whitespace   = { fg = grey_l3 },               -- "nbsp", "space", "tab", "multispace", "lead" and "trail" in 'listchars'.
    WildMenu = { link = "Pmenu" },             -- Current match in 'wildmenu' completion.
    WinBar = { link = "StatusLine" },          -- Window bar of current window.
    WinBarNC = { link = "StatusLineNC" },      -- Window bar of not-current windows.
})

-- https://neovim.io/doc/user/diagnostic.html#diagnostic-highlights
set_hls({
    DiagnosticError = { fg = red },
    DiagnosticWarn = { fg = orange },
    DiagnosticInfo = { fg = cyan },
    DiagnosticHint = { fg = blue_l3 },
    DiagnosticOk = { fg = green_l1 },
})

-- https://github.com/nvim-treesitter/nvim-treesitter/blob/master/CONTRIBUTING.md#highlights
set_hls({
    -- Non-highlighting captures
    --
    ["@none"] = {},                      -- completely disable the highlight
    ["@conceal"] = { link = "Conceal" }, -- captures that are only meant to be concealed
    -- ["@spell"]                          = unknown,                       -- for defining regions to be spellchecked
    -- ["@nospell"]                        = unknown,                       -- for defining regions that should NOT be spellchecked

    -- Identifiers
    --
    ["@variable"] = { link = "Identifier" }, -- various variable names
    -- ["@variable.builtin"]               = { fg = blue_d1 },              -- built-in variable names (e.g. `this`)
    -- ["@variable.parameter"]             = { link = "Identifier" },       -- parameters of a function
    -- ["@variable.parameter.builtin"]     = { link = "Identifier" },       -- special parameters (e.g. `_`, `it`)
    ["@variable.member"] = { link = "Field" },    -- object and struct fields
    ["@constant"] = { link = "Constant" },        -- constant identifiers
    ["@constant.builtin"] = { link = "Special" }, -- built-in constant values
    ["@constant.macro"] = { link = "Define" },    -- constants defined by the preprocessor
    ["@module"] = { fg = black },                 -- modules or namespaces
    -- ["@module.builtin"]                 = unknown,                       -- built-in modules or namespaces
    ["@label"] = { link = "@tag" },               -- GOTO and other labels (e.g. `label:` in C), including heredoc labels

    -- Literals
    --
    ["@string"] = { link = "String" },                 -- string literals
    ["@string.special.url"] = { link = "Underlined" }, -- URIs (e.g. hyperlinks)
    ["@string.special.url.comment"] = vim.tbl_deep_extend("force", comment, { underline = true }),
    -- ["@string.documentation"]           = unknown,                       -- string documenting code (e.g. Python docstrings)
    -- ["@string.regexp"]                  = { fg = blue_d5 },              -- regular expressions
    -- ["@string.escape"]                  = { fg = blue_d5, bold = true }, -- escape sequences
    -- ["@string.special"]                 = unknown,                                    -- other special strings (e.g. dates)
    -- ["@string.special.symbol"]          = unknown,                                    -- symbols or atoms
    -- ["@string.special.path"]            = unknown,                                    -- filenames
    ["@character"] = { link = "Character" }, -- character literals
    -- ["@character.special"]              = { link = "SpecialChar" },                   -- special characters (e.g. wildcards)
    ["@boolean"] = { link = "Boolean" },     -- boolean literals
    ["@number"] = { link = "Number" },       -- numeric literals
    ["@number.float"] = { link = "Float" },  -- floating-point number literals

    -- Types
    --
    ["@type"] = { link = "Type" },               -- type or class definitions and annotations
    -- ["@type.builtin"]                   = { fg = red_d2 },                            -- built-in types
    ["@type.definition"] = { link = "Typedef" }, -- identifiers in type definitions (e.g. `typedef <type> <identifier>` in C)
    ["@attribute"] = { link = "PreProc" },       -- attribute annotations (e.g. Python decorators, Rust lifetimes)
    -- ["@attribute.builtin"]              = unknown,                                    -- builtin annotations (e.g. `@property` in Python)
    ["@property"] = { link = "Field" },          -- the key in key/value pairs
    -- Functions
    ["@function"] = { link = "Function" },       -- function definitions
    -- ["@function.builtin"]               = { link = "Special" },                       -- built-in functions
    -- ["@function.call"]                  = { link = "@function" },                     -- function calls
    -- ["@function.macro"]                 = { link = "Macro" },                         -- preprocessor macros
    -- ["@function.method"]                = { link = "Function" },                      -- method definitions
    -- ["@function.method.call"]           = { link = "@function.method" },              -- method calls
    -- ["@constructor"]                    = { fg = brown_d1 },                          -- constructor calls and definitions
    ["@operator"] = { link = "Operator" }, -- symbolic operators (e.g. `+` / `*`)
    -- Keywords
    ["@keyword"] = { link = "Keyword" },   -- keywords not fitting into specific categories
    -- ["@keyword.coroutine"]              = { link = "@keyword" },                      -- keywords related to coroutines (e.g. `go` in Go, `async/await` in Python)
    -- ["@keyword.function"]               = { fg = red_d2 },                            -- keywords that define a function (e.g. `func` in Go, `def` in Python)
    -- ["@keyword.operator"]               = { link = "@operator" },                     -- operators that are English words (e.g. `and` / `or`)
    -- ["@keyword.import"]                 = { link = "Include" },                       -- keywords for including modules (e.g. `import` / `from` in Python)
    -- ["@keyword.type"]                   = unknown,                                    -- keywords describing composite types (e.g. `struct`, `enum`)
    -- ["@keyword.modifier"]               = unknown,                                    -- keywords modifying other constructs (e.g. `const`, `static`, `public`)
    -- ["@keyword.repeat"]                 = { link = "Repeat" },                        -- keywords related to loops (e.g. `for` / `while`)
    -- ["@keyword.return"]                 = { link = "@keyword" },                      -- keywords like `return` and `yield`
    -- ["@keyword.debug"]                  = { link = "Debug" },                         -- keywords related to debugging
    -- ["@keyword.exception"]              = { link = "Exception" },                     -- keywords related to exceptions (e.g. `throw` / `catch`)
    -- ["@keyword.conditional"]            = { link = "Conditional" },                   -- keywords related to conditionals (e.g. `if` / `else`)
    -- ["@keyword.conditional.ternary"]    = unknown,                                    -- ternary operator (e.g. `?` / `:`)
    -- ["@keyword.directive"]              = { link = "PreProc" },                       -- various preprocessor directives & shebangs
    -- ["@keyword.directive.define"]       = { link = "Define" },                        -- preprocessor definition directives

    -- Punctuation
    --
    ["@punctuation.delimiter"] = { fg = black }, -- delimiters (e.g. `;` / `.` / `,`)
    ["@punctuation.bracket"] = { fg = black },   -- brackets (e.g. `()` / `{}` / `[]`)
    ["@punctuation.special"] = { fg = black },   -- special symbols (e.g. `{}` in string interpolation)

    -- Comments
    --
    ["@comment"] = { link = "Comment" },                             -- line and block comments
    -- ["@comment.documentation"]          = { link = "Comment" },                       -- comments documenting code
    ["@comment.error"] = { fg = white, bg = red_l1, bold = true },   -- error-type comments (e.g. `ERROR`, `FIXME`, `DEPRECATED`)
    ["@comment.warning"] = { fg = white, bg = orange, bold = true }, -- warning-type comments (e.g. `WARNING`, `FIX`, `HACK`)
    ["@comment.todo"] = { link = "Todo" },                           -- todo-type comments (e.g. `TODO`, `WIP`)
    ["@comment.note"] = { fg = white, bg = green_l2, bold = true },  -- note-type comments (e.g. `NOTE`, `INFO`, `XXX`)
    -- Markup
    ["@markup.strong"] = { bold = true },                            -- bold text
    ["@markup.italic"] = { italic = true },                          -- italic text
    ["@markup.strikethrough"] = { strikethrough = true },            -- struck-through text
    ["@markup.underline"] = { underline = true },                    -- underlined text (only for literal underline markup!)
    ["@markup.heading"] = { link = "Title" },                        -- headings, titles (including markers)
    -- ["@markup.heading.1"]               = unknown,                                    -- top-level heading
    -- ["@markup.heading.2"]               = unknown,                                    -- section heading
    -- ["@markup.heading.3"]               = unknown,                                    -- subsection heading
    -- ["@markup.heading.4"]               = unknown,                                    -- and so on
    -- ["@markup.heading.5"]               = unknown,                                    -- and so forth
    -- ["@markup.heading.6"]               = unknown,                                    -- six levels ought to be enough for anybody
    -- ["@markup.quote"]                   = unknown,                  -- block quotes
    -- ["@markup.math"]                    = { link = "Special" },     -- math environments (e.g. `$ ... $` in LaTeX)
    -- ["@markup.link"]                    = { link = "Constant" },    -- text references, footnotes, citations, etc.
    -- ["@markup.link.label"]              = { link = "SpecialChar" }, -- link, reference descriptions
    ["@markup.link.url"] = { link = "Underlined" }, -- URL-style links
    -- ["@markup.raw"]                     = { link = "String" },      -- literal or verbatim text (e.g. inline code)
    -- ["@markup.raw.block"]               = unknown,                  -- literal or verbatim text as a stand-alone block
    -- ["@markup.list"]                    = unknown,                  -- list markers
    -- ["@markup.list.checked"]            = unknown,                  -- checked todo-style list markers
    -- ["@markup.list.unchecked"]          = unknown,                  -- unchecked todo-style list markers
    ["@markup.list.unchecked.markdown"] = { bg = blue_l3 },
    ["@diff.plus"] = { link = "DiffAdd" },     -- added text (for diff files)
    ["@diff.minus"] = { link = "DiffDelete" }, -- deleted text (for diff files)
    ["@diff.delta"] = { link = "DiffChange" }, -- changed text (for diff files)
    ["@tag"] = { link = "Label" },             -- XML-style tag names (and similar)
    -- ["@tag.builtin"]                    = unknown,                 -- builtin tag names (e.g. HTML5 tags)
    -- ["@tag.attribute"]                  = { link = "@property" },  -- XML-style tag attributes
    -- ["@tag.delimiter"]                  = { link = "Delimiter" },  -- XML-style tag delimiters
})

-- hide all lsp semantic highlights
for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
end

-- hop
set_hls({
    HopNextKey = { link = "Search" },
    HopNextKey1 = { link = "Search" },
    HopNextKey2 = { link = "Search" },
    HopUnmatched = { fg = grey },
    -- HopCursor { },
})

-- gitsigns
set_hls({
    GitSignsAdd = { fg = green_l1 },
    GitSignsAddInline = { fg = green_l1 },
    GitSignsChange = { fg = brown },
    GitSignsChangeInline = { fg = brown },
    GitSignsDelete = { fg = red_d1 },
    GitSignsDeleteInline = { fg = red_d1 },
})

-- indent-blankline
set_hls({
    IblIndent = { fg = ash, bold = false }
})
