//! These debug functions are provided to help in the process of debugging
//! an application. To enable them, use `make debug` when compiling a program.

const std = @import("std");

const c_va_list = std.builtin.VaList;
extern fn vsprintf(noalias buffer: [*c]u8, noalias format: [*c]const u8, ap: c_va_list) c_int;

/// Standard debug output
pub const dbgout: [*c]const u8 = @ptrFromInt(0xFB0000);
/// Standard error debug output
pub const dbgerr: [*c]const u8 = @ptrFromInt(0xFC0000);

/// Break on read
pub const DBG_WATCHPOINT_READ = 1 << 0;
pub const DBG_WATCHPOINT_WRITE = 1 << 1;
pub const DBG_WATCHPOINT_EXECUTE = 1 << 2;
pub const DBG_WATCHPOINT_ALL = DBG_WATCHPOINT_READ | DBG_WATCHPOINT_WRITE | DBG_WATCHPOINT_EXECUTE;
pub const DBG_WATCHPOINT_NONE = 0;

/// Used to print to the emulator console.
pub fn dbg_printf(fmt: [*c]const u8, ...) c_int {
    const ap = @cVaStart();
    defer @cVaEnd(ap);
    return vsprintf(dbgout, fmt, ap);
}

/// Clears the emulation console.
pub fn dbg_ClearConsole() callconv(.c) void {
    @as([*c]volatile u8, @ptrFromInt(0xFD0000)).* = 1;
}

/// Opens the emulator's debugger immediately
pub extern fn dbg_Debugger() void;

/// Sets a watchpoint to open the debugger when an address
/// is read, written, or executed. Use the masks DBG_WATCHPOINT_READ,
/// DBG_WATCHPOINT_WRITE, and DBG_WATCHPOINT_EXECUTE respectively to
/// configure the watchpoint.
pub extern fn dbg_WatchpointSet(
    /// Watchpoint address.
    address: ?*anyopaque,
    /// Watchpoint size in bytes. Currently must be 1.
    size: usize,
    /// Watchpoint mask, use DBG_WATCHPOINT_NONE to remove
    /// the watchpoint.
    mask: u8,
) void;

/// Removes all watchpoints.
pub extern fn dbg_WatchpointRemoveAll() void;
