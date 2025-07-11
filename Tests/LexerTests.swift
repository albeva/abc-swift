//
//  LexerTests.swift
//  LbcTests
//
//  Created by Albert Varaksin on 11/07/2025.
//
import Testing
@testable import LbcLib

struct LexerTests {
    @Test func testLexer() throws {
        let source = """
        Extern "C" Declare Function puts(str As ZString) As Integer
        Dim msg = "Hello World"
        puts msg
        """
        
        let expected: [Token] = [
            Token(kind: .extern, lexeme: "Extern"),
            Token(kind: .string, lexeme: "C"),
            Token(kind: .declare, lexeme: "Declare"),
            Token(kind: .function, lexeme: "Function"),
            Token(kind: .identifier, lexeme: "puts"),
            Token(kind: .parenOpen, lexeme: "("),
            Token(kind: .identifier, lexeme: "str"),
            Token(kind: .as, lexeme: "As"),
            Token(kind: .identifier, lexeme: "ZString"),
            Token(kind: .parenClose, lexeme: ")"),
            Token(kind: .as, lexeme: "As"),
            Token(kind: .identifier, lexeme: "Integer"),
            Token(kind: .eos, lexeme: ""),
            Token(kind: .dim, lexeme: "Dim"),
            Token(kind: .identifier, lexeme: "msg"),
            Token(kind: .assign, lexeme: "="),
            Token(kind: .string, lexeme: "Hello World"),
            Token(kind: .eos, lexeme: ""),
            Token(kind: .identifier, lexeme: "puts"),
            Token(kind: .identifier, lexeme: "msg"),
            Token(kind: .eof, lexeme: ""),
        ]
        
        var lexer = Lexer(source: source)
        for token in expected {
            #expect(lexer.next() == token)
        }
    }
}
