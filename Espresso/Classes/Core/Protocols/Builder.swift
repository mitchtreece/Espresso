//
//  Builder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import Foundation

public protocol Builder {
    
    associatedtype BuildType
    
    func build() -> BuildType
    
}
