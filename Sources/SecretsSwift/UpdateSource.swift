import Foundation
import SwiftSyntax

public func updatedSource(
    atPath path: String,
    secrets: [String: String]
) throws -> Data {
    let url = URL(fileURLWithPath: path)
    let source = try SyntaxTreeParser.parse(url)

    let (updatedSource, remainingSecrets) = updatePresentedSecrets(
        in: source,
        withSecrets: secrets
    )
    let addedSource = addMissingVariables(
        in: updatedSource,
        withSecrets: remainingSecrets
    )

    return String(describing: addedSource)
        .data(using: .utf8)!
}

private let secretsNamespace = "Secrets"

private func updatePresentedSecrets(
    in source: Syntax,
    withSecrets secrets: [String: String]
) -> (updatedSource: Syntax, remainingSecrets: [String: String]) {
    let elementsUpdater = SecretsInitializersUpdater(secrets: secrets)
    let namespaceUpdater = NamespaceRewriter(
        namespace: secretsNamespace,
        elementsRewriter: elementsUpdater
    )
    let updatedSource = namespaceUpdater.visit(source)
    return (
        updatedSource: updatedSource,
        remainingSecrets: elementsUpdater.secrets
    )
}

private func addMissingVariables(
    in source: Syntax,
    withSecrets secrets: [String: String]
) -> Syntax {
    if secrets.isEmpty { return source }
    let elementsUpdater = SecretsAdder(secrets: secrets)
    let namespaceUpdater = NamespaceRewriter(
        namespace: secretsNamespace,
        elementsRewriter: elementsUpdater
    )
    return namespaceUpdater.visit(source)
}
