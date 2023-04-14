//
//  TriggerPublisher.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// A wrapped publisher that only outputs `Void` values.
public class TriggerPublisher {
    
    private let subject = GuaranteePassthroughSubject<Void>()
    
    /// Initializes a new `TriggerPublisher`.
    public init() {
        //
    }
    
    /// Sends an event to subscribers.
    public func send() {
        self.subject.send(())
    }
    
    /// Wraps the publisher with a type eraser.
    /// - returns: An ``AnyPublisher`` wrapping this publisher.
    public func eraseToAnyPublisher() -> AnyPublisher<Void, Never> {
        return self.subject.eraseToAnyPublisher()
    }

}

