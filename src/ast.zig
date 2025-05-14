// Abstract Syntax Tree
const std = @import("std");
const ArrayList = std.ArrayList;
const Token = @import("scanner.zig").Token;

pub const Parser = struct {
    tokens: ArrayList(Token),

    pub fn new(
        tokens: ArrayList(Token),
    ) Parser {
        return .{
            .tokens = tokens,
        };
    }
};

// KEYWORDS
// AND, OR, NOT, NIL --datatypes, and boolean operators
// IF, ELSEIF, ELSE -- conditionals
// WHILE, FOR, DONE -- loops
// LET, GOTO, GOSUB, RETURN -- other stuff, including C64 INSPIRATIONS AND VARIABLES
//
// total of 14 keywords, less than LUA

// BNF FOR BASIX
