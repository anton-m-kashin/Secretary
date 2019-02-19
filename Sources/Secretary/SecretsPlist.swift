import Foundation

enum SecretsPlistParsingError: Error {
    case invalidFormat
}

func parseSecrets(fromPlistPath path: String) throws -> [String: String] {
    let data = try Data(contentsOf: URL(fileURLWithPath: path))
    guard
        let dictionary = try PropertyListSerialization
            .propertyList(from: data, format: nil) as? [String: String]
    else {
        throw SecretsPlistParsingError.invalidFormat
    }
    return dictionary
}
