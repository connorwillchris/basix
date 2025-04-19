const std = @import("std");

pub var scanner: Scanner = undefined;

pub const Scanner = struct {
    start: []u8,
    line: usize,
    current: usize,

    pub fn new(source: []const u8) Scanner {
        scanner.line = 1;
        scanner.start = source;
    }

    pub fn scanToken(self: Scanner) Token {
        scanner.start = scanner.start.ptr - scanner.start;

        if (self.isAtEnd()) return makeToken(Token.Eof);

        const c = self.advance();
        switch (c) {
            '(' => return self.makeToken(TokenType.LeftParen),
            ')' => return self.makeToken(TokenType.RightParen),
            else => {},
        }

        return errorToken("Unexpected character");
    }

    fn advance(self: Scanner) u8 {
        self.current += 1;
        return self.start[self.current];
    }

    fn isAtEnd(self: Scanner) bool {
        return self.start[self.current] == 0;
    }

    fn makeToken(
        self: Scanner,
        token_type: TokenType,
    ) Token {
        return .{
            .token_type = token_type,
            .start = self.start,
            .length = self.start.len - self.current,
            .line = self.line,
        };
    }

    fn errorToken(self: Scanner, message: []const u8) Token {
        return .{
            .token_type = TokenType.Error,
            .start = message,
            .length = message.len,
            .line = self.line,
        };
    }
};

pub const TokenType = enum {
    // single character tokens
    Eof,
    Error,

    LeftParen,
    RightParen,
    LeftBrace,
    RightBrace,
    Comma,
    Minus,
    Plus,
    Semicolon,
    Slash,
    Asterisk,

    // literals
    Identifier,
    LineNumber,
    String,
    Number,

    // one or two character tokens
    Bang,
    BangEqual,
    Equal,
    EqualEqual,
    Greater,
    GreaterEqual,
    Less,
    LessEqual,

    // keywords
    And,
    Or,
    Not,

    If,
    Else,
    ElseIf,
    Then,

    Print,
    Return,
    True,
    False,
    Let,
    Nil,

    While,
    Loop,
    End,
};

pub const Token = struct {
    token_type: TokenType,
    start: []const u8,
    length: usize,
    line: usize,

    //pub scanToken
};
