//
//  Lexer.swift
//  lbc
//
//  Created by Albert on 11/07/2025.
//

import Foundation

// The lexer, which turns a source string into a stream of tokens.
public struct Lexer {
    private let source: String
    private var index: String.Index

    public init(source: String) {
        self.source = source
        self.index = source.startIndex
    }

    // Returns the next token in the source stream.
    mutating func next() -> Token {
        while hasMore {
            switch char {
            case " ", "\t":
                advance()
                continue
            case "\n":
                advance()
                return Token(kind: .eos, lexeme: "")
            case "\r":
                advance()
                if hasMore, char == "\n" {
                    advance()
                }
                return Token(kind: .eos, lexeme: "")
            case "a"..."z", "A"..."Z", "_":
                return identifier()
            case "0"..."9":
                return number()
            case "\"":
                return string()
            case "=":
                advance()
                return Token(kind: .assign, lexeme: "=")
            case "(":
                advance()
                return Token(kind: .parenOpen, lexeme: "(")
            case ")":
                advance()
                return Token(kind: .parenClose, lexeme: ")")
            case ",":
                advance()
                return Token(kind: .comma, lexeme: ",")
            default:
                let c = char
                advance()
                return Token(kind: .unknown, lexeme: String(c))
            }
        }
        return Token(kind: .eof, lexeme: "")
    }
}

// MARK: - Iterate over sequence

public struct LexerIterator: IteratorProtocol {
    private var lexer: Lexer

    init(lexer: Lexer) {
        self.lexer = lexer
    }

    public mutating func next() -> Token? {
        let token = lexer.next()
        return token.kind == .eof ? nil : token
    }
}

extension Lexer: Sequence {
    public func makeIterator() -> LexerIterator {
        return LexerIterator(lexer: self)
    }
}

// MARK: - Identifier / Keyword

extension Lexer {
    static let keywords: [String: Token.Kind] = [
        "extern": .extern,
        "dim": .dim,
        "as": .as,
        "declare": .declare,
        "function": .function
    ]

    mutating func identifier() -> Token {
        let start = index
        while hasMore, char.isLetter || char.isNumber || char == "_" {
            advance()
        }
        let lexeme = String(source[start..<index])
        let kind = Lexer.keywords[lexeme.lowercased()] ?? .identifier
        return Token(kind: kind, lexeme: lexeme)
    }
}

// MARK: - Numbers

extension Lexer {
    mutating func number() -> Token {
        let start = index
        while hasMore, char.isNumber {
            advance()
        }
        let lexeme = String(source[start..<index])
        return Token(kind: .number, lexeme: lexeme)
    }
}

// MARK: - Strings

extension Lexer {
    mutating func string() -> Token {
        // consume opening quote
        advance()
        let start = index
        while hasMore, char != "\"" {
            advance()
        }
        let lexeme = String(source[start..<index])
        // consume closing quote
        if hasMore {
            advance()
        }
        return Token(kind: .string, lexeme: lexeme)
    }
}

// MARK: - Helpers

extension Lexer {
    var hasMore: Bool {
        return index < source.endIndex
    }

    var char: Character {
        return source[index]
    }

    func peek() -> Character? {
        let nextIndex = source.index(after: index)
        guard nextIndex < source.endIndex else { return nil }
        return source[nextIndex]
    }

    mutating func advance() {
        index = source.index(after: index)
    }
}
