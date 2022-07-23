//
//  Event+Combine.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

public extension Event /* Combine */ {
    
    /// The event as a publisher.
    /// - returns: An `Event` publisher.
    func asPublisher() -> GuaranteePublisher<V> {
        
        return CombineEvent(event: self)
            .asPublisher()
        
    }
    
}

public extension VoidEvent /* Combine */ {
    
    /// The event as an observable.
    /// - returns: A `VoidEvent` publisher.
    func asPublisher() -> GuaranteePublisher<Void> {

        return CombineVoidEvent(event: self)
            .asPublisher()

    }
    
}

private class CombineEvent<V> {
    
    private let event: Event<V>
    private let subject = GuaranteePassthroughSubject<V>()
    
    init(event: Event<V>) {
        
        self.event = event
        
        self.event.addObserver { v in
            self.subject.send(v)
        }
        
    }
    
    func asPublisher() -> GuaranteePublisher<V> {
        return self.subject.eraseToAnyPublisher()
    }
    
}

private class CombineVoidEvent {
    
    private let event: VoidEvent
    private let subject = GuaranteePassthroughSubject<Void>()
    
    init(event: VoidEvent) {
        
        self.event = event
        
        self.event.addObserver {
            self.subject.send(())
        }
        
    }
    
    func asPublisher() -> GuaranteePublisher<Void> {
        return self.subject.eraseToAnyPublisher()
    }
    
}
