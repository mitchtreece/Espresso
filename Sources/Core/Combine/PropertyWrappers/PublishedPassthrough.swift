//
//  PublishedPassthrough.swift
//  Espresso
//
//  Created by Mitch on 1/10/25.
//

import Combine

/// Property wrapper that internally publishes values
/// using a `PassthroughSubject`, and externally exposes
/// a read-only `AnyPublisher`.
///
/// ```swift
/// @PublishedPassthrough<Int, Never> var publisher
///
/// publisher.sink { print("Number: \($0)") }
/// _publisher.send(23)
///
/// // → "Number: 23"
/// ```
@propertyWrapper
public final class PublishedPassthrough<T, E: Error> {
    
    private let subject = PassthroughSubject<T, E>()
    
    /// The wrapped read-only publisher.
    public var wrappedValue: AnyPublisher<T, E> {
        return self.subject.eraseToAnyPublisher()
    }
    
    /// Initializes the property wrapper.
    public init() {}
    
    /// Sends a value to subscribers.
    public func send(_ value: T) {
        self.subject.send(value)
    }
    
}
