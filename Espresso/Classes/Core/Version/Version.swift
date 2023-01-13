//
//  Version.swift
//  Espresso
//
//  Created by Mitch Treece on 6/13/22.
//

import Foundation

/// Representation of a semantic version (SemVer) number.
public struct Version {
    
    /// Representation of the various semantic version components.
    public enum Component: String {
        
        /// A major version component.
        case major
        
        /// A minor version component.
        case minor
        
        /// A patch (revision) version component.
        case patch
        
        /// A pre-release version component.
        case prerelease
        
        /// A (build) metadata version component.
        case metadata
        
    }
    
    /// Representation of the various string-formats a version can be represented as.
    public enum StringFormat {
        
        /// A compact string format.
        ///
        /// `{major}.{minor}.{patch}`
        ///
        /// ```
        /// "1.2.3"
        /// ```
        case compact
        
        /// An expanded string format.
        ///
        /// `{major}.{minor}.{patch}-{prerelease?}`
        ///
        /// ```
        /// "1.2.3"
        /// "1.2.3-beta"
        /// "1.2.3-rc.1"
        /// ```
        case expanded
        
        /// A full string format.
        ///
        /// `{major}.{minor}.{patch}-{prerelease?}+{metadata?}`
        ///
        ///
        /// ```
        /// "1.2.3"
        /// "1.2.3-beta"
        /// "1.2.3-rc.1"
        /// "1.2.3-beta+20220615"
        /// "1.2.3-rc.1+20220615.mitchtreece"
        /// ```
        case full
        
    }
    
    /// Representation of the various version errors.
    public enum Error: Swift.Error {

        /// An invalid string error.
        case invalidString(String, Swift.Error?)
        
        /// A digits-not-found error.
        case digitsNotFound(String)
        
        /// A parsing error.
        case parsing(Version.Component, Swift.Error)

        var localizedDescription: String {

            switch self {
            case .invalidString(let version, let error):

                return "invalid \"\(version)\"\t\(error.map { "\nInfo)" + $0.localizedDescription } ?? "")"

            case .digitsNotFound(let version):

                return "\"\(version)\" doesn't contain any digits"

            case .parsing(let component, let error):

                return "error parsing component \"\(component.rawValue)\": \(error.localizedDescription)"

            }

        }

    }
    
    /// The version's major component.
    public let major: UInt
    
    /// The version's minor component.
    public let minor: UInt
    
    /// The version's patch (revision) component.
    public let patch: UInt
    
    /// The version's pre-release identifiers component.
    public let prerelease: [String]
    
    
    /// The version's (build) metadata component.
    public let metadata: [String]
        
    /// An invalid-value version.
    ///
    /// `0.0.0`
    public static let invalid = Version(0, 0, 0)
    
    /// A minimum-value version.
    ///
    /// `0.0.1`
    public static let min = Version(0, 0, 1)
    
    /// A maximum-value version.
    ///
    /// `999.999.999`
    public static let max = Version(999, 999, 999)
    
    internal static let dotDelimiter = "."
    internal static let prereleaseDelimiter = "-"
    internal static let metadataDelimiter = "+"

    /// Initializes a version with major, minor, patch,
    /// and optional pre-release & (build) metadata identifiers.
    /// - parameter major: The major version.
    /// - parameter minor: The minor version.
    /// - parameter patch: The patch (revision) version.
    /// - parameter prerelease: Optional prerelease identifiers; _defaults to none_.
    /// - parameter metadata: Optional (build) metadata identifiers; _defaults to none_.
    /// - returns: A version instance.
    public init(_ major: UInt,
                _ minor: UInt,
                _ patch: UInt,
                prerelease: [String] = [],
                metadata: [String] = []) {
        
        self.major = major
        self.minor = minor
        self.patch = patch
        self.prerelease = prerelease
        self.metadata = metadata
        
    }
    
    /// Initializes a version using a string.
    /// - parameter string: The version string.
    /// - throws: A `Version.Error` if the string is not a valid representation of a semantic version.
    ///
    /// ```
    /// "1" => "1.0.0"
    /// "1.2" => "1.2.0"
    /// "1.34.0" => "1.34.0"
    /// "1.0-beta.1+20220615" => "1.0.0-beta.1+20220615"
    /// ```
    public init(_ string: String) throws {
        self = try VersionParser.parse(string)
    }
    
    /// Initializes a version using a number.
    /// - parameter number: The version number.
    /// - throws: A `Version.Error` if the number is not a valid representation of a semantic version.
    ///
    /// ```
    /// 1 => "1.0.0"
    /// 1.2 => "1.2.0"
    /// 1.34 => "1.34.0"
    /// ```
    public init<T: Numeric>(_ number: T) throws {
        self = try VersionParser.parse("\(number)")
    }

    /// Returns a string representation of the `Version`.
    ///
    /// - Parameter format: Specifies string representation Style; _defaults to full.
    /// - Returns: a string representation of the Version.
    public func asString(format: StringFormat = .full) -> String {
        
        let version = [
            String(self.major),
            String(self.minor),
            String(self.patch)
        ]
        .joined(separator: Self.dotDelimiter)
        
        let prerelease = self.prerelease
            .joined(separator: Self.dotDelimiter)
        
        let metadata = self.metadata
            .joined(separator: Self.dotDelimiter)
        
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
        
        let isMajorEqual = (lhs.major == rhs.major)
        let isMinorEqual = (lhs.minor == rhs.minor)
        let isPatchEqual = (lhs.patch == rhs.patch)
        
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
            return (l < r)
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
