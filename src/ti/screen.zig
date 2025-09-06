const lie = @import("../int24.zig");
const ui = @import("ui.zig");
const std = @import("std");

pub extern fn boot_NewLine() void;

/// Resets the OS homescreen; accounts for split screen.
pub fn os_ClrHome() void {
    os_ClrLCD();
    os_HomeUp();
    ui.os_DrawStatusBar();
}

// Resets the OS homescreen fully; ignores split screen mode.
pub fn os_ClrHomeFull() void {
    os_ClrLCDFull();
    os_HomeUp();
    ui.os_DrawStatusBar();
}

/// Inserts a new line at the current cursor posistion on the homescreen.
/// Does scroll.
pub extern fn os_NewLine() void;

/// Disables the OS cursor
pub extern fn os_DisableCursor() void;

/// Enables the OS cursor
pub extern fn os_EnableCursor() void;

/// Set the cursor posistion used on the homescreen
pub extern fn os_SetCursorPos(
    /// The row aligned offset
    curRow: u8,
    /// The column aligned offset
    curCol: u8,
) void;

/// Gets the cursor posistion used on the homescreen
pub extern fn os_GetCursorPos(
    /// Pointer to store the row aligned offset
    curRow: *u32,
    /// Pointer to store the column aligned offset
    curCol: *u32,
) void;

/// Puts some text at the current homescreen cursor location
///
/// @returns 1 if string fits on screen, 0 otherwise
pub extern fn os_PutStrFull(
    /// Text to put on homescreen
    string: [*c]const u8,
) lie.int24;

/// Puts some text at the current homescreen cursor location
///
/// @returns 1 if string fits on line, 0 otherwise
pub extern fn os_PutStrLine(
    /// Text to put on homescreen
    string: [*c]const u8,
) lie.int24;

/// Routine to scroll homescreen up
pub extern fn os_MoveUp() void;

/// Routine to scroll homescreen down
pub extern fn os_MoveDown() void;

/// Routine to move row and column posistion to (0,0)
pub extern fn os_HomeUp() void;

/// Routine to clear the homescreen lcd
pub extern fn os_ClrLCDFull() void;

/// Routine to clear the homescreen lcd.
/// Accounts for split screen
pub extern fn os_ClrLCD() void;

/// Invalidate and clear text shadow area
pub extern fn os_ClrTxtShd() void;

/// Disable text buffering on the homescreen.
/// C programs use this area by default for the BSS / Heap.
pub extern fn os_DisableHomeTextBuffer() void;

/// Enables text buffering on the homescreen.
/// C programs use this area by default for the BSS / Heap.
pub extern fn os_EnableHomeTextBuffer() void;

/// Get string input using the TIOS homescreen.
pub extern fn os_GetStringInput(
    /// Input prompt string to be displayed to the user.
    prompt: [*c]const u8,
    /// Storage location to store input string.
    /// The string will always be null terminated.
    buf: [*c]u8,
    /// Available storage size for input string.
    bufsize: isize,
) void;

/// Get tokenized input using the TIOS homescreen.
///
/// @returns Length of tokenized input.
pub extern fn os_GetTokenInput(
    /// Input prompt string to be displayed to the user.
    prompt: [*c]const u8,
    /// Storage location to store input string.
    buf: [*c]u8,
    /// Available storage size for buffer.
    bufsize: isize,
) void;

/// TIOS small font.
/// see: os_FontSelect
const os_SmallFont = @as(*font_t, 0);

/// TIOS large font.
/// see: os_FontSelect
const os_LargeFont = @as(*font_t, 1);

/// Structure of font description
/// see: os_FontSelect
const font_t = struct {
    /// Points to this font itself, yuck!
    font: *font_t,

    /// Draws a character using this font.
    drawChar: fn (
        /// The character
        c: i8,
    ) void,

    /// Gets the width of a character in this font.
    getWidth: fn (
        /// The character
        c: i8,
    ) lie.uint24,

    /// Gets the height of this font.
    getHeight: fn () lie.uint24,
};

/// Selects the (monospace) font to use when drawing text
pub extern fn os_FontSelect(
    /// font id/pointer to use
    ///
    /// os_SmallFont
    /// os_LargeFont
    font: *font_t,
) void;

/// Gets the font to use when drawing text
///
/// @returns
/// 0: small font
/// 1: large monospace font
pub extern fn os_FontGetID() *font_t;

/// @returns The width of a string in the variable-width format
pub extern fn os_FontGetWidth(
    /// String to get pixel width of
    string: [*c]const u8,
) lie.uint24;

/// @returns The height of the font characters
pub extern fn os_FontGetHeight() lie.uint24;

/// Draws text using the small font to the screen
///
/// @returns The end column
pub extern fn os_FontDrawText(
    /// String to draw
    string: [*c]const u8,
    /// Column to start drawing at
    col: u16,
    /// Row to start drawing at
    row: u8,
) lie.uint24;

/// Draws transparent text using the small font to the screen
///
/// @returns The end column
pub extern fn os_FontDrawTransText(
    /// String to draw
    string: [*c]const u8,
    /// Column to start drawing at
    col: u16,
    /// Row to start drawing at
    row: u8,
) lie.uint24;

/// Sets the foreground color used to draw text
pub extern fn os_SetDrawFGColor(
    /// 565 BGR color to set text foreground to
    color: lie.uint24,
) void;

/// Gets the foreground color used to draw text
/// @returns 565 BGR color of text foreground
pub extern fn os_GetDrawFGColor() lie.uint24;

/// Sets the background color used to draw text
pub extern fn os_SetDrawBGColor(
    /// 565 BGR color to set text background to
    color: lie.uint24,
) void;

/// Gets the background color used to draw text
///
/// @returns 565 BGR color of text background
/// @warning Only useable in OS 5.2 and above; use at your own risk
pub extern fn os_GetDrawBGColor() lie.uint24;

const os_CmdShadow = @as([*c]u8, 0xD0232D);
const os_TextShadow = @as([*c]u8, 0xD006C0);
const os_PromptRow = @as(*u8, 0xD00800);
const os_PromptCol = @as(*u8, 0xD00801);
const os_PromptIns = @as(*u8, 0xD00802);
const os_PromptShift = @as(*u8, 0xD00803);
const os_PromptReturn = @as(*u8, 0xD00804);
const os_PromptValid = @as(*u8, 0xD00807);

/// Font row position
const os_CurRow = @as(*u8, 0xD00595);
/// Font column position
const os_CurCol = @as(*u8, 0xD00596);
/// Large font foreground 565 BGR color
const os_TextFGColor = @as(*u16, 0xD02688);
/// Large font background 565 BGR color
const os_TextBGColor = @as(*u16, 0xD0268A);

/// Small font column position
const os_PenCol = @as(*lie.uint24, 0xD008D2);
/// Small font row position
const os_PenRow = @as(*u8, 0xD008D5);
/// Small font foreground 565 BGR color
const os_SmallFontFGColor = @as(*u16, 0xD026AA);
/// Small font background 565 BGR color
const os_SmallFontBGColor = @as(*u16, 0xD026AC);
/// Small OS font color code
const os_DrawColorCode = @as(*u8, 0xD026AE);
/// Graph background 565 BGR color
const os_GraphBGColor = @as(*u16, 0xD02A98);
/// OS Rect draw 565 BGR color
const os_FillRectColor = @as(*u16, 0xD02AC0);
