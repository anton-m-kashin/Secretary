import SwiftSyntax

final class SecretsAdder: SyntaxRewriter {

    private let secrets: [String: String]

    init(secrets: [String: String]) {
        self.secrets = secrets
    }

    override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
        let variables = secrets
            .map(SyntaxFactory.makeStaticConstant(name:value:))
        let members = variables.reduce(node.members) { $0.addDecl($1) }
        return node.withMembers(members)
    }
}
