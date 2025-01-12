//
//  PublishedTrigger.swift
//  Espresso
//
//  Created by Mitch on 1/12/25.
//

import Combine

/// Property wrapper that internally publishes values
/// using a `TriggerPublisher`, and externally exposes
/// a read-only `AnyPublisher`.
///
/// ```swift
/// @PublishedTrigger var publisher
///
/// publisher.sink { print("Received event") }
/// _publisher.send()
///
/// // → "Received event"
/// ```
@propertyWrapper
public final class PublishedTrigger {
    
    private let trigger = TriggerPublisher()

    /// The wrapped read-only publisher.
    public var wrappedValue: AnyPublisher<Void, Never> {
        return self.trigger.eraseToAnyPublisher()
    }
    
    /// Initializes the property wrapper.
    public init() {}
    
    /// Sends an event to subscribers.
    public func send() {
        self.trigger.send()
    }
    
}
