//
//  TriggerPublisher.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

/// A type-erased publisher that sends events to subscribers.
public typealias AnyTriggerPublisher = GuaranteeVoidPublisher

/// A publisher that sends events to subscribers.
public class TriggerPublisher {
    
    private let subject = GuaranteePassthroughSubject<Void>()
    
    /// Initializes a new `TriggerPublisher`.
    public init() {}
    
    /// Sends an event to subscribers.
    public func send() {
        self.subject.send(())
    }
    
    /// Wraps the publisher with a type eraser.
    /// - returns: An ``AnyPublisher`` wrapping this publisher.
    public func eraseToAnyPublisher() -> GuaranteeVoidPublisher {
        return self.subject.eraseToAnyPublisher()
    }
    
    /// Wraps the publisher with a type eraser.
    /// - returns: An ``AnyPublisher`` wrapping this publisher.
    public func asAny() -> GuaranteeVoidPublisher {
        return eraseToAnyPublisher()
    }

}

