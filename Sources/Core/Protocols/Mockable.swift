//
//  Mockable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/26/22.
//

import Foundation

/// Protocol that describes something that can be represented using mock data.
public protocol Mockable {

    /// Creates a mock value.
    static func mock() -> Self
    
}

public extension Mockable {
    
    /// Creates a mock value array.
    ///
    /// - parameter count: The number of mock values.
    /// - returns: An array of mock values.
    static func mocks(count: Int = 5) -> [Self] {
        
        var mocks = [Self]()
        
        for _ in 0..<count {
            mocks.append(.mock())
        }
        
        return mocks
        
    }
    
}
