import SwiftSyntax

extension VariableDeclSyntax {

    var isStatic: Bool {
        guard let modifiers = modifiers else { return false }
        return modifiers.contains { modifier in
            if case .staticKeyword = modifier.name.tokenKind { return true }
            return false
        }
    }

    func replacingInitializer(
        _ initializer: InitializerClauseSyntax
    ) -> VariableDeclSyntax {
        guard bindings.count == 1 else { return self }
        let newBinding = bindings[0].withInitializer(initializer)
        let newBindings = bindings.replacing(childAt: 0, with: newBinding)
        return withBindings(newBindings)
    }
}
