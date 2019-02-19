import SwiftSyntax

final class SecretsInitializersUpdater: SyntaxRewriter {

    private(set) var secrets: [String: String]

    init(secrets: [String: String]) {
        self.secrets = secrets
    }

    override func visit(_ node: VariableDeclSyntax) -> DeclSyntax {
        guard isValidNode(node) else { return node }
        guard
            let identifier = getIdentifier(for: node),
            let secret = secrets[identifier]
        else { return node }
        let newNode = replaceInitializer(in: node, withText: secret)
        secrets.removeValue(forKey: identifier)
        return newNode
    }

    private func getIdentifier(for node: VariableDeclSyntax) -> String? {
        guard
            let identifier = node.bindings[0].pattern
                as? IdentifierPatternSyntax
        else { return nil }
        return identifier.identifier.text
    }

    private func replaceInitializer(
        in node: VariableDeclSyntax,
        withText text: String
    ) -> DeclSyntax {
        let newInitializer = SyntaxFactory.makeInitializer(text)
        return node.replacingInitializer(newInitializer)
    }

    private func isValidNode(_ node: VariableDeclSyntax) -> Bool {
        if node.bindings.count != 1 { return false }
        if !node.isStatic { return false }
        if let type = node.type {
            guard type == "String" else { return false }
        }
        return true
    }
}

private extension VariableDeclSyntax {

    var type: String? {
        if
            let typeAnnotation = bindings[0].typeAnnotation,
            let type = typeAnnotation.type as? SimpleTypeIdentifierSyntax,
            case .identifier(let text) = type.name.tokenKind
        {
            return text
        }
        return nil
    }
}
