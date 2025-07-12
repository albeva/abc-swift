//
//  AST.swift
//  Lbc
//
//  Created by Albert on 12/07/2025.
//

import Foundation

// MARK: - Base protocols. These are used for tagging classes and enums

protocol AstNode {}
protocol AstStmt: AstNode {}
protocol AstExpr: AstNode {}
protocol AstDecl: AstNode {}
protocol AstType: AstNode {}


// MARK: - Base Classes for all AST Nodes

class AstBase: AstNode {}
class AstStatement: AstBase, AstStmt {}
class AstExpression: AstBase, AstExpr {}
class AstDeclaration: AstBase, AstDecl {}
class AstTypeExpression: AstBase, AstType {}

// MARK: - Top Level

final class AstModule: AstBase {
    let body: [AstStmtKind]
    init(body: [AstStmtKind]) {
        self.body = body
        super.init()
    }
}

final class AstIdentifier: AstBase {
    let token: Token
    init(token: Token) {
        self.token = token
    }
}

// MARK: - Statements

enum AstStmtKind: AstStmt {
    case extern(AstDeclKind)
    case dim(AstVariableDecl)
    case expression(AstExprKind)
}

// MARK: - Declarations

enum AstDeclKind: AstDecl {
    case variable(AstVariableDecl)
    case function(AstFunctionDecl)
}

final class AstVariableDecl: AstDeclaration {
    let id: AstIdentifier
    let type: AstTypeKind
    let value: AstExprKind
    init(id: AstIdentifier, type: AstTypeKind, value: AstExprKind) {
        self.id = id
        self.type = type
        self.value = value
        super.init()
    }
}

final class AstFunctionDecl: AstDeclaration {
    let id: AstIdentifier
    let parameters: [AstFuncParameter]
    let returnType: AstTypeKind
    init(id: AstIdentifier, parameters: [AstFuncParameter], returnType: AstTypeKind) {
        self.id = id
        self.parameters = parameters
        self.returnType = returnType
        super.init()
    }
}

final class AstFuncParameter: AstDeclaration {
    let id: AstIdentifier
    let type: AstTypeKind
    init(id: AstIdentifier, type: AstTypeKind) {
        self.id = id
        self.type = type
        super.init()
    }
}

// MARK: - Expressions

indirect enum AstExprKind: AstExpr {
    case literal(AstLiteralExpr)
    case variable(AstVariablleExpr)
    case call(AstCallExpr)
}

final class AstLiteralExpr: AstExpression {
    let id: Token
    init(id: Token) {
        self.id = id
    }
}

final class AstCallExpr: AstExpression {
    let callee: AstExprKind
    let arguments: [AstExprKind]
    init(callee: AstExprKind, arguments: [AstExprKind]) {
        self.callee = callee
        self.arguments = arguments
    }
}

final class AstVariablleExpr: AstExpression {
    let id: AstIdentifier
    init(id: AstIdentifier) {
        self.id = id
    }
}

// MARK: - Types

enum AstTypeKind: AstType {
    case identifier(AstBuiltinType)
    case pointer(AstPointerType)
    case reference(AstReferenceType)
}

final class AstBuiltinType: AstTypeExpression {
    let token: Token
    init(token: Token) {
        self.token = token
    }
}

final class AstPointerType: AstTypeExpression {
    let base: AstTypeKind
    init(base: AstTypeKind) {
        self.base = base
    }
}

final class AstReferenceType: AstTypeExpression {
    let base: AstTypeKind
    init(base: AstTypeKind) {
        self.base = base
    }
}
