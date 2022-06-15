//
//  Version.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

/// Representation of a semantic version (SemVer) number.
/// - SeeAlso: https://semver.org
/// - SeeAlso: https://github.com/mxcl/Version
public struct Version {
    
    public enum Component {
        
        case major
        case minor
        case patch
        case prerelease
        case metadata
        
    }
    
    public let major: UInt
    public let minor: UInt
    public let patch: UInt
    public let prerelease: [String]
    public let metadata: [String]
    
    public static let min = Version(0, 0, 1)
    public static let max = Version(999, 999, 999)
    public static let invalid = Version(0, 0, 0)
    
    public init(major: UInt,
                minor: UInt,
                patch: UInt,
                prerelease: [String] = [],
                metadata: [String] = []) {
        
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
            major: major,
            minor: minor,
            patch: patch,
            prerelease: prerelease,
            metadata: metadata
        )
        
    }
    
    /// Parses the string as a SemVer and returns the result.
    ///
    /// - Parameter version: a string to parse.
    /// - Throws: throw `ParsingError` if the string is not a valid representation of a semantic version.
    public init(_ string: String) throws {
        self = try VersionParser.parse(string)
    }

    /// Parses the number as a SemVer and returns the result.
    ///
    /// - Parameter version: a numeric object to parse.
    /// - Throws: throw `ParsingError` if the numeric object is not a valid representation of a semantic version.
    public init<T: Numeric>(_ number: T) throws {
        self = try VersionParser.parse("\(number)")
    }
    
}

//extension Version: LosslessStringConvertible {
//    
//    public var description: String {
//        
//        var desc = "\(self.major).\(self.minor).\(self.patch)"
//        
//        if !self.prerelease.isEmpty {
//            desc += "-" + self.prerelease.joined(separator: ".")
//        }
//        
//        if !self.metadata.isEmpty {
//            desc += "+" + self.metadata.joined(separator: ".")
//        }
//        
//        return desc
//        
//    }
//    
//    private func identifiers(in string: String,
//                             start: String.Index?,
//                             end: String.Index) -> [String] {
//        
//        guard let start = start else { return [] }
//        let identifiers = string[string.index(after: start)..<end]
//        
//        return identifiers
//            .split(separator: ".")
//            .map { String($0) }
//        
//    }
//    
//    public init?(_ description: String) {
//        
//        #if compiler(>=5)
//        
//        self.init(internal: description)
//        
//        #else
//                
//        func identifiers(start: String.Index?,
//                         end: String.Index) -> [String] {
//            
//            guard let start = start else { return [] }
//            let identifiers = string[string.index(after: start)..<end]
//            
//            return identifiers
//                .split(separator: ".")
//                .map(String.init(_:))
//            
//        }
//        
//        let prereleaseStartIndex = string.firstIndex(of: "-")
//        let metadataStartIndex = string.firstIndex(of: "+")
//
//        let requiredEndIndex = prereleaseStartIndex ?? metadataStartIndex ?? string.endIndex
//        let requiredCharacters = string.prefix(upTo: requiredEndIndex)
//        
//        let requiredComponents = requiredCharacters
//            .split(
//                separator: ".",
//                maxSplits: 2,
//                omittingEmptySubsequences: false
//            )
//            .compactMap { UInt($0) }
//
//        guard requiredComponents.count == 3 else { return nil }
//
//        self.major = requiredComponents[0]
//        self.minor = requiredComponents[1]
//        self.patch = requiredComponents[2]
//
//        self.prerelease = identifiers(
//            start: prereleaseStartIndex,
//            end: metadataStartIndex ?? string.endIndex
//        )
//        
//        self.metadata = identifiers(
//            start: metadataStartIndex,
//            end: string.endIndex
//        )
//        
//        #endif
//        
//    }
//    
//    #if compiler(>=5)
//    
//    public init?<S: StringProtocol>(_ string: S) {
//        self.init(internal: string)
//    }
//
//    private init?<S: StringProtocol>(internal string: S) {
//                
//        func identifiers(start: String.Index?,
//                         end: String.Index) -> [String] {
//            
//            guard let start = start else { return [] }
//            let identifiers = string[string.index(after: start)..<end]
//            
//            return identifiers
//                .split(separator: ".")
//                .map(String.init(_:))
//            
//        }
//        
//        let prereleaseStartIndex = string.firstIndex(of: "-")
//        let metadataStartIndex = string.firstIndex(of: "+")
//
//        let requiredEndIndex = prereleaseStartIndex ?? metadataStartIndex ?? string.endIndex
//        let requiredCharacters = string.prefix(upTo: requiredEndIndex)
//        
//        let requiredComponents = requiredCharacters
//            .split(
//                separator: ".",
//                maxSplits: 2,
//                omittingEmptySubsequences: false
//            )
//            .compactMap { UInt($0) }
//
//        guard requiredComponents.count == 3 else { return nil }
//
//        self.major = requiredComponents[0]
//        self.minor = requiredComponents[1]
//        self.patch = requiredComponents[2]
//
//        self.prerelease = identifiers(
//            start: prereleaseStartIndex,
//            end: metadataStartIndex ?? string.endIndex
//        )
//        
//        self.metadata = identifiers(
//            start: metadataStartIndex,
//            end: string.endIndex
//        )
//        
//    }
//    
//    #endif
//    
//}

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

