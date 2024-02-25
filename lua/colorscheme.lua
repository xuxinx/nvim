local white = "#ffffff"
local black = "#24292f"
local ashL10 = "#f9f9f9"
local ash = "#f5f5f5"
local ashD10 = "#eaeaea"
local greyL40 = "#9ba3ad"
local grey = "#6e7781"
local redL80 = "#fb8181"
local red = "#cf222e"
local greenL80 = "#79f379"
local greenL40 = "#309b4f"
local green = "#116329"
local yellow = "#ffff00"
local orange = "#c9510c"
local blueL80 = "#bddfff"
local blueL60 = "#3f7cc9"
local blue = "#0550ae"
local blueD60 = "#0a3069"
local magenta = "#8250df"
local cyanL60 = "#31badc"
local cyan = "#0598bc"

local syntax = {
    comment = grey,
    constant = black,
    string = blueD60,
    variable = black,
    keyword = red,
    func = magenta,
    param = black,
    json_label = green,
    field = blue,
    type = black,
    operator = blue,
    tag = green,
    attr = magenta,
}

local unknown = { bg = "#ef62eb", bold = true, underline = true, italic = true }

local groups = {
    Normal       = { bg = white, fg = black }, -- normal text
    NormalFloat  = { bg = ashD10 }, -- Normal text in floating windows.
    -- NormalNC     { }, -- normal text in non-current windows
    -- ColorColumn  { }, -- used for the columns set with 'colorcolumn'
    Conceal      = { fg = green }, -- placeholder characters substituted for concealed text (see 'conceallevel')
    -- Cursor       { }, -- character under the cursor
    -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
    -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
    -- CursorColumn { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
    CursorLine   = { bg = ashL10 }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
    -- Directory    { }, -- directory names (and other special names in listings)
    DiffAdd      = { fg = greenL40 }, -- diff mode: Added line |diff.txt|
    DiffChange   = { fg = blueL60 }, -- diff mode: Changed line |diff.txt|
    DiffDelete   = { fg = red }, -- diff mode: Deleted line |diff.txt|
    DiffText     = { fg = blue }, -- diff mode: Changed text within a changed line |diff.txt|
    -- EndOfBuffer  { }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
    -- TermCursor   { }, -- cursor in a focused terminal
    -- TermCursorNC { }, -- cursor in an unfocused terminal
    -- ErrorMsg     { }, -- error messages on the command line
    VertSplit    = { fg = black }, -- the column separating vertically split windows
    -- Folded       { }, -- line used for closed folds
    -- FoldColumn   { }, -- 'foldcolumn'
    SignColumn   = { bg = white }, -- column where |signs| are displayed
    -- IncSearch    { }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
    Search       = { bg = yellow, fg = black }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
    Substitute   = { link = "Search" }, -- |:substitute| replacement text highlighting
    LineNr       = { fg = grey }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
    CursorLineNr = { fg = black }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
    MatchParen   = { bg = cyanL60 }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
    -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
    -- MsgArea      { }, -- Area for messages and cmdline
    -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
    -- MoreMsg      { }, -- |more-prompt|
    -- NonText      { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
    Pmenu        = { link = "NormalFloat" }, -- Popup menu: normal item.
    PmenuSel     = { link = "Visual" }, -- Popup menu: selected item.
    PmenuSbar    = { bg = greyL40 }, -- Popup menu: scrollbar.
    PmenuThumb   = { bg = grey }, -- Popup menu: Thumb of the scrollbar.
    -- Question     { }, -- |hit-enter| prompt and yes/no questions
    Visual       = { bg = blueL80 }, -- Visual mode selection
    QuickFixLine = { link = "Visual" }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
    WildMenu     = { link = "Visual" }, -- current match in 'wildmenu' completion
    -- SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
    -- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
    -- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
    -- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
    -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
    StatusLine   = { bg = ash, fg = grey }, -- status line of current window
    StatusLineNC = { bg = ash, fg = greyL40 }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
    TabLine      = { link = "StatusLine" }, -- tab pages line, not active tab page label
    TabLineFill  = { bg = white }, -- tab pages line, where there are no labels
    TabLineSel   = { bg = grey, fg = ash }, -- tab pages line, active tab page label
    Title        = { bold = true }, -- titles for output from ":set all", ":autocmd" etc.
    -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
    WarningMsg   = { fg = red }, -- warning messages
    -- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'

    -- These groups are not listed as default vim groups,
    -- but they are defacto standard group names for syntax highlighting.
    -- commented out groups should chain up to their "preferred" group by
    -- default,
    -- Uncomment and edit if you want more specific syntax highlighting.

    Comment   = { fg = syntax.comment, italic = true }, -- any comment
    Constant  = { fg = syntax.constant }, -- (preferred) any constant
    String    = { fg = syntax.string }, --   a string constant: "this is a string"
    Character = { fg = syntax.variable }, --  a character constant: 'c', '\n'
    Number    = { fg = syntax.variable }, --   a number constant: 234, 0xff
    Boolean   = { fg = syntax.variable }, --  a boolean constant: TRUE, false
    Float     = { fg = syntax.variable }, --    a floating point constant: 2.3e10

    Identifier = { fg = syntax.variable }, -- (preferred) any variable name
    Function = { fg = syntax.func }, -- function name (also: methods for classes)

    Statement   = { fg = syntax.keyword }, -- (preferred) any statement
    Conditional = { fg = syntax.keyword }, --  if, then, else, endif, switch, etc.
    Repeat      = { fg = syntax.keyword }, --   for, do, while, etc.
    Label       = { fg = syntax.json_label }, --    case, default, etc.
    Operator    = { fg = syntax.operator }, -- "sizeof", "+", "*", etc.
    Keyword     = { fg = syntax.keyword }, --  any other keyword
    Exception   = { fg = syntax.keyword }, --  try, catch, throw

    PreProc = { fg = syntax.keyword }, -- (preferred) generic Preprocessor
    Include = { fg = syntax.keyword }, --  preprocessor #include
    Define  = { link = "Constant" }, --   preprocessor #define
    -- Macro          { }, --    same as Define
    -- PreCondit      { }, --  preprocessor #if, #else, #endif, etc.

    Type = { fg = syntax.type }, -- (preferred) int, long, char, etc.
    -- StorageClass   { }, -- static, register, volatile, etc.
    -- Structure      { }, --  struct, union, enum, etc.
    -- Typedef        { }, --  A typedef

    Special        = { fg = magenta }, -- (preferred) any special symbol. telescope matched characters
    SpecialChar    = { fg = red }, --  special character in a constant
    Tag            = { fg = green }, --    you can use CTRL-] on this
    Delimiter      = { fg = black }, --  character that needs attention
    SpecialComment = unknown, -- special things inside a comment
    -- Debug          { }, --    debugging statements

    Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
    Bold = { bold = true },
    Italic = { italic = true },

    -- ("Ignore", below, may be invisible...)
    Ignore = unknown, -- (preferred) left blank, hidden  |hl-Ignore|
    -- Error  = { fg = red }, -- (preferred) any erroneous construct
    Todo   = { fg = black, bg = blueL80, bold = true }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

    -- # treesitter groups
    -- # https://github.com/nvim-treesitter/nvim-treesitter/blob/00b42ac6d4c852d34619eaf2ea822266588d75e3/CONTRIBUTING.md
    -- Misc
    ["@comment"] = { link = "Comment" }, --  ; line and block comments
    -- ["@error"] = {}, --    ; syntax/parser errors
    ["@none"] = {}, --     ; completely disable the highlight
    ["@keyword.directive"] = { link = "PreProc" }, --  ; various preprocessor directives & shebangs
    ["@keyword.define"] = { link = "Define" }, --   ; preprocessor definition directives
    ["@operator"] = { link = "Operator" }, -- ; symbolic operators (e.g. `+` / `*`)
    -- Punctuation
    ["@punctuation.delimiter"] = { link = "Delimiter" }, -- ; delimiters (e.g. `;` / `.` / `,`)
    ["@punctuation.bracket"] = { link = "Delimiter" }, --   ; brackets (e.g. `()` / `{}` / `[]`)
    ["@markup.list"] = { link = "Delimiter" }, --   ; special symbols (e.g. `{}` in string interpolation)
    -- Literals
    ["@string"] = { link = "String" }, --            ; string literals
    ["@string.regexp"] = { link = "String" }, --      ; regular expressions
    ["@string.escape"] = { link = "SpecialChar" }, --     ; escape sequences
    ["@string.special"] = { link = "SpecialChar" }, --    ; other special strings (e.g. dates)
    ["@character"] = { link = "Character" }, --         ; character literals
    ["@character.special"] = { link = "SpecialChar" }, -- ; special characters (e.g. wildcards)
    ["@boolean"] = { link = "Boolean" }, --           ; boolean literals
    ["@number"] = { link = "Number" }, --            ; numeric literals
    ["@number.float"] = { link = "Float" }, --             ; floating-point number literals
    -- Functions
    ["@function"] = { link = "Function" }, --         ; function definitions
    ["@function.builtin"] = { link = "Function" }, -- ; built-in functions
    ["@function.call"] = { link = "Function" }, --    ; function calls
    ["@function.macro"] = { link = "Function" }, --   ; preprocessor macros
    ["@function.method"] = { link = "Function" }, --           ; method definitions
    ["@function.method.call"] = { link = "Function" }, --      ; method calls
    ["@constructor"] = { link = "Identifier" }, --      ; constructor calls and definitions
    ["@variable.parameter"] = { link = "Identifier" }, --        ; parameters of a function
    -- Keywords
    ["@keyword"] = { link = "Keyword" }, --          ; various keywords
    ["@keyword.function"] = { link = "Keyword" }, -- ; keywords that define a function (e.g. `func` in Go, `def` in Python)
    ["@keyword.operator"] = { link = "Keyword" }, -- ; operators that are English words (e.g. `and` / `or`)
    ["@keyword.return"] = { link = "Keyword" }, --   ; keywords like `return` and `yield`
    ["@keyword.conditional"] = { link = "Conditional" }, --      ; keywords related to conditionals (e.g. `if` / `else`)
    ["@keyword.repeat"] = { link = "Repeat" }, --           ; keywords related to loops (e.g. `for` / `while`)
    ["@keyword.debug"] = { link = "Keyword" }, --            ; keywords related to debugging
    ["@label"] = { link = "Label" }, --            ; GOTO and other labels (e.g. `label:` in C)
    ["@keyword.import"] = { link = "Include" }, --          ; keywords for including modules (e.g. `import` / `from` in Python)
    ["@keyword.exception"] = { link = "Exception" }, --        ; keywords related to exceptions (e.g. `throw` / `catch`)
    -- Types
    ["@type"] = { link = "Type" }, --                  ; type or class definitions and annotations
    ["@type.builtin"] = { link = "Type" }, --          ; built-in types
    ["@type.definition"] = { link = "Type" }, --       ; type definitions (e.g. `typedef` in C)
    ["@type.qualifier"] = { link = "Type" }, --        ; type qualifiers (e.g. `const`)
    ["@keyword.storage"] = { link = "Keyword" }, --          ; visibility/life-time modifiers
    ["@keyword.storage.lifetime"] = { link = "Keyword" }, -- ; life-time modifiers (e.g. `static`)
    ["@attribute"] = { link = "Keyword" }, --             ; attribute annotations (e.g. Python decorators)
    ["@variable.member"] = { fg = syntax.field }, --                 ; object and struct fields
    ["@property"] = { link = "@variable.member" }, --              ; similar to `@variable.member`
    -- Identifiers
    ["@variable"] = { link = "Identifier" }, --         ; various variable names
    ["@variable.builtin"] = { link = "Identifier" }, -- ; built-in variable names (e.g. `this`)
    ["@constant"] = { link = "Constant" }, --          ; constant identifiers
    ["@constant.builtin"] = { link = "Constant" }, --  ; built-in constant values
    ["@constant.macro"] = { link = "Constant" }, --    ; constants defined by the preprocessor
    ["@module"] = { link = "Identifier" }, --        ; modules or namespaces
    ["@string.special.symbol"] = { link = "Identifier" }, --           ; symbols or atoms
    -- Text
    ["@markup"] = { link = "@none" }, --                  ; non-structured text
    ["@markup.strong"] = { bold = true }, --           ; bold text
    ["@markup.italic"] = { italic = true }, --         ; text with emphasis
    ["@markup.underline"] = { underline = true }, --        ; underlined text
    ["@markup.strikethrough"] = { strikethrough = true }, --           ; strikethrough text
    ["@markup.heading"] = { link = "Title" }, --            ; text that is part of a title
    ["@markup.raw"] = { link = "String" }, --          ; literal or verbatim text
    ["@string.special.url"] = { link = "Underlined" }, --              ; URIs (e.g. hyperlinks)
    ["@markup.math"] = { link = "Special" }, --             ; math environments (e.g. `$ ... $` in LaTeX)
    ["@markup.environment"] = unknown, --      ; text environments of markup languages
    ["@markup.link"] = { link = "Constant" }, --        ; text references, footnotes, citations, etc.
    ["@comment.todo"] = { link = "Todo" }, --             ; todo notes
    ["@comment.todo.checked.markdown"] = { link = "Normal" }, --             ; todo notes
    -- ["@comment.todo.unchecked.markdown"] = { link = "@comment.todo" }, --             ; todo notes
    ["@comment.note"] = { fg = black, bg = greenL80, bold = true }, --             ; info notes
    ["@comment.warning"] = { fg = black, bg = yellow, bold = true }, --          ; warning notes
    ["@comment.danger"] = { fg = white, bg = redL80, bold = true }, --           ; danger/error notes
    ["@diff.plus"] = { link = "DiffAdd" }, --         ; added text (for diff files)
    ["@diff.minus"] = { link = "DiffDelete" }, --      ; deleted text (for diff files)
    -- Tags
    ["@tag"] = { link = "Tag" }, --           ; XML tag names
    ["@tag.attribute"] = { fg = syntax.attr }, -- ; XML tag attributes
    ["@tag.delimiter"] = { link = "Delimiter" }, -- ; XML tag delimiters
    -- Conceal
    ["@conceal"] = { link = "Conceal" }, -- ; for captures that are only used for concealing

    -- GitSigns
    GitSignsAdd = { link = "DiffAdd" },
    GitSignsChange = { link = "DiffChange" },
    GitSignsDelete = { link = "DiffDelete" },

    -- Hop
    HopNextKey = { link = "Search" },
    HopNextKey1 = { link = "Search" },
    HopNextKey2 = { link = "Search" },
    HopUnmatched = { fg = grey },
    -- HopCursor { },
}

for g, v in pairs(groups) do
    vim.api.nvim_set_hl(0, g, v)
end
