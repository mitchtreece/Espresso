//
//  Result+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import Foundation

public extension Result /* Error */ {
    
    /// The result's error, or `nil`.
    var error: Failure? {
        
        switch self {
        case .failure(let error): return error
        default: return nil
        }
        
    }
    
}
