//
//  Version.swift
//  Espresso
//
//  Created by Mitch Treece on 6/13/22.
//

import Foundation

public struct Version {
    
    public enum Component {
        
        case major
        case minor
        case patch
        case prereleaseIdentifiers
        case buildIdentifiers
        
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
        /// `{major}.{minor}.{patch}-{prerelease}+{build}`
        ///
        /// `1.2.3-rc.1+SHA.a0f21`
        case full
        
    }
    
    public let major: String
    public let minor: String
    public let patch: String
    public let prereleaseIdentifiers: [String]
    public let buildIdentifiers: [String]
        
    public static var invalid: Version {
        
        return Version(
            major: 0,
            minor: 0,
            patch: 0
        )
        
    }
    
    public static var min: Version {
        
        return Version(
            major: 0,
            minor: 0,
            patch: 1
        )
        
    }
    
    public static var max: Version {
        
        return Version(
            major: 999,
            minor: 999,
            patch: 999
        )
        
    }
    
    internal init(major: String,
                  minor: String,
                  patch: String,
                  prereleaseIdentifiers: [String],
                  buildIdentifiers: [String]) {
        
        self.major = major
        self.minor = minor
        self.patch = patch
        self.prereleaseIdentifiers = prereleaseIdentifiers
        self.buildIdentifiers = buildIdentifiers
        
    }
    
    public init(major: UInt = 0,
                minor: UInt = 0,
                patch: UInt = 0,
                prereleaseIdentifiers: [String] = [],
                buildIdentifiers: [String] = []) {
        
        self.init(
            major: "\(major)",
            minor: "\(minor)",
            patch: "\(patch)",
            prereleaseIdentifiers: prereleaseIdentifiers,
            buildIdentifiers: buildIdentifiers
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
        
        let version = [self.major, self.minor, self.patch].joined(separator: VersionParser.dotDelimiter)
        let prerelease = self.prereleaseIdentifiers.joined(separator: VersionParser.dotDelimiter)
        let build = self.buildIdentifiers.joined(separator: VersionParser.dotDelimiter)
        
        switch format {
        case .compact: return version
        case .expanded:
            
            return version
                + (prerelease.count > 0 ? "\(VersionParser.prereleaseDelimiter)\(prerelease)" : "")
            
        case .full:
            
            return version
                + (prerelease.count > 0 ? "\(VersionParser.prereleaseDelimiter)\(prerelease)" : "")
                + (build.count > 0 ? "\(VersionParser.buildDelimiter)\(build)" : "")
            
        }
        
    }
    
}

extension Version: Comparable {
    
    public static func == (lhs: Version, rhs: Version) -> Bool {
        
        let isMajorEqual = (lhs.major.compare(rhs.major, options: .numeric) == .orderedSame)
        let isMinorEqual = (lhs.minor.compare(rhs.minor, options: .numeric) == .orderedSame)
        let isPatchEqual = (lhs.patch.compare(rhs.patch, options: .numeric) == .orderedSame)
        
        let isPrereleaseCountEqual = (lhs.prereleaseIdentifiers.count == rhs.prereleaseIdentifiers.count)
        let isPrereleaseIdentifiersEqual = zip(
            lhs.prereleaseIdentifiers,
            rhs.prereleaseIdentifiers
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

        if lhs.prereleaseIdentifiers.count == 0 { return false }
        if rhs.prereleaseIdentifiers.count == 0 { return true }

        for (l, r) in zip(lhs.prereleaseIdentifiers, rhs.prereleaseIdentifiers) {
            
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

        return (lhs.prereleaseIdentifiers.count < rhs.prereleaseIdentifiers.count)
        
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
