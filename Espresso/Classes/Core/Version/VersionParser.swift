//
//  VersionParser.swift
//  Espresso
//
//  Created by Mitch Treece on 6/13/22.
//

import Foundation

internal struct VersionParser {
    
    internal static let dotDelimiter = "."
    internal static let prereleaseDelimiter = "-"
    internal static let buildDelimiter = "+"
    
    public enum Error: Swift.Error {
        
        case invalidString(String, Swift.Error?)
        case digitsNotFound(String)
        case parsing(Version.Component, Swift.Error)
        
        var localizedDescription: String {
            
            switch self {
            case .invalidString(let version, let error):
                
                return "invalid \"\(version)\"\t\(error.map { "\nInfo)" + $0.localizedDescription } ?? "")"
                
            case .digitsNotFound(let version):
                
                return "no digits in \(version)"
                
            case .parsing(let component, let error):
                
                return "\(component) error: \(error.localizedDescription)"
                
            }
            
        }
        
    }
    
    static func parse(_ input: String) throws -> Version {
        
        let major: String
        let minor: String
        let patch: String
        let prereleaseIdentifiers: [String]
        let buildIdentifiers: [String]

        let validator = try NSRegularExpression(
            pattern: "^([0-9A-Za-z|\\\(prereleaseDelimiter)|\\\(dotDelimiter)|\\\(buildDelimiter)]+)$"
        )
        
        guard input.rangeOfFirstMatch(for: validator).length == input.count else {
            throw Error.invalidString(input, nil)
        }

        let scanner = Scanner(string: input)
        let prefix = scanner.scanUpToCharacters(from: CharacterSet.decimalDigits)
        
        guard prefix != "-" else { throw Error.invalidString(input, nil) }

        let delimiterCharacterSet = CharacterSet(charactersIn: "\(prereleaseDelimiter)\(buildDelimiter)")
        
        guard let versionStr = scanner.scanUpToCharacters(from: delimiterCharacterSet) else {
            throw Error.invalidString(input, nil)
        }

        let versionScanner = Scanner(string: versionStr)
        
        guard let majorStr = versionScanner.scanCharacters(from: CharacterSet.decimalDigits) else {
            throw Error.digitsNotFound(input)
        }
        
        major = majorStr

        func scanNextVersion(_ scanner: Scanner) throws -> String {
            
            guard !scanner.isAtEnd else {
                return "0"
            }
            
            scanner.scanString(dotDelimiter, into: nil)
            
            guard let digits = scanner.scanCharacters(from: CharacterSet.decimalDigits) else {
                throw Error.digitsNotFound(scanner.string)
            }
            
            return digits
            
        }
        
        minor = try scanNextVersion(versionScanner)
        patch = try scanNextVersion(versionScanner)

        let scanIndex = String.Index(utf16Offset: scanner.scanLocation, in: input)
        var remainder = String(input[scanIndex...])
        
        do {
            let prereleaseRegex = try NSRegularExpression(
                pattern: "(?<=^\(prereleaseDelimiter))([0-9A-Za-z-\\\(dotDelimiter)]+)"
            )
            
            let range = Range(remainder.rangeOfFirstMatch(for: prereleaseRegex), in: remainder)
            
            prereleaseIdentifiers = range
                .map { String(remainder[$0]) }
                .map { $0.components(separatedBy: dotDelimiter) }
                ?? []
            
            remainder = range.map { String(remainder[$0.upperBound...]) } ?? remainder
            
        }
        catch {
            throw Error.parsing(.prereleaseIdentifiers, error)
        }

        do {
            
            let buildRegex = try NSRegularExpression(
                pattern: "(?<=^\\\(buildDelimiter))([0-9A-Za-z-\\\(dotDelimiter)]+)"
            )
            
            let range = Range(remainder.rangeOfFirstMatch(for: buildRegex), in: remainder)
            
            buildIdentifiers = range
                .map { String(remainder[$0]) }
                .map { $0.components(separatedBy: dotDelimiter) }
                ?? []
            
            remainder = range.map { String(remainder[$0.upperBound...]) } ?? remainder
            
        }
        catch {
            throw Error.parsing(.buildIdentifiers, error)
        }
        
        guard remainder.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).count == 0 else {
            throw Error.invalidString(input, nil)
        }

        return Version(
            major: major,
            minor: minor,
            patch: patch,
            prereleaseIdentifiers: prereleaseIdentifiers,
            buildIdentifiers: buildIdentifiers
        )
        
    }
    
}
