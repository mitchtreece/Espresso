//
//  IndexPath+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

public extension IndexPath {
    
    /// A zero-based index path.
    static var zero: IndexPath {
        
        #if os(iOS)
        return IndexPath(row: 0, section: 0)
        #else
        return IndexPath(item: 0, section: 0)
        #endif
        
    }
    
}
