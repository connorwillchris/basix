const std = @import("std");

pub var scanner: Scanner = undefined;

pub const Scanner = struct {
    start: []u8,
    line: usize,

    pub fn new(source: []const u8) Scanner {
        scanner.line = 1;
        scanner.start = source;
    }

    pub fn scanToken() Token {
        scanner.start = scanner.start.ptr - scanner.start;

        if (isAtEnd()) return makeToken(Token.Eof);

        return errorToken("Unexpected character");
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
