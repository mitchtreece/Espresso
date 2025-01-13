//
//  PublishedReadOnlyTrigger.swift
//  Espresso
//
//  Created by Mitch on 1/12/25.
//

import Combine

/// Property wrapper that internally publishes values
/// using a ``TriggerPublisher``, and externally exposes
/// a read-only ``AnyPublisher``.
///
/// ```swift
/// @PublishedReadOnlyTrigger var trigger
///
/// trigger.sink { _ in
///     print("Received event")
/// }
///
/// _trigger.send()
///
/// // → "Received event"
/// ```
@propertyWrapper
public final class PublishedReadOnlyTrigger {

    private let subject = TriggerPublisher()

    /// The wrapped read-only publisher.
    public var wrappedValue: GuaranteeVoidPublisher {
        return self.subject.eraseToAnyPublisher()
    }

    /// Initializes the property wrapper.
    public init() {}

    /// Sends an event to subscribers.
    public func send() {
        self.subject.send()
    }

}
