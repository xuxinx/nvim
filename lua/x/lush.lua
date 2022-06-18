local lush = require('lush')
local hsl = lush.hsl

local white = hsl'#ffffff'
local black = hsl'#24292f'
local ash = hsl'#f5f5f5'
local grey = hsl'#6e7781'
local red = hsl'#cf222e'
local green = hsl'#116329'
local yellow = hsl'#ffff00'
local orange = hsl'#c9510c'
local blue = hsl'#0550ae'
local magenta = hsl'#8250df'
local cyan = hsl'#0598bc'

local syntax = {
    comment = grey,
    constant = blue,
    string = blue.darken(50),
    variable = black,
    keyword = red,
    func = magenta,
    param = black,
    json_label = blue,
    field = blue,
    type = black,
    operator = blue,
}

local theme = lush(function()
    return {
        Normal { bg = white, fg = black }, -- normal text
        NormalFloat  { bg = green.lighten(80) }, -- Normal text in floating windows.
        -- NormalNC     { }, -- normal text in non-current windows
        -- ColorColumn  { }, -- used for the columns set with 'colorcolumn'
        -- Conceal      { }, -- placeholder characters substituted for concealed text (see 'conceallevel')
        -- Cursor       { }, -- character under the cursor
        -- lCursor      { }, -- the character under the cursor when |language-mapping| is used (see 'guicursor')
        -- CursorIM     { }, -- like Cursor, but used when in IME mode |CursorIM|
        -- CursorColumn { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
        CursorLine { bg = ash }, -- Screen-line at the cursor, when 'cursorline' is set.  Low-priority if foreground (ctermfg OR guifg) is not set.
        -- Directory    { }, -- directory names (and other special names in listings)
        -- DiffAdd      { }, -- diff mode: Added line |diff.txt|
        -- DiffChange   { }, -- diff mode: Changed line |diff.txt|
        -- DiffDelete   { }, -- diff mode: Deleted line |diff.txt|
        -- DiffText     { }, -- diff mode: Changed text within a changed line |diff.txt|
        -- EndOfBuffer  { }, -- filler lines (~) after the end of the buffer.  By default, this is highlighted like |hl-NonText|.
        -- TermCursor   { }, -- cursor in a focused terminal
        -- TermCursorNC { }, -- cursor in an unfocused terminal
        -- ErrorMsg     { }, -- error messages on the command line
        VertSplit    { fg = black }, -- the column separating vertically split windows
        -- Folded       { }, -- line used for closed folds
        -- FoldColumn   { }, -- 'foldcolumn'
        SignColumn { bg = Normal.bg }, -- column where |signs| are displayed
        -- IncSearch    { }, -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
        Search       { bg = yellow, fg = Normal.fg }, -- Last search pattern highlighting (see 'hlsearch').  Also used for similar items that need to stand out.
        Substitute   { Search }, -- |:substitute| replacement text highlighting
        LineNr       { fg = grey }, -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
        CursorLineNr { fg = black }, -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
        MatchParen   { bg = cyan.lighten(80) }, -- The character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
        -- ModeMsg      { }, -- 'showmode' message (e.g., "-- INSERT -- ")
        -- MsgArea      { }, -- Area for messages and cmdline
        -- MsgSeparator { }, -- Separator for scrolled messages, `msgsep` flag of 'display'
        -- MoreMsg      { }, -- |more-prompt|
        -- NonText      { }, -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
        Pmenu        { NormalFloat }, -- Popup menu: normal item.
        PmenuSel     { bg = Pmenu.bg.darken(20) }, -- Popup menu: selected item.
        PmenuSbar    { bg = Pmenu.bg.darken(20) }, -- Popup menu: scrollbar.
        PmenuThumb   { bg = Pmenu.bg.darken(60) }, -- Popup menu: Thumb of the scrollbar.
        -- Question     { }, -- |hit-enter| prompt and yes/no questions
        Visual       { bg = blue.lighten(80) }, -- Visual mode selection
        QuickFixLine { Visual }, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
        WildMenu     { Visual }, -- current match in 'wildmenu' completion
        -- SpecialKey   { }, -- Unprintable characters: text displayed differently from what it really is.  But not 'listchars' whitespace. |hl-Whitespace|
        -- SpellBad     { }, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
        -- SpellCap     { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
        -- SpellLocal   { }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
        -- SpellRare    { }, -- Word that is recognized by the spellchecker as one that is hardly ever used.  |spell| Combined with the highlighting used otherwise.
        StatusLine   { bg = ash, fg = grey }, -- status line of current window
        StatusLineNC { bg = StatusLine.bg, fg = StatusLine.fg }, -- status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
        TabLine      { StatusLine }, -- tab pages line, not active tab page label
        TabLineFill  { bg = Normal.bg }, -- tab pages line, where there are no labels
        TabLineSel   { bg = grey, fg = ash }, -- tab pages line, active tab page label
        -- Title        { }, -- titles for output from ":set all", ":autocmd" etc.
        -- VisualNOS    { }, -- Visual mode selection when vim is "Not Owning the Selection".
        -- WarningMsg   { }, -- warning messages
        -- Whitespace   { }, -- "nbsp", "space", "tab" and "trail" in 'listchars'

        -- These groups are not listed as default vim groups,
        -- but they are defacto standard group names for syntax highlighting.
        -- commented out groups should chain up to their "preferred" group by
        -- default,
        -- Uncomment and edit if you want more specific syntax highlighting.

        Comment      { fg = syntax.comment, gui = 'italic' }, -- any comment
        Constant       { fg = syntax.constant }, -- (preferred) any constant
        String         { fg = syntax.string }, --   a string constant: "this is a string"
        Character      { fg = syntax.variable }, --  a character constant: 'c', '\n'
        -- Number         { }, --   a number constant: 234, 0xff
        -- Boolean        { }, --  a boolean constant: TRUE, false
        -- Float          { }, --    a floating point constant: 2.3e10

        Identifier     { fg = syntax.variable }, -- (preferred) any variable name
        Function       { fg = syntax.func }, -- function name (also: methods for classes)

        Statement      { fg = syntax.keyword }, -- (preferred) any statement
        -- Conditional    { }, --  if, then, else, endif, switch, etc.
        -- Repeat         { }, --   for, do, while, etc.
        -- Label          { }, --    case, default, etc.
        Operator       { fg = syntax.operator }, -- "sizeof", "+", "*", etc.
        Keyword        { fg = syntax.keyword }, --  any other keyword
        -- Exception      { }, --  try, catch, throw

        PreProc        { fg = syntax.keyword }, -- (preferred) generic Preprocessor
        -- Include        { }, --  preprocessor #include
        -- Define         { }, --   preprocessor #define
        -- Macro          { }, --    same as Define
        -- PreCondit      { }, --  preprocessor #if, #else, #endif, etc.

        Type           { fg = syntax.type }, -- (preferred) int, long, char, etc.
        -- StorageClass   { }, -- static, register, volatile, etc.
        -- Structure      { }, --  struct, union, enum, etc.
        -- Typedef        { }, --  A typedef

        -- Special        { }, -- (preferred) any special symbol.
        -- SpecialChar    { }, --  special character in a constant
        -- Tag            { }, --    you can use CTRL-] on this
        -- Delimiter      { }, --  character that needs attention
        -- SpecialComment { }, -- special things inside a comment
        -- Debug          { }, --    debugging statements

        Underlined { gui = "underline" }, -- (preferred) text that stands out, HTML links
        Bold       { gui = "bold" },
        Italic     { gui = "italic" },

        -- ("Ignore", below, may be invisible...)
        -- Ignore         { }, -- (preferred) left blank, hidden  |hl-Ignore|

        -- Error          { }, -- (preferred) any erroneous construct

        -- Todo           { }, -- (preferred) anything that needs extra attention; mostly the keywords TODO FIXME and XXX

        -- These groups are for the native LSP client. Some other LSP clients may
        -- use these groups, or use their own. Consult your LSP client's
        -- documentation.

        -- LspReferenceText                     { }, -- used for highlighting "text" references
        -- LspReferenceRead                     { }, -- used for highlighting "read" references
        -- LspReferenceWrite                    { }, -- used for highlighting "write" references

        -- LspDiagnosticsDefaultError           { }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        -- LspDiagnosticsDefaultWarning         { }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        -- LspDiagnosticsDefaultInformation     { }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)
        -- LspDiagnosticsDefaultHint            { }, -- Used as the base highlight group. Other LspDiagnostic highlights link to this by default (except Underline)

        -- LspDiagnosticsVirtualTextError       { }, -- Used for "Error" diagnostic virtual text
        -- LspDiagnosticsVirtualTextWarning     { }, -- Used for "Warning" diagnostic virtual text
        -- LspDiagnosticsVirtualTextInformation { }, -- Used for "Information" diagnostic virtual text
        -- LspDiagnosticsVirtualTextHint        { }, -- Used for "Hint" diagnostic virtual text

        -- LspDiagnosticsUnderlineError         { }, -- Used to underline "Error" diagnostics
        -- LspDiagnosticsUnderlineWarning       { }, -- Used to underline "Warning" diagnostics
        -- LspDiagnosticsUnderlineInformation   { }, -- Used to underline "Information" diagnostics
        -- LspDiagnosticsUnderlineHint          { }, -- Used to underline "Hint" diagnostics

        -- LspDiagnosticsFloatingError          { }, -- Used to color "Error" diagnostic messages in diagnostics float
        -- LspDiagnosticsFloatingWarning        { }, -- Used to color "Warning" diagnostic messages in diagnostics float
        -- LspDiagnosticsFloatingInformation    { }, -- Used to color "Information" diagnostic messages in diagnostics float
        -- LspDiagnosticsFloatingHint           { }, -- Used to color "Hint" diagnostic messages in diagnostics float

        -- LspDiagnosticsSignError              { }, -- Used for "Error" signs in sign column
        -- LspDiagnosticsSignWarning            { }, -- Used for "Warning" signs in sign column
        -- LspDiagnosticsSignInformation        { }, -- Used for "Information" signs in sign column
        -- LspDiagnosticsSignHint               { }, -- Used for "Hint" signs in sign column

        -- LspCodeLens                          { }, -- Used to color the virtual text of the codelens

        TSAttribute { bg = red }, -- Annotations that can be attached to the code to denote some kind of meta information. e.g. C++/Dart attributes.
        TSBoolean { fg = syntax.constant }, -- Boolean literals: `True` and `False` in Python.
        TSCharacter { fg = syntax.variable }, -- Character literals: `'a'` in C.
        TSComment { fg = syntax.comment, gui = 'italic' }, -- Line comments and block comments.
        TSConditional { fg = syntax.keyword }, -- Keywords related to conditionals: `if`, `when`, `cond`, etc.
        TSConstant { fg = syntax.constant }, -- Constants identifiers. These might not be semantically constant. E.g. uppercase variables in Python.
        TSConstBuiltin { fg = syntax.constant }, -- Built-in constant values: `nil` in Lua.
        TSConstMacro { fg = syntax.constant }, -- Constants defined by macros: `NULL` in C.
        TSConstructor { fg = syntax.variable }, -- Constructor calls and definitions: `{}` in Lua, and Java constructors.
        -- TSError { }, -- Syntax/parser errors. This might highlight large sections of code while the user is typing still incomplete code, use a sensible highlight.
        TSException { fg = syntax.keyword }, -- Exception related keywords: `try`, `except`, `finally` in Python.
        TSField { fg = syntax.field }, -- Object and struct fields.
        TSFloat { fg = syntax.constant }, -- Floating-point number literals.
        TSFunction { fg = syntax.func }, -- Function calls and definitions.
        TSFuncBuiltin { fg = syntax.func }, -- Built-in functions: `print` in Lua.
        TSFuncMacro { fg = syntax.func }, -- Macro defined functions (calls and definitions): each `macro_rules` in Rust.
        TSInclude { fg = syntax.keyword }, -- File or module inclusion keywords: `#include` in C, `use` or `extern crate` in Rust.
        TSKeyword { fg = syntax.keyword }, -- Keywords that don't fit into other categories.
        TSKeywordFunction { fg = syntax.keyword }, -- Keywords used to define a function: `function` in Lua, `def` and `lambda` in Python.
        TSKeywordOperator { fg = syntax.operator }, -- Unary and binary operators that are English words: `and`, `or` in Python; `sizeof` in C.
        TSKeywordReturn { fg = syntax.keyword }, -- Keywords like `return` and `yield`.
        TSLabel { fg = syntax.json_label }, -- GOTO labels: `label:` in C, and `::label::` in Lua.
        TSMethod { fg = syntax.func }, -- Method calls and definitions.
        TSNamespace { fg = Normal.fg }, -- Identifiers referring to modules and namespaces.
        -- TSNone {}, -- No highlighting (sets all highlight arguments to `NONE`). this group is used to clear certain ranges, for example, string interpolations. Don't change the values of this highlight group.
        TSNumber { fg = syntax.constant }, -- Numeric literals that don't fit into other categories.
        TSOperator { fg = syntax.operator }, -- Binary or unary operators: `+`, and also `->` and `*` in C.
        TSParameter { fg = syntax.param }, -- Parameters of a function.
        TSParameterReference { bg = red }, -- References to parameters of a function.
        TSProperty { fg = syntax.field }, -- Same as `TSField`.
        TSPunctDelimiter { fg = Normal.fg }, -- Punctuation delimiters: Periods, commas, semicolons, etc.
        TSPunctBracket { fg = Normal.fg }, -- Brackets, braces, parentheses, etc.
        TSPunctSpecial { fg = Normal.fg }, -- Special punctuation that doesn't fit into the previous categories.
        TSRepeat { fg = syntax.keyword }, -- Keywords related to loops: `for`, `while`, etc.
        TSString { fg = syntax.string },
        TSStringRegex { fg = syntax.variable }, -- Regular expression literals.
        TSStringEscape { fg = syntax.keyword }, -- Escape characters within a string: `\n`, `\t`, etc.
        TSStringSpecial { fg = syntax.string }, -- Strings with special meaning that don't fit into the previous categories.
        TSSymbol { bg = red }, -- Identifiers referring to symbols or atoms.
        TSTag { fg = green }, -- Tags like HTML tag names.
        TSTagAttribute { fg = blue }, -- HTML tag attributes.
        TSTagDelimiter { fg = Normal.fg }, -- Tag delimiters like `<` `>` `/`.
        TSText { fg = Normal.fg }, -- Non-structured text. Like text in a markup language.
        -- TSStrong {}, -- Text to be represented in bold.
        -- TSEmphasis {}, -- Text to be represented with emphasis.
        -- TSUnderline {}, -- Text to be represented with an underline.
        -- TSStrike {}, -- Strikethrough text.
        TSTitle { fg = Normal.fg }, -- Text that is part of a title.
        -- TSLiteral {}, -- Literal or verbatim text.
        -- TSURI {}, -- URIs like hyperlinks or email addresses.
        -- TSMath {}, -- Math environments like LaTeX's `$ ... $`
        TSTextReference { fg = syntax.keyword }, -- Footnotes, text references, citations, etc.
        -- TSEnvironment {}, -- Text environments of markup languages.
        -- TSEnvironmentName {}, -- Text/string indicating the type of text environment. Like the name of a `\begin` block in LaTeX.
        TSNote { bg = blue, fg = white },
        TSWarning { bg = orange, fg = white },
        TSDanger { bg = red, fg = white },
        TSType { fg = syntax.type }, -- Type (and class) definitions and annotations.
        TSTypeBuiltin { fg = syntax.type }, -- Built-in types: `i32` in Rust.
        TSVariable { fg = syntax.variable }, -- Variable names that don't fit into other categories.
        TSVariableBuiltin { fg = syntax.variable }, -- Variable names defined by the language: `this` or `self` in Javascript.

        -- GitSigns
        GitSignsAdd    { fg = green.darken(40) },
        GitSignsChange { fg = blue },
        GitSignsDelete { fg = orange },

        -- Hop
        HopNextKey { Search },
        HopNextKey1 { HopNextKey },
        HopNextKey2 { HopNextKey },
        HopUnmatched { fg = grey },
        -- HopCursor { },
    }
end)

lush(theme)
