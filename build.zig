const std = @import("std");

// Although this function looks imperative, note that its job is to
// declaratively construct a build graph that will be executed by an external
// runner.
pub fn build(b: *std.Build) void {
    _ = b;
    // const lib = b.addLibrary(.{
    //     .name = "ti83-lib",
    //     .root_module =
    // });
    // lib.addIncludePath(.{ .path = "src" });
}
