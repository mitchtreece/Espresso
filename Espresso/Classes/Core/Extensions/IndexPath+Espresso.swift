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
        return IndexPath(row: 0, section: 0)
    }
    
}
