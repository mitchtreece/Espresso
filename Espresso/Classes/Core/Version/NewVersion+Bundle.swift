//
//  NewVersion+Comparable.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/22.
//

import Foundation

public extension Bundle {
    
    /// The bundle's version.
    var version: Version? {
                
        return (self.infoDictionary?["CFBundleShortVersionString"] as? String)
            .flatMap(Version.init(tolerant:)) ?? .invalid
        
    }
    
}
