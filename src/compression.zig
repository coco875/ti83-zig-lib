//! Optimized (de)compression routines

/// Decompress a block of ZX7 encoded data.
pub extern fn zx7_Decompress(
    /// Uncompressed data destination.
    dst: ?*anyopaque,
    /// Compressed data source.
    src: ?*const anyopaque,
) void;

/// Decompress a block of ZX0 encoded data.
pub extern fn zx0_Decompress(
    /// Uncompressed data destination.
    dst: ?*anyopaque,
    /// Compressed data source.
    src: ?*const anyopaque,
) void;