//public extension Version {
//
//    /**
//     Creates a version object.
//     - Remark: This initializer variant uses a more tolerant parser, eg. `10.1` parses to `Version(10,1,0)`.
//     - Remark: This initializer will not recognizer builds-metadata-identifiers.
//     - Remark: Tolerates an initial `v` character.
//     */
//    init?<S: StringProtocol>(tolerant: S) {
//
//        let string = tolerant.dropFirst(tolerant.first == "v" ? 1 : 0)
//        let prereleaseStartIndex = string.firstIndex(of: "-")
//        let requiredEndIndex = prereleaseStartIndex ?? string.endIndex
//        let requiredCharacters = string.prefix(upTo: requiredEndIndex)
//
//        let maybes = requiredCharacters.split(
//            separator: ".",
//            maxSplits: 2,
//            omittingEmptySubsequences: false
//        )
//        .map { UInt($0) }
//
//        guard !maybes.contains(nil), 1...3 ~= maybes.count else { return nil }
//
//        var requiredComponents = maybes.map{ $0! }
//
//        while requiredComponents.count < 3 {
//            requiredComponents.append(0)
//        }
//
//        self.major = requiredComponents[0]
//        self.minor = requiredComponents[1]
//        self.patch = requiredComponents[2]
//
//        if let prereleaseStartIndex = prereleaseStartIndex {
//
//            let identifiers = string[string.index(after: prereleaseStartIndex)..<string.endIndex]
//            self.prerelease = identifiers
//                .split(separator: ".")
//                .map { String($0) }
//
//        }
//        else {
//            self.prerelease = []
//        }
//
//        self.metadata = []
//
//    }
//
//}

extension Version: Hashable {
    
    public func hash(into hasher: inout Hasher) {
        
        hasher.combine(self.major)
        hasher.combine(self.minor)
        hasher.combine(self.patch)
        hasher.combine(self.prerelease)
        
    }
    
}

extension Version: Equatable {
    
    public static func == (lhs: Version, rhs: Version) -> Bool {
        
        return lhs.major == rhs.major &&
            lhs.minor == rhs.minor &&
            lhs.patch == rhs.patch &&
            lhs.prerelease == rhs.prerelease
        
    }
    
}

extension Version: Comparable {
    
    func isRequiredComponenetsEqual(to other: Version) -> Bool {
        
        return self.major == other.major &&
            self.minor == other.minor &&
            self.patch == other.patch
        
    }
    
    public static func < (lhs: Version, rhs: Version) -> Bool {
        
        // 1.0.0 < 1.0.1
        // 1.0.1-beta < 1.0.1
        // 1.0.1-beta > 1.0.0
        // build metadata doesn't factor into comparison at all

        let lhsComparators = [lhs.major, lhs.minor, lhs.patch]
        let rhsComparators = [rhs.major, rhs.minor, rhs.patch]

        if lhsComparators != rhsComparators {
            return lhsComparators.lexicographicallyPrecedes(rhsComparators)
        }

        guard !lhs.prerelease.isEmpty else {
                        
            // no lhs prerelease >= any rhs prerelease
            return false
            
        }

        guard !rhs.prerelease.isEmpty else {
            
            // lhs prerelease < no rhs prerelease
            return true
            
        }

        let zippedPrereleases = zip(lhs.prerelease, rhs.prerelease)
        
        for (lhsPrereleaseComponent, rhsPrereleaseComponent) in zippedPrereleases {
            
            guard lhsPrereleaseComponent != rhsPrereleaseComponent else { continue }
            
            let lhsTypedComponent: Any = Int(lhsPrereleaseComponent) ?? lhsPrereleaseComponent
            let rhsTypedComponent: Any = Int(rhsPrereleaseComponent) ?? rhsPrereleaseComponent

            switch (lhsTypedComponent, rhsTypedComponent) {
            case let (int1 as Int, int2 as Int): return int1 < int2
            case let (string1 as String, string2 as String): return string1 < string2
            case (is Int, is String): return true // Int prerelease < String prerelease
            case (is String, is Int): return false
            default:
                
                // This shouldn't happen
                return false
                
            }
            
        }

        return lhs.prerelease.count < rhs.prerelease.count
        
    }
    
}
