const std = @import("std");
const speaker = @import("speaker.zig");
const scanner = @import("scanner.zig");

pub fn main() !void {
    const t =
        \\10 print "hello world!"
        \\20 goto 10;
        \\30 end;
    ;

    const S = scanner.Scanner.new(t);
    const tokens = S.scanTokens();
    defer tokens.clearAndFree();
}

test "speak" {
    const bufsize: usize = 1024;
    const s = try speaker.Speaker.new(bufsize);
    defer s.free();

    try s.say("Hello, world!");
}
