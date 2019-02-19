import Foundation
import SecretsSwift

let usage = "Usage: \(CommandLine.arguments[0])"
    + " </path/to/secrets.plist>"
    + " </path/to/secrets.swift>"

do {
    let (plistPath, swiftPath) = try parseArguments(CommandLine.arguments)
    let secrets = try parseSecrets(fromPlistPath: plistPath)
    let data = try updatedSource(atPath: swiftPath, secrets: secrets)
    try data.write(to: URL(fileURLWithPath: swiftPath))
    print("File: \(swiftPath) updated wtih:")
    print(String(data: data, encoding: .utf8)!)
} catch {
    print("Error: \(String(describing: error))")
    print(usage)
    exit(1)
}
