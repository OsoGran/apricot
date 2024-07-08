const std = @import("std");
const heap = std.heap;
const linux = std.os.linux;
const posix = std.posix;
const Allocator = std.mem.Allocator;

//
// GLOBAL VARS
//

// Stores signal set containing SIGWINCH
var sigset: linux.sigset_t = linux.empty_sigset;

// Store the value of most recently raised signal
var raised_sig: i32 = -1;

// Store the number of files in the current directory
var len_dir: i32 = 0;

// Store the number of files in the child directory
var len_dir_child: i32 = 0;

// Store the number of bookmarks
var len_bookmarks: i32 = 0;

// Store the number of scripts
var len_scripts: i32 = 0;

// Store the number of selected files
var num_sel_files: i32 = 0;

var shell: *u8 = undefined;

fn init(allocator: Allocator) !void {
    // Initialize args with page_allocator
    // std.heap.page_allocator is the most basic
    // deinit with deinit() at end of scope by using defer
    var argsIterator = try std.process.ArgIterator.initWithAllocator(heap.page_allocator);
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

    // Set up SIGWINCH signal masking
    linux.sigaddset(&sigset, linux.SIG.WINCH);
    std.debug.print("sigaddset\n", .{});
    // Set Locale

    // Get User ID
    const uid: linux.uid_t = linux.getuid();
    std.debug.print("UID: {s}\n", .{uid});

    // Get user home directory

    // Set the shell
    // temp
    shell = try allocator.alloc(u8, 10);
    //if (posix.getenv("SHELL") == NULL){
    //    std.debug.print("shell alloc here for /bin/bash\n", .{});
    //} else{
    //    std.debug.print("shell alloc hree for ENV shell\n", .{});
    //}

    // Set the editor

}

pub fn main() !void {
    // Set up Arena allocator
    var arena = heap.ArenaAllocator.init(heap.page_allocator);
    defer arena.deinit();
    const allocator = arena.allocator();

    try init(allocator);

    // Prints to stderr (it's a shortcut based on `std.io.getStdErr()`)
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});

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
