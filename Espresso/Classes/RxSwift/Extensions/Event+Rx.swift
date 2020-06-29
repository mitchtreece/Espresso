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
    
    var observable: Observable<V> {
        return self.subject.asObservable()
    }
    
    init(event: Event<V>) {
        
        self.event = event
        self.event.addObserver { v in
            self.subject.onNext(v)
        }
        
    }
    
}

private class RxVoidEvent {
    
    private let event: VoidEvent
    private let subject = PublishSubject<Void>()
    
    var observable: Observable<Void> {
        return self.subject.asObservable()
    }
    
    init(event: VoidEvent) {
        
        self.event = event
        self.event.addObserver {
            self.subject.onNext(())
        }
        
    }
    
}

public extension Event /* Rx */ {
    
    var observable: Observable<V> {
        return RxEvent<V>(event: self).observable
    }
    
}

public extension VoidEvent /* Rx */ {
    
    var observable: Observable<Void> {
        return RxVoidEvent(event: self).observable
    }
    
}
