//
//  DynamicValue.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import Foundation

public struct DynamicValue<T> {
    
    public var value: T?
    public let placeholder: T?
    public let `default`: T
    
    public init(value: T? = nil,
                placeholder: T? = nil,
                `default`: T) {
        
        self.value = value
        self.placeholder = placeholder
        self.default = `default`
        
    }
    
    public func value(placeholder: Bool = false) -> T {
        
        return placeholder ?
            self.placeholder ?? self.default :
            self.value ?? self.default
        
    }
    
}
