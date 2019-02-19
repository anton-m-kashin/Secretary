enum ArgumentsParsingError: Error {
    case missingArguments
}

func parseArguments(
    _ args: [String]
) throws -> (plistPath: String, swiftPath: String) {
    guard args.count >= 3 else {
        throw ArgumentsParsingError.missingArguments
    }
    return (plistPath: args[1], swiftPath: args[2])
}
