//
//  Version.swift
//  Espresso
//
//  Created by Mitch Treece on 6/13/22.
//

import Foundation

/// Representation of a semantic version (SemVer) number.
public struct Version {
    
    public enum Component {
        
        case major
        case minor
        case patch
        case prerelease
        case metadata
        
    }
    
    /// Representation of the various version-string formats.
    public enum StringFormat {
        
        /// A compact version-string format.
        ///
        /// `{major}.{minor}.{patch}`
        ///
        /// `1.2.3`
        case compact
        
        /// An expanded version-string format.
        ///
        /// `{major}.{minor}.{patch}-{prerelease}`
        ///
        /// `1.2.3-rc.1`
        case expanded
        
        /// A full version-string format.
        ///
        /// `{major}.{minor}.{patch}-{prerelease}+{metadata}`
        ///
        /// `1.2.3-rc.1+SHA.a0f21`
        case full
        
    }
    
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
    
    public let major: String
    public let minor: String
    public let patch: String
    public let prerelease: [String]
    public let metadata: [String]
        
    public static let invalid = Version(0, 0, 0)
    public static let min = Version(0, 0, 1)
    public static let max = Version(999, 999, 999)
    
    internal static let dotDelimiter = "."
    internal static let prereleaseDelimiter = "-"
    internal static let metadataDelimiter = "+"
    
    internal init(major: String,
                  minor: String,
                  patch: String,
                  prerelease: [String],
                  metadata: [String]) {
        
        self.major = major
        self.minor = minor
        self.patch = patch
        self.prerelease = prerelease
        self.metadata = metadata
        
    }
    
    public init(_ major: UInt,
                _ minor: UInt,
                _ patch: UInt,
                prerelease: [String] = [],
                metadata: [String] = []) {
        
        self.init(
            major: "\(major)",
            minor: "\(minor)",
            patch: "\(patch)",
            prerelease: prerelease,
            metadata: metadata
        )
        
    }
    
    /// Parses the string as a Semver and returns the result.
    ///
    /// - Parameter version: a string to parse.
    /// - Throws: throw `ParsingError` if the string is not a valid representation of a semantic version.
    public init(_ string: String) throws {
        self = try VersionParser.parse(string)
    }
    
    /// Parses the number as a Semver and returns the result.
    ///
    /// - Parameter version: a numeric object to parse.
    /// - Throws: throw `ParsingError` if the numeric object is not a valid representation of a semantic version.
    public init<T: Numeric>(_ number: T) throws {
        self = try VersionParser.parse("\(number)")
    }

    /// Returns a string representation of the `Version`.
    ///
    /// - Parameter format: Specifies string representation Style; _defaults to full.
    /// - Returns: a string representation of the Version.
    public func asString(format: StringFormat = .full) -> String {
        
        let version = [self.major, self.minor, self.patch].joined(separator: Self.dotDelimiter)
        let prerelease = self.prerelease.joined(separator: Self.dotDelimiter)
        let metadata = self.metadata.joined(separator: Self.dotDelimiter)
        
        switch format {
        case .compact: return version
        case .expanded:
            
            return version +
                (prerelease.count > 0 ? "\(Self.prereleaseDelimiter)\(prerelease)" : "")
            
        case .full:
            
            return version +
                (prerelease.count > 0 ? "\(Self.prereleaseDelimiter)\(prerelease)" : "") +
                (metadata.count > 0 ? "\(Self.metadataDelimiter)\(metadata)" : "")
            
        }
        
    }
    
}

extension Version: Comparable {
    
    public static func == (lhs: Version, rhs: Version) -> Bool {
        
        let isMajorEqual = (lhs.major.compare(rhs.major, options: .numeric) == .orderedSame)
        let isMinorEqual = (lhs.minor.compare(rhs.minor, options: .numeric) == .orderedSame)
        let isPatchEqual = (lhs.patch.compare(rhs.patch, options: .numeric) == .orderedSame)
        
        let isPrereleaseCountEqual = (lhs.prerelease.count == rhs.prerelease.count)
        let isPrereleaseIdentifiersEqual = zip(
            lhs.prerelease,
            rhs.prerelease
        )
        .reduce(into: true) { result, element in
               
            guard result == true else { return }

            let (lhsIdentifiers, rhsIdentifiers) = element
            
            switch (lhsIdentifiers.isNumber, rhsIdentifiers.isNumber) {
            case (true, true): result = (lhsIdentifiers.compare(rhsIdentifiers, options: .numeric) == .orderedSame)
            case (false, false): result = (lhsIdentifiers == rhsIdentifiers)
            default: result = false
            }
            
        }
        
        return (
            isMajorEqual &&
            isMinorEqual &&
            isPatchEqual &&
            isPrereleaseCountEqual &&
            isPrereleaseIdentifiersEqual
        )
        
    }

    public static func < (lhs: Version, rhs: Version) -> Bool {
        
        let lhsComponents = [lhs.major, lhs.minor, lhs.patch]
        let rhsComponents = [rhs.major, rhs.minor, rhs.patch]

        for (l, r) in zip(lhsComponents, rhsComponents) where l != r {
            return (l.compare(r, options: .numeric) == .orderedAscending)
        }

        if lhs.prerelease.count == 0 { return false }
        if rhs.prerelease.count == 0 { return true }

        for (l, r) in zip(lhs.prerelease, rhs.prerelease) {
            
            switch (l.isNumber, r.isNumber) {
            case (true, true):
                
                let result = l.compare(r, options: .numeric)
                if result == .orderedSame { continue }
                return result == .orderedAscending
                
            case (true, false): return true
            case (false, true): return false
            default:
                
                if l == r { continue }
                return (l < r)
                
            }
            
        }

        return (lhs.prerelease.count < rhs.prerelease.count)
        
    }
    
    internal func isRequiredComponentsEqual(to other: Version) -> Bool {
        
        return self.major == other.major &&
            self.minor == other.minor &&
            self.patch == other.patch
        
    }
        
}

extension Version: ExpressibleByStringLiteral,
                   ExpressibleByFloatLiteral,
                   ExpressibleByIntegerLiteral {
    
    public init(stringLiteral value: StringLiteralType) {
        self = (try? Version(value)) ?? .invalid
    }
    
    public init(floatLiteral value: FloatLiteralType) {
        self = (try? Version(value)) ?? .invalid
    }
    
    public init(integerLiteral value: IntegerLiteralType) {
        self = (try? Version(value)) ?? .invalid
    }
    
}

extension Version: CustomStringConvertible {
    
    public var description: String {
        return asString(format: .full)
    }
    
}
