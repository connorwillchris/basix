const std = @import("std");

pub const Opcode = enum(u8) {
    Return = 0,
};

pub const Chunk = struct {
    allocator: std.mem.Allocator,
    code: std.ArrayList(u8),

    pub fn new(allocator: std.mem.Allocator) Chunk {
        return .{
            .allocator = allocator,
            .code = std.ArrayList(u8).init(allocator),
        };
    }

    pub fn writeChunk(
        self: *Chunk,
        byte: u8,
    ) void {
        if (self.capacity < self.count + 1) {
            try self.code.append(byte);
        }
    }
};
