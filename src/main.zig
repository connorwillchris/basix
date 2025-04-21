const std = @import("std");
const speaker = @import("speaker.zig");
const scanner = @import("scanner.zig");

pub fn main() !void {
<<<<<<< HEAD
    const t =
        \\10 print "hello world!"
        \\20 goto 10;
        \\30 end;
    ;

    const S = scanner.Scanner.new(t);
    const tokens = S.scanTokens();
    defer tokens.clearAndFree();
=======
    try runFile();
}

fn runFile() !void {
    //const source =
    //\\10 print "hello world!";
    //\\20 goto 10;
    //\\; # END
    //;

    //var s = scanner.Scanner.new(source);
    //var line: u64 = -1;
    //while (true) {
    // const tok = scanner.Scanner.scanToken();
    //}
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
>>>>>>> e9855ab6b4da7677d97da390172a6e1568f42dc7
}

test "speak" {
    const bufsize: usize = 1024;
    const s = try speaker.Speaker.new(bufsize);
    defer s.free();

    try s.say("Hello, world!");
}
