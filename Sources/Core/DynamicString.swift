//
//  DynamicString.swift
//  Espresso
//
//  Created by Mitch Treece on 3/6/24.
//

import Foundation

public struct DynamicString {
    
    private var _value: String
    var value: String {
        get { self._value }
        set { self._value = self.isLocalized ? .localized(newValue) : newValue }
    }
    
    public let placeholder: String
    
    private let isLocalized: Bool
    
    public init(_ value: String, 
                placeholder: String = .placeholder(.medium),
                localized: Bool = true) {
        
        self._value = localized ? .localized(value) : value
        self.placeholder = placeholder
        self.isLocalized = localized
        
    }
    
    public func value(placeholder: Bool = false) -> String {
        
        return placeholder ?
            self.placeholder :
            self.value
        
    }
    
}
