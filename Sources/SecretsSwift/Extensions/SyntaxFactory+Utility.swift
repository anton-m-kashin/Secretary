import SwiftSyntax

extension SyntaxFactory {

    static func makeStaticConstant(
        name: String,
        value: String
    ) -> VariableDeclSyntax {
        let staticModifier = makeStaticModifier()
        let letKeyword = SyntaxFactory.makeToken(
            .letKeyword,
            presence: .present,
            trailingTrivia: .spaces(1)
        )
        let binding = SyntaxFactory.makePatternBinding(
            pattern: makeIdentifierPattern(name),
            typeAnnotation: nil,
            initializer: makeInitializer(value),
            accessor: nil,
            trailingComma: nil
        )
        return makeVariableDecl(
            attributes: nil,
            modifiers: makeModifierList([staticModifier]),
            letOrVarKeyword: letKeyword,
            bindings: makePatternBindingList([binding])
        )
    }

    static func makeStaticModifier() -> DeclModifierSyntax {
        let staticKeyword = SyntaxFactory.makeToken(
            .staticKeyword,
            presence: .present,
            leadingTrivia: [.newlines(1), .spaces(4)],
            trailingTrivia: .spaces(1)
        )
        return SyntaxFactory.makeDeclModifier(
            name: staticKeyword,
            detail: nil
        )
    }

    static func makeIdentifierPattern(
        _ text: String
    ) -> IdentifierPatternSyntax {
        let identifier = SyntaxFactory.makeToken(
            .identifier(text),
            presence: .present,
            trailingTrivia: .spaces(1)
        )
        return SyntaxFactory.makeIdentifierPattern(
            identifier: identifier
        )
    }

    static func makeInitializer(
        _ text: String
    ) -> InitializerClauseSyntax {
        let token = makeToken(
            .stringLiteral("\"\(text)\""),
            presence: .present
        )
        let literal = makeStringLiteralExpr(stringLiteral: token)
        return SyntaxFactory.makeInitializerClause(
            equal: SyntaxFactory.makeEqualToken(trailingTrivia: .spaces(1)),
            value: literal
        )
    }
}
