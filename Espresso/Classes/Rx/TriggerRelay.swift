//
//  TriggerRelay.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import RxSwift
import RxCocoa

/// A wrapped Rx relay that only publishes `Void` events.
public class TriggerRelay {
    
    private var relay = PublishRelay<Void>()
    
    public init() {
        //
    }
    
    /// Fires an event to subscribers.
    public func fire() {
        self.relay.accept(())
    }
    
    /// Converts this relay to an observable sequence.
    public func asObservable() -> Observable<Void> {
        return self.relay.asObservable()
    }
    
}
