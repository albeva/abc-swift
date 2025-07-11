//
//  Token.swift
//  lbc
//
//  Created by Albert Varaksin on 11/07/2025.
//

// A token, produced by the lexer.
public struct Token {
    public enum Kind: String, CaseIterable {
        // Markers
        case unknown
        case eof
        case eos

        // Literals
        case number
        case identifier
        case string

        // Keywords
        case extern
        case dim
        case `as`
        case declare
        case function

        // Symbols
        case assign = "="
        case parenOpen = "("
        case parenClose = ")"
        case comma = ","
    }

    public let kind: Kind
    public let lexeme: String
}
