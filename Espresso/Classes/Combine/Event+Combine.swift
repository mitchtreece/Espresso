//
//  Event+Combine.swift
//  Espresso
//
//  Created by Mitch Treece on 4/13/22.
//

import Combine

@available(iOS 13, *)
public extension Event /* Combine */ {
    
    /// The event as a publisher.
    /// - returns: An `Event` publisher.
    func asPublisher() -> AnyPublisher<V, Never> {
        
        return CombineEvent(event: self)
            .asPublisher()
        
    }
    
}

@available(iOS 13, *)
public extension VoidEvent /* Combine */ {
    
    /// The event as an observable.
    /// - returns: A `VoidEvent` publisher.
    func asPublisher() -> AnyPublisher<Void, Never> {

        return CombineVoidEvent(event: self)
            .asPublisher()

    }
    
}

@available(iOS 13, *)
private class CombineEvent<V> {
    
    private let event: Event<V>
    private let subject = PassthroughSubject<V, Never>()
    
    init(event: Event<V>) {
        
        self.event = event
        
        self.event.addObserver { v in
            self.subject.send(v)
        }
        
    }
    
    func asPublisher() -> AnyPublisher<V, Never> {
        return self.subject.eraseToAnyPublisher()
    }
    
}

@available(iOS 13, *)
private class CombineVoidEvent {
    
    private let event: VoidEvent
    private let subject = PassthroughSubject<Void, Never>()
    
    init(event: VoidEvent) {
        
        self.event = event
        
        self.event.addObserver {
            self.subject.send(())
        }
        
    }
    
    func asPublisher() -> AnyPublisher<Void, Never> {
        return self.subject.eraseToAnyPublisher()
    }
    
}
