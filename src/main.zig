const std = @import("std");

const c = @cImport({
    @cInclude("signal.h");
});

//
// GLOBAL VARS
//

fn init() !void {
    // Initialize an allocator
    // std.heap.page_allocator is the most basic
    const allocator = std.heap.page_allocator;

    // Initialize arguments
    // deinit with deinit() at end of scope by using defer
    var argsIterator = try std.process.ArgIterator.initWithAllocator(allocator);
    defer argsIterator.deinit();

    // Skip executable
    _ = argsIterator.next();

    // Handle cases
    while (argsIterator.next()) |arg| {
        std.debug.print("Arg: {s}\n", .{arg});
        // Determining arg type
        // !This should probably be a switch
        if ((arg[0] == '-') and (arg[1] == '-')) {
            std.debug.print("filter on word option\n", .{});
        } else if (arg[0] == '-') {
            std.debug.print("filter on letter option\n", .{});
        } else {
            std.debug.print("text\n", .{});
        }
    }
}

pub fn main() !void {
    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

    try init();

    // stdout is for the actual output of your application, for example if you
    // are implementing gzip, then only the compressed bytes should be sent to
    // stdout, not any debugging messages.
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("Run `zig build test` to run the tests.\n", .{});

    try bw.flush(); // don't forget to flush!
}

test "simple test" {
    var list = std.ArrayList(i32).init(std.testing.allocator);
    defer list.deinit(); // try commenting this out and see if zig detects the memory leak!
    try list.append(42);
    try std.testing.expectEqual(@as(i32, 42), list.pop());
}
