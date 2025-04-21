const std = @import("std");

pub const Scanner = struct {
    source: []const u8,
    tokens: std.ArrayList(Token),
    start: usize,
    current: usize,
    line: usize,
    current: usize,

    pub fn new(source: []const u8) Scanner {
        return .{
            .source = source,
            .tokens = undefined,
            .start = 0,
            .current = 0,
            .line = 1,
        };
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
    pub fn scanTokens(self: Scanner) std.ArrayList(Token) {
        while (!self.isAtEnd()) {
            self.start = self.current;
            self.scanToken();
        }

        self.tokens.append(.{
            .token_type = TokenType.Eof,
            .lexeme = "",
            .literal = null,
            .line = self.line,
        });
        return self.tokens;
    }

    fn advance(self: Scanner) u8 {
        self.current += 1;
        return self.source[self.current];
    }

    fn scanToken(self: Scanner) void {
        const c = self.advance();
        switch (c) {
            '(' => self.addToken(TokenType.LeftParen),
            ')' => self.addToken(TokenType.RightParen),
            ';' => self.addToken(TokenType.Semicolon),
            else => {},
        }
    }

    //fn addToken(self: Scanner, token_type: TokenType) void {
    //self.addToken(token_type);
    //}

    fn addToken(self: Scanner, token_type: TokenType, literal: *void) void {
        const text = self.source[self.start..self.current];
        self.tokens.append(.{
            .token_type = token_type,
            .lexeme = text,
            .literal = literal,
            .line = self.line,
        });
    }
};

pub const Token = struct {
    token_type: TokenType,
    lexeme: []const u8,
    literal: anyopaque,
    line: usize,

    pub fn new(
        token_type: TokenType,
        lexeme: []const u8,
        literal: anyopaque,
        line: usize,
    ) Token {
        return .{
            .token_type = token_type,
            .lexeme = lexeme,
            .literal = literal,
            .line = line,
        };
    }

    pub fn toString(self: Token) []const u8 {
        return " " ++ self.lexeme;
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
