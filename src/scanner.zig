const std = @import("std");
const parseInt = std.fmt.parseInt;

pub const Scanner = struct {
    alloc: std.mem.Allocator,
    tokens: std.ArrayList(Token),
    source: []const u8,
    start: usize,
    current: usize,
    line: u64,

    pub fn new(
        alloc: std.mem.Allocator,
        source: []const u8,
    ) Scanner {
        return .{
            .alloc = alloc,
            .source = source,
            .tokens = std.ArrayList(Token).init(alloc),
            .start = 0,
            .current = 0,
            .line = 1,
        };
    }

    pub fn scanTokens(self: *Scanner) !std.ArrayList(Token) {
        while (!self.isAtEnd()) {
            self.start = self.current;
            try self.scanToken();
        }

        try self.addToken(TokenType.Eof);
        return self.tokens;
    }

    fn isAtEnd(self: *Scanner) bool {
        return self.current == self.source.len - 1;
    }

    fn scanToken(self: *Scanner) !void {
        const c = self.advance();
        //var is_first_number = true;

        switch (c) {
            '(' => try self.addToken(TokenType.LeftParen),
            ')' => try self.addToken(TokenType.RightParen),
            '[' => try self.addToken(TokenType.LeftBrace),
            ']' => try self.addToken(TokenType.RightBrace),
            ',' => try self.addToken(TokenType.Comma),
            '-' => try self.addToken(TokenType.Minus),
            '+' => try self.addToken(TokenType.Plus),
            ';' => try self.addToken(TokenType.Semicolon),
            '*' => try self.addToken(TokenType.Asterisk),
            '/' => try self.addToken(TokenType.Slash),

            else => {},
        }
    }

    fn advance(self: *Scanner) u8 {
        self.current += 1;
        return self.source[self.current];
    }

    fn addToken(
        self: *Scanner,
        token_type: TokenType,
        //literal: *anyopaque,
    ) !void {
        const text = self.source[self.start..self.current];
        try self.tokens.append(Token.new(
            token_type,
            text,
            //literal,
            self.line,
        ));
    }

    fn setLineNumber(self: *Scanner) !void {
        //var buf: [16]u8 = undefined;
        //var i: usize = 0;
        var i: u32 = 0;
        for (self.source[self.start..]) |char| {
            //std.debug.print("{c}\n", .{char});
            if (char != ' ') {
                i += 1;
            } else break;
        }

        //std.debug.print("{s} {d}\n", .{ self.source[(self.current - 1)..(self.current + i)], i });
        //self.line = try std.fmt.parseInt(u32, self.source, 10);

        for (self.source[(self.current - 1)..(self.current + i - 1)]) |t| {
            std.debug.print("C: {c}\n", .{t});
        }
    }

    //fn addNumber(self: *Scanner) void {}
};

pub const Token = struct {
    token_type: TokenType,
    string: []const u8,
    line: usize,

    pub fn new(
        token_type: TokenType,
        string: []const u8,
        //literal: *anyopaque,
        line: usize,
    ) Token {
        return .{
            .token_type = token_type,
            .string = string,
            //.literal = literal,
            .line = line,
        };
    }
};

pub const TokenType = enum { Eof, Error, LeftParen, RightParen, LeftBrace, RightBrace, Comma, Minus, Plus, Semicolon, Slash, Asterisk, Identifier, LineNumber, String, Number, Bang, BangEqual, Equal, EqualEqual, Greater, GreaterEqual, Less, LessEqual, And, Or, Not, If, Else, ElseIf, Then, Print, Return, True, False, Let, Nil, While, Loop, End };
