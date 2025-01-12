//
//  PublishedGuaranteeValue.swift
//  Espresso
//
//  Created by Mitch on 1/10/25.
//

import Combine

/// Property wrapper that internally publishes values
/// using a `GuaranteeValueSubject`, and externally exposes
/// a read-only `AnyPublisher`.
///
/// ```swift
/// @PublishedGuaranteeValue<Int>(0) var publisher
///
/// publisher.sink { print("Number: \($0)") }
/// _publisher.send(23)
///
/// // → "Number: 0"
/// // → "Number: 23"
/// ```
@propertyWrapper
public final class PublishedGuaranteeValue<T> {
    
    private let subject: GuaranteeValueSubject<T>

    /// The wrapped subject's value.
    ///
    /// - Note: Assigning a value through this property is the same as calling `send`.
    public var value: T {
        get { self.subject.value }
        set { send(newValue) }
    }
    
    /// The wrapped read-only publisher.
    public var wrappedValue: AnyPublisher<T, Never> {
        return self.subject.eraseToAnyPublisher()
    }
    
    /// Initializes the property wrapper.
    /// - property value: The initial value to give to the underlying subject.
    public init(_ value: T) {
        self.subject = GuaranteeValueSubject(value)
    }
    
    /// Sends a value to subscribers.
    public func send(_ value: T) {
        self.subject.send(value)
    }
    
}
