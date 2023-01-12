//
//  Builder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import Foundation

/// Protocol describing something that builds something else.
public protocol Builder {
    
    associatedtype BuildType
    
    func build() -> BuildType
    
}
