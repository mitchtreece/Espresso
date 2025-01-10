//
//  PublishedValue.swift
//  Espresso
//
//  Created by Mitch on 1/10/25.
//

import Combine

/// Property wrapper that internally publishes values
/// using a `CurrentValueSubject`, and externally exposes
/// a read-only `AnyPublisher`.
///
/// ```swift
/// @PublishedValue<Int, Never>(0) var publisher
///
/// publisher.sink { print("Number: \($0)") }
/// _publisher.send(23)
///
/// // → "Number: 0"
/// // → "Number: 23"
/// ```
@propertyWrapper
public final class PublishedValue<T, E: Error> {
    
    private let subject: CurrentValueSubject<T, E>
    
    /// The wrapped read-only publisher.
    public var wrappedValue: AnyPublisher<T, E> {
        return self.subject.eraseToAnyPublisher()
    }
    
    /// Initializes the property wrapper.
    /// - property value: The initial value to give to the underlying subject.
    public init(_ value: T) {
        self.subject = CurrentValueSubject(value)
    }
    
    /// Sends a value to subscribers.
    public func send(_ value: T) {
        self.subject.send(value)
    }
    
}
