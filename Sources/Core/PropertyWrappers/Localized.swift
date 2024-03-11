//
//  Localized.swift
//  Espresso
//
//  Created by Mitch Treece on 3/6/24.
//

import Foundation

/// Marks a string as being backed by a localization table.
///
/// The value of the wrapped string is used as it's localization key. i.e.
/// ```
/// @Localized var title: String = "TITLE_KEY"
/// "TITLE_KEY" → "My Localized Title"
/// ```
@propertyWrapper
public struct Localized {

    private var key: String
    private var value: String!
    
    private let _valuePublisher = GuaranteePassthroughSubject<String>()
    public var valuePublisher: GuaranteePublisher<String> {
        return self._valuePublisher.eraseToAnyPublisher()
    }
    
    public var wrappedValue: String {
        get { self.value }
        set {
            self.key = newValue
            updateValue()
        }
    }
    
    public init(wrappedValue: String) {
        
        self.key = wrappedValue
        
        updateValue()
        
    }
    
    // MARK: Private
    
    private mutating func updateValue() {
        
        self.value = String(
            localized: .init(self.key)
        )
        
        self._valuePublisher
            .send(self.value)
        
    }
    
}
