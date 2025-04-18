const std = @import("std");

pub const Scanner = struct {
    str: []const u8,
    current: usize,
    line: usize,

    pub fn new(source: []const u8) Scanner {
        return .{
            .str = source,
            .current = source,
            .line = 0,
        };
    }

    pub fn makeToken(self: Scanner, token_type: TokenType) Token {
        const t: Token = .{
            ._type = token_type,
            //.start = self.start,
            .length = self.current.len,
            .line = self.line,
        };

        return t;
    }

    //pub fn isAtEnd(self: Scanner) bool {}

    pub fn errorToken(
        self: Scanner,
        message: []const u8,
    ) Token {
        const t: Token = .{
            ._type = TokenType.Error,
            //.start = message,
            .length = message.len,
            .line = self.line,
        };
        return t;
    }

    fn isAtEnd(self: Scanner) bool {
        return self.current.*[0..] == 0;
    }

    fn advance(self: Scanner) u8 {
        //self.current;
        return self.current[0];
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
    _type: TokenType,
    start: []const u8,
    length: usize,
    line: u64,

    pub fn scanToken( //self: Token, scanner: *Scanner) Token {
        scannerObj: *Scanner,
    ) Token {
        //scannerObj.start = scannerObj.current;

        if (scannerObj.isAtEnd()) return scannerObj.makeToken(TokenType.Eof);

        const c = scannerObj.advance();
        switch (c) {
            '(' => return scannerObj.makeToken(TokenType.LeftParen),
            ')' => return scannerObj.makeToken(TokenType.RightParen),
            else => {},
        }

        return scannerObj.errorToken("Unexpected character.");
    }
};
