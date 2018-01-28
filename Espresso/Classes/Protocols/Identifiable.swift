//
//  Identifiable.swift
//  Espresso
//
//  Created by Mitch Treece on 1/27/18.
//

import Foundation

public protocol Identifiable {
    
    var identifier: String { get }
    
}

extension Identifiable {
    
    static var identifier: String {
        return String(describing: self)
    }
    
}
