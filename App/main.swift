//
//  main.swift
//  lbc
//
//  Created by Albert Varaksin on 11/07/2025.
//

import Foundation
import LbcLib

let lexer = Lexer(source: "print \"hello world\"")
for token in lexer {
    print(token)
}
