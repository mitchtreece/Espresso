////
////  VersionParser.swift
////  Espresso
////
////  Created by Mitch Treece on 6/13/22.
////

import Foundation

internal struct VersionParser {
    
    typealias VersionError = Version.Error
    
    static func parse(_ input: String) throws -> Version {

        let major: String
        let minor: String
        let patch: String
        let prereleaseIdentifiers: [String]
        let metadataIdentifiers: [String]

        let validator = try NSRegularExpression(
            pattern: "^([0-9A-Za-z|\\\(Version.prereleaseDelimiter)|\\\(Version.dotDelimiter)|\\\(Version.metadataDelimiter)]+)$"
        )

        guard input.rangeOfFirstMatch(for: validator).length == input.count else {
            throw VersionError.invalidString(input, nil)
        }

        let scanner = Scanner(string: input)
        let prefix = scanner.scanUpToCharacters(from: CharacterSet.decimalDigits)

        guard prefix != "-" else { throw Version.Error.invalidString(input, nil) }

        let delimiterCharacterSet = CharacterSet(charactersIn: "\(Version.prereleaseDelimiter)\(Version.metadataDelimiter)")

        guard let versionStr = scanner.scanUpToCharacters(from: delimiterCharacterSet) else {
            throw VersionError.invalidString(input, nil)
        }

        let versionScanner = Scanner(string: versionStr)

        guard let majorStr = versionScanner.scanCharacters(from: CharacterSet.decimalDigits) else {
            throw VersionError.digitsNotFound(input)
        }

        major = majorStr

        func scanNextVersion(_ scanner: Scanner) throws -> String {

            guard !scanner.isAtEnd else {
                return "0"
            }

            scanner.scanString(Version.dotDelimiter, into: nil)

            guard let digits = scanner.scanCharacters(from: CharacterSet.decimalDigits) else {
                throw VersionError.digitsNotFound(scanner.string)
            }

            return digits

        }

        minor = try scanNextVersion(versionScanner)
        patch = try scanNextVersion(versionScanner)

        let scanIndex = String.Index(utf16Offset: scanner.scanLocation, in: input)
        var remainder = String(input[scanIndex...])

        do {
            
            let prereleaseRegex = try NSRegularExpression(
                pattern: "(?<=^\(Version.prereleaseDelimiter))([0-9A-Za-z-\\\(Version.dotDelimiter)]+)"
            )

            let range = Range(remainder.rangeOfFirstMatch(for: prereleaseRegex), in: remainder)

            prereleaseIdentifiers = range
                .map { String(remainder[$0]) }
                .map { $0.components(separatedBy: Version.dotDelimiter) }
                ?? []

            remainder = range.map { String(remainder[$0.upperBound...]) } ?? remainder

        }
        catch {
            throw VersionError.parsing(.prerelease, error)
        }

        do {

            let buildRegex = try NSRegularExpression(
                pattern: "(?<=^\\\(Version.metadataDelimiter))([0-9A-Za-z-\\\(Version.dotDelimiter)]+)"
            )

            let range = Range(remainder.rangeOfFirstMatch(for: buildRegex), in: remainder)

            metadataIdentifiers = range
                .map { String(remainder[$0]) }
                .map { $0.components(separatedBy: Version.dotDelimiter) }
                ?? []

            remainder = range.map { String(remainder[$0.upperBound...]) } ?? remainder

        }
        catch {
            throw VersionError.parsing(.metadata, error)
        }

        guard remainder.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 else {
            throw VersionError.invalidString(input, nil)
        }
        
        guard let majorInt = UInt(major),
              let minorInt = UInt(minor),
              let patchInt = UInt(patch) else {
            
            throw VersionError.invalidString(input, nil)
            
        }

        return Version(
            majorInt,
            minorInt,
            patchInt,
            prerelease: prereleaseIdentifiers,
            metadata: metadataIdentifiers
        )

    }

}
