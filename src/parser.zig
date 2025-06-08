//! Parser file.
const std = @import("std");
const ArrayList = std.ArrayList;
const Allocator = std.mem.Allocator;
const Token = @import("scanner.zig").Token;

pub const Parser = struct {
    tokens: ArrayList(Token),

    pub fn new(
        allocator: Allocator,
        tokens: ArrayList(Token),
    ) Parser {
        return .{
            .allocator = allocator,
            .tokens = tokens,
        };
    }
};

// KEYWORDS
// AND, OR, NOT, NIL, TRUE, FALSE --datatypes, and boolean operators
// IF, ELSEIF, ELSE -- conditionals
// WHILE, FOR, DONE -- loops
// LET, GOTO, GOSUB, RETURN -- other stuff, including C64 INSPIRATIONS AND VARIABLES
//
// total of 16 keywords, less than LUA
//
// BNF FOR BASIX
//
// PROGRAM      ::= LINE* | CHUNK
// LINE         ::= LINE_NUMBER CHUNK
// LINE_NUMBER  ::= ['0'-'9']*
// CHUNK        ::= EXPRESSION |
//                  ASSIGNMENT |
//                  ...
//
// EXPRESSION   ::= IDENTIFIER OPERATOR VALUE
// ASSIGNMENT   ::= "LET" IDENTIFIER '=' VALUE
//
// OPERATOR     ::= "+=" | "-=" | "*=" | "/="
// IDENTIFIER   ::= '_' ['a'-'z'] ['A'-'Z']
// VALUE        ::= NUMBER | -- number is 64-bit float
//                  STRING |
//                  IDENTIFIER |
//                  BOOLEAN

pub const Node = enum {};
