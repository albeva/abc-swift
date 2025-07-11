//
//  AST.swift
//  Lbc
//
//  Created by Albert on 12/07/2025.
//

import Foundation

// MARK: - Protocols

public protocol AstNode {}
public protocol AstStmt: AstNode {}
public protocol AstExpr: AstNode {}
public protocol AstDecl: AstNode {}
public protocol AstType: AstNode {}

// MARK: - Top Level

public struct AstModule: AstNode {
    public let body: [AstStatement]
}

public struct AstIdentifier: AstNode {
    public let token: Token
}

// MARK: - Statements

public indirect enum AstStatement: AstStmt {
    case extern(AstDeclaration)
    case dim(AstVariableDecl)
    case expression(AstExpression)
}

// MARK: - Declarations

public indirect enum AstDeclaration: AstDecl {
    case variable(AstVariableDecl)
    case function(AstFunctionDecl)
}

public struct AstVariableDecl: AstDecl {
    public let id: AstIdentifier
    public let type: AstTypeExpressions
    public let value: AstExpression
}

public struct AstFunctionDecl: AstDecl {
    public let id: AstIdentifier
    public let parameters: [AstFuncParameter]
    public let returnType: AstTypeExpressions
}

public struct AstFuncParameter: AstDecl {
    public let id: AstIdentifier
    public let type: AstTypeExpressions
}

// MARK: - Expressions

public indirect enum AstExpression: AstExpr {
    case literal(AstLiteralExpr)
    case identifier(AstFuncParameter)
    case call(AstCallExpr)
}

public struct AstLiteralExpr: AstExpr {
    public let id: Token
}

public struct AstCallExpr: AstExpr {
    public let callee: AstExpression
    public let arguments: [AstExpression]
}

// MARK: - Types

public indirect enum AstTypeExpressions: AstType {
    case builtin(AstIdentifier)
    case pointer(AstTypeExpressions)
    case reference(AstTypeExpressions)
}
