//
//  Scanner+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

public extension Scanner {

    func scanUpToCharacters(from characterSet: CharacterSet) -> String? {
        
        var str: NSString?
        
        scanUpToCharacters(
            from: characterSet,
            into: &str
        )
        
        return str as String?
        
    }

    func scanCharacters(from characterSet: CharacterSet) -> String? {
        
        var str: NSString?
        
        scanCharacters(
            from: characterSet,
            into: &str
        )
        
        return str as String?
        
    }
    
}
