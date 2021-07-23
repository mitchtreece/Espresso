//
//  Event+Rx.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import RxSwift
import RxCocoa

private class RxEvent<V> {
    
    private let event: Event<V>
    private let subject = PublishSubject<V>()
    
    init(event: Event<V>) {
        
        self.event = event
        
        self.event.addObserver { v in
            self.subject.onNext(v)
        }
        
    }
    
    func asObservable() -> Observable<V> {
        return self.subject.asObservable()
    }
    
}

private class RxVoidEvent {
    
    private let event: VoidEvent
    private let subject = PublishSubject<Void>()
    
    init(event: VoidEvent) {
        
        self.event = event
        
        self.event.addObserver {
            self.subject.onNext(())
        }
        
    }
    
    func asObservable() -> Observable<Void> {
        return self.subject.asObservable()
    }
    
}

public extension Event /* Rx */ {
    
    /// Returns the event as an observable.
    /// - returns: An observable.
    func asObservable() -> Observable<V> {
        
        return RxEvent<V>(event: self)
            .asObservable()
        
    }
    
}

public extension VoidEvent /* Rx */ {
    
    /// Returns the event as an observable.
    /// - returns: An observable.
    func asObservable() -> Observable<Void> {
        
        return RxVoidEvent(event: self)
            .asObservable()
        
    }
    
}
