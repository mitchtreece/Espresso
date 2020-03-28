//
//  VoidEvent.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import Foundation

/// An observable event.
public class VoidEvent {
    
    private let event = Event<Void>()
    
    /// Initializes an event.
    public init() {
        //
    }
    
    /// Adds an observer using a given handler.
    /// - parameter handler: The handler called when a dispatching.
    /// - returns: An event token.
    @discardableResult
    public func addObserver(_ handler: @escaping ()->()) -> Event<Void>.Token<Void> {
        return self.event.addObserver(handler)
    }
    
    /// Removes an observer using an event token.
    /// - parameter token: The event token.
    public func removeObserver(token: Event<Void>.Token<Void>) {
        self.event.removeObserver(token: token)
    }
    
    /// Removes all observers.
    public func removeAllObservers() {
        self.event.removeAllObservers()
    }
    
    /// Emits to all observers.
    public func emit() {
        self.event.emit(value: ())
    }
    
}
