const std = @import("std");

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
