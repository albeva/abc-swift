//
//  Token.swift
//  lbc
//
//  Created by Albert Varaksin on 11/07/2025.
//

// A token, produced by the lexer.
struct Token: Equatable {
    enum Kind: String, CaseIterable, Equatable {
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

    let kind: Kind
    let lexeme: String
}
