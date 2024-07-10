const std = @import("std")
const linux = std.os.linux;
const heap = std.heap;

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
