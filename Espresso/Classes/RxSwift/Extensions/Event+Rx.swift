//
//  Event+Rx.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import RxSwift
import RxCocoa

private class RxEvent<T> {
    
    private let event: Event<T>
    private let subject = PublishSubject<T>()
    
    init(event: Event<T>) {
        
        self.event = event
        self.event.addObserver { v in
            self.subject.onNext(v)
        }
        
    }
    
    func asObservable() -> Observable<T> {
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
    
    /// The event's `Observable` representation.
    func asObservable() -> Observable<T> {
        return RxEvent<T>(event: self).asObservable()
    }
    
}

public extension VoidEvent /* Rx */ {
    
    /// The event's `Observable` representation.
    func asObservable() -> Observable<Void> {
        return RxVoidEvent(event: self).asObservable()
    }
    
}
