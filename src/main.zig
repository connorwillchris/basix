const std = @import("std");
const speaker = @import("speaker.zig");
const scanner = @import("scanner.zig");

pub fn main() !void {
    try runFile();
}

fn runFile() !void {
    const source =
        \\10 print "hello world!";
        \\20 goto 10;
        \\; # END
    ;
    var scannerObj = scanner.Scanner.new(source);
    var line: usize = 0;
    while (true) {
        const t = scanner.Token.scanToken(&scannerObj);
        if (t.line != line) {
            std.debug.print("{d:4} ", .{t.line});
            line = t.line;
        } else {
            std.debug.print(" | ", .{});
        }
        std.debug.print("{} {d} {s}", .{
            @TypeOf(t._type),
            t.length,
            t.start,
        });

        if (t._type == scanner.TokenType.Eof) break;
    }
}

fn repl() !void {
    const stdin = std.io.getStdIn().reader();
    const speak = try speaker.Speaker.new(1024);

    defer speak.free();

    var line: [1024]u8 = undefined;

    while (true) {
        @memset(line[0..], 0);
        _ = try stdin.readUntilDelimiterOrEof(
            &line,
            '\n',
        );

        if (line[0] == '\n') break; // exit if we don't have input (TEMPORARY SOLUTION)
        try speak.say(&line);
    }
}

test "speak" {
    const bufsize: usize = 1024;
    const s = try speaker.Speaker.new(bufsize);
    defer s.free();

    try s.say("Hello, world!");
}
