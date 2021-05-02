//
//  TriggerRelay.swift
//  Espresso
//
//  Created by Mitch Treece on 5/2/21.
//

import RxSwift
import RxCocoa

/// An Rx relay that only publishes `Void` events.
public class TriggerRelay {
    
    private var relay = PublishRelay<Void>()
    
    /// Converts this relay to an observable sequence.
    public func asObservable() -> Observable<Void> {
        return self.relay.asObservable()
    }
    
    /// Fires an event to subscribers.
    func fire() {
        self.relay.accept(())
    }
    
}
