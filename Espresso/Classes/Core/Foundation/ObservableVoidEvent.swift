//
//  ObservableVoidEvent.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import Foundation

public class ObservableVoidEvent {
    
    private let event = ObservableEvent<Void>()
    
    public init() {
        //
    }
    
    @discardableResult
    public func addObserver(_ handler: @escaping ()->()) -> ObservableEvent<Void>.Token<Void> {
        return self.event.addObserver(handler)
    }
    
    public func removeObserver(token: ObservableEvent<Void>.Token<Void>) {
        self.event.removeObserver(token: token)
    }
    
    public func removeAllObservers() {
        self.event.removeAllObservers()
    }
    
    public func dispatch() {
        self.event.dispatch(value: ())
    }
    
}
