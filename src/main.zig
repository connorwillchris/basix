const std = @import("std");
const json = std.json;

pub fn main() !u8 {
    const stdin = std.io.getStdIn().reader();
    const stdout = std.io.getStdOut().writer();

    try stdout.print(
        "I am a linux shell\n",
        .{},
    );
    try shellLoop(stdin, stdout);

    return 0;
}

fn shellLoop(
    stdin: std.fs.File.Reader,
    stdout: std.fs.File.Writer,
) !void {
    const max_input = 1024;
    const max_args = 16;
    const max_arg_size = 1024;
    var args: [max_args][max_arg_size]u8 = undefined;
    var args_ptrs: [max_args:null]?[*:0]u8 = undefined;

    while (true) {
        try stdout.print(
            "> ",
            .{},
        );

        var input_buffer: [max_input]u8 = undefined;
        var input_str = (try stdin.readUntilDelimiterOrEof(input_buffer[0..], '\n')) orelse {
            try stdout.print("\n", .{});
            return;
        };

        var tokens = std.mem.split(input_str, " ");
        var i: usize = 0;
        while (tokens.next()) |tok| {
            std.mem.copy(u8, &args[i], tok);
            args[i][tok.len] = 0;
            args_ptrs[i] = &args[i];
            i += 1;

            const fork_pid = try std.os.fork();
            if (fork_pid == 0) {
                // we are the child, execute the command.
            } else {
                // we are the parent, wait for the child to exit.
                const wait_result = std.io.waitpid(fork_pid, 0);
                if (wait_result.status != 0) {
                    try stdout.print("Command returned {}.\n", .{wait_result.status});
                }
            }
        }
        args_ptrs[i] = null;
    }
}
