import SwiftSyntax

final class NamespaceRewriter: SyntaxRewriter {

    private let namespace: String
    private let elementsRewriter: SyntaxRewriter

    init(namespace: String, elementsRewriter: SyntaxRewriter) {
        self.namespace = namespace
        self.elementsRewriter = elementsRewriter
    }

    override func visit(_ node: EnumDeclSyntax) -> DeclSyntax {
        guard node.identifier.text == namespace else { return node }
        return elementsRewriter.visit(node)
    }
}
