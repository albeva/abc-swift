//
//  Lexer.swift
//  lbc
//
//  Created by Albert on 11/07/2025.
//

import Foundation

// The lexer, which turns a source string into a stream of tokens.
class Lexer {
    private let source: String
    private var index: String.Index

    init(source: String) {
        self.source = source
        self.index = source.startIndex
    }

    // Returns the next token in the source stream.
    func next() -> Token {
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

// MARK: - Identifier / Keyword

extension Lexer {
    private static let keywords: [String: Token.Kind] = [
        "extern": .extern,
        "dim": .dim,
        "as": .as,
        "declare": .declare,
        "function": .function
    ]

    private func identifier() -> Token {
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
    private func number() -> Token {
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
    private func string() -> Token {
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
    private var hasMore: Bool {
        return index < source.endIndex
    }

    private var char: Character {
        return source[index]
    }

    private func peek() -> Character? {
        let nextIndex = source.index(after: index)
        guard nextIndex < source.endIndex else { return nil }
        return source[nextIndex]
    }

    private func advance() {
        index = source.index(after: index)
    }
}
