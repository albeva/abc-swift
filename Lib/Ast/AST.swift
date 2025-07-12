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
class AstStmtBase: AstBase, AstStmt {}
class AstExprBase: AstBase, AstExpr {}
class AstDeclBase: AstBase, AstDecl {}
class AstTypeBase: AstBase, AstType {}

// MARK: - Top Level

final class AstModule: AstBase {
    let body: [AstStatement]
    init(body: [AstStatement]) {
        self.body = body
    }
}

final class AstIdentifier: AstBase {
    let token: Token
    init(token: Token) {
        self.token = token
    }
}

// MARK: - Statements

enum AstStatement: AstStmt {
    case extern(AstDeclaration)
    case dim(AstVariableDecl)
    case expression(AstExpression)
}

// MARK: - Declarations

enum AstDeclaration: AstDecl {
    case variable(AstVariableDecl)
    case function(AstFunctionDecl)
}

final class AstVariableDecl: AstDeclBase {
    let id: AstIdentifier
    let type: AstTypeExpression
    let value: AstExpression
    init(id: AstIdentifier, type: AstTypeExpression, value: AstExpression) {
        self.id = id
        self.type = type
        self.value = value
        super.init()
    }
}

final class AstFunctionDecl: AstDeclBase {
    let id: AstIdentifier
    let parameters: [AstFuncParameter]
    let returnType: AstTypeExpression
    init(id: AstIdentifier, parameters: [AstFuncParameter], returnType: AstTypeExpression) {
        self.id = id
        self.parameters = parameters
        self.returnType = returnType
        super.init()
    }
}

final class AstFuncParameter: AstDeclBase {
    let id: AstIdentifier
    let type: AstTypeExpression
    init(id: AstIdentifier, type: AstTypeExpression) {
        self.id = id
        self.type = type
        super.init()
    }
}

// MARK: - Expressions

enum AstExpression: AstExpr {
    case literal(AstLiteralExpr)
    case variable(AstVariablleExpr)
    case call(AstCallExpr)
}

final class AstLiteralExpr: AstExprBase {
    let id: Token
    init(id: Token) {
        self.id = id
    }
}

final class AstCallExpr: AstExprBase {
    let callee: AstExpression
    let arguments: [AstExpression]
    init(callee: AstExpression, arguments: [AstExpression]) {
        self.callee = callee
        self.arguments = arguments
    }
}

final class AstVariablleExpr: AstExprBase {
    let id: AstIdentifier
    init(id: AstIdentifier) {
        self.id = id
    }
}

// MARK: - Types

enum AstTypeExpression: AstType {
    case identifier(AstBuiltinType)
    case pointer(AstPointerType)
    case reference(AstReferenceType)
}

final class AstBuiltinType: AstTypeBase {
    let token: Token
    init(token: Token) {
        self.token = token
    }
}

final class AstPointerType: AstTypeBase {
    let base: AstTypeExpression
    init(base: AstTypeExpression) {
        self.base = base
    }
}

final class AstReferenceType: AstTypeBase {
    let base: AstTypeExpression
    init(base: AstTypeExpression) {
        self.base = base
    }
}
