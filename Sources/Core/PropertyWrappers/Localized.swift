//
//  Localized.swift
//  Espresso
//
//  Created by Mitch Treece on 3/6/24.
//

import Foundation
import Combine

/// Localization property-wrapper that replaces
/// a string-key with a localized value.
@propertyWrapper
public struct Localized {
    
    private var key: String
    private var value: String!
    
    /// A localized value publisher.
    public var valuePublisher: AnyPublisher<String, Never> {
        return self._valuePublisher.eraseToAnyPublisher()
    }
    
    /// The wrapped localized value.
    public var wrappedValue: String {
        get { self.value }
        set {
            self.key = newValue
            update()
        }
    }
    
    private let _valuePublisher = PassthroughSubject<String, Never>()
    
    /// Initializes the property-wrapper with a
    /// localization string-key.
    ///
    /// - parameter wrappedValue: The string-key to use
    /// when looking up a localized value.
    public init(wrappedValue: String) {
        
        self.key = wrappedValue
        
        update()
        
    }
    
    // MARK: Private
    
    private mutating func update() {
        
        self.value = String(
            localized: .init(self.key)
        )
        
        self._valuePublisher
            .send(self.value)
        
    }
    
}
