//
//  String+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

public extension String /* Empty */ {
    
    /// An empty string value.
    static let empty: String = ""
    
}

public extension Optional where Wrapped == String {
    
    /// Flag indicating if the optional string is `nil` or empty.
    /// - returns: `Bool` indicating if the string is `nil` or empty.
    var isNilOrEmpty: Bool {
        return self?.isEmpty ?? true
    }
    
    /// Flag indicating if the optional string is not `nil` or empty.
    /// - returns: `Bool` indicating if the string is not `nil` or empty.
    var isNotNilOrEmpty: Bool {
        return !self.isNilOrEmpty
    }
    
}

public extension String /* Size */ {
    
    /// Calculates the display size for the string using a constraint & attributes.
    /// - Parameter size: The constrained size.
    /// - Parameter attributes: The string attributes to use while calculating the size.
    /// - Returns: The string's display size.
    func size(constrainedTo size: CGSize, attributes: [NSAttributedString.Key: Any]?) -> CGSize {
        
        return (self as NSString).boundingRect(
            with: size,
            options: [.usesLineFragmentOrigin],
            attributes: attributes,
            context: nil
        )
        .size
        
    }
    
    /// Calculates the display width for the string using a constrained height & attributes.
    /// - Parameter height: The constrained height.
    /// - Parameter attributes: The string attributes to use while calculating the width.
    /// - Returns: The string's display width.
    func width(forHeight height: CGFloat, attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
        
        let constraint = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
        return size(constrainedTo: constraint, attributes: attributes).width
        
    }
    
    /// Calculates the display width for the string using a constrained height & font.
    /// - Parameter height: The constrained height.
    /// - Parameter font: The font to use while calculating the width.
    /// - Returns: The string's display width.
    func width(forHeight height: CGFloat, font: UIFont) -> CGFloat {
        return width(forHeight: height, attributes: [.font: font])
    }
    
    /// Calculates the display height for the string using a constrained width & attributes.
    /// - Parameter width: The constrained width.
    /// - Parameter attributes: The string attributes to use while calculating the height.
    /// - Returns: The string's display height.
    func height(forWidth width: CGFloat, attributes: [NSAttributedString.Key: Any]?) -> CGFloat {
        
        let constraint = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return size(constrainedTo: constraint, attributes: attributes).height
        
    }
    
    /// Calculates the display height for the string using a constrained width & font.
    /// - Parameter width: The constrained width.
    /// - Parameter font: The font to use while calculating the height.
    /// - Returns: The string's display height.
    func height(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        return height(forWidth: width, attributes: [.font: font])
    }
    
}

public extension String /* Tokens */ {
    
    /// Creates a new string by replacing all occurrences of a **\<token\>** with another string.
    /// - Parameter token: The token to replace.
    /// - Parameter string: The replacement string.
    /// - Returns: A new string with all token occurrences replaced.
    func replacing(token: String, with string: String) -> String {
        
        let _token = (token.first == "<" && token.last == ">") ? token : "<\(token)>"
        return self.replacingOccurrences(of: _token, with: string)
        
    }
    
    /// Creates a new string by replacing all occurrences of **\<token\>'s** with their corresponding replacements.
    /// - Parameter tokens: A dictionary map of \<token\>'s to replacement strings.
    /// - Returns: A new string with all token occurrences replaced.
    func replacing(tokens: [String: String]) -> String {
        
        var string = self
        
        for (key, value) in tokens {
            
            let token = (key.first == "<" && key.last == ">") ? key : "<\(key)>"
            string = string.replacing(token: token, with: value)
            
        }
        
        return string
        
    }
    
}

public extension String /* Random */ {
    
    /// Representation of the various string-allowed character types.
    enum CharacterType {
        
        /// A numeric-only character type.
        case numeric
        
        /// An alphabet-only character type.
        case alphabetic
        
        /// An alphanumeric-only character type.
        case alphanumeric
        
        /// A custom set character type.
        case inString(String)
        
        /// The string representation of the character type.
        public var set: String {
            
            let numbers = "0123456789"
            let letters = "abcdefghijklmnopqrstuvwxyz"
            
            switch self {
            case .numeric: return numbers
            case .alphabetic: return (letters + letters.uppercased())
            case .alphanumeric: return (letters + letters.uppercased() + numbers)
            case .inString(let string): return string
            }
            
        }
        
    }
    
    /// Initializes a string with a random length & allowed character type.
    /// - Parameter length: The random string length.
    /// - Parameter allowedCharacters: The allowed character type; _defaults to alphanumeric_.
    init(randomWithLength length: Int, allowedCharacters: CharacterType = .alphanumeric) {
        
        let randomCharacters = (0..<length).compactMap { _ in
            allowedCharacters.set.randomElement()
        }
        
        self.init(randomCharacters)
        
    }
    
}

public extension String /* Number */ {
    
    /// Flag indicating whether the string can be represented as a whole number.
    var isNumber: Bool {
        
        guard let regex = try? NSRegularExpression(pattern: "[0-9]+") else { return false }
        
        return firstMatch(for: regex)
            .map { $0 == self } ?? false
        
    }
    
}

public extension String /* Regex */ {
    
    /// Returns the range of the first match of a regular expression within the string.
    /// - parameter regex: The regular expression.
    /// - returns: The range of the first match. Returns {NSNotFound, 0} if no match is found.
    func rangeOfFirstMatch(for regex: NSRegularExpression) -> NSRange {
        
        return regex.rangeOfFirstMatch(
            in: self,
            range: NSRange(location: 0, length: self.count)
        )
        
    }

    /// Returns the first match of the regular expression within the string.
    /// - parameter regex: The regular expression.
    /// - returns: The first match.
    func firstMatch(for regex: NSRegularExpression) -> String? {
        
        return regex
            .firstMatch(
                in: self,
                range: NSRange(
                    location: 0,
                    length: self.count
                ))
                .map { Range($0.range, in: self)! }
                .map { String(self[$0]) }
        
    }
    
}

public extension String /* Padding */ {
    
    /// Applies padding using a given string & count.
    /// - parameter string: The string to use for padding; _default to " "_.
    /// - parameter count: The number of times to apply padding to the string.
    mutating func pad(using string: String = " ",
                      count: Int) {
        
        self = padding(
            using: string,
            count: count
        )
        
    }
    
    /// Returns a new string by applying padding using a given string & count.
    /// - parameter string: The string to use for padding; _default to " "_.
    /// - parameter count: The number of times to apply padding to the string.
    /// - returns: A padded string.
    func padding(using string: String = " ",
                 count: Int) -> String {
        
        var padding = ""

        for _ in 0..<count {
            padding += string
        }
        
        return "\(padding)\(self)\(padding)"

    }
    
}
