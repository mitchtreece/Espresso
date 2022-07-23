//
//  Scanner+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

public extension Scanner {

    /// Scans the string until a character from a given character set is encountered,
    /// accumulating characters into a string.
    /// - parameter characterSet: The set of characters up to which to scan.
    /// - returns: A string containing the scanned characters.
    func scanUpToCharacters(from characterSet: CharacterSet) -> String? {
        
        var str: NSString?
        
        scanUpToCharacters(
            from: characterSet,
            into: &str
        )
        
        return str as String?
        
    }

    /// Scans the string as long as characters from a given character set are encountered,
    /// accumulating characters into a string.
    /// - parameter characterSet: The set of characters to scan.
    /// - returns: A string containing the scanned characters.
    func scanCharacters(from characterSet: CharacterSet) -> String? {
        
        var str: NSString?
        
        scanCharacters(
            from: characterSet,
            into: &str
        )
        
        return str as String?
        
    }
    
}
