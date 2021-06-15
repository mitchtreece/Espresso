//
//  Event.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import Foundation

/// An observable event that emits a value.
public class Event<V> {
    
    internal class Observer<V> {
                
        private var handler: (V)->()
        
        init(handler: @escaping (V)->()) {
            self.handler = handler
        }
        
        func send(value: V) {
            self.handler(value)
        }
        
    }
    
    /// `Event` token class that can be used to identify a specific observer.
    public class Token<V> {
        
        internal var observer: Observer<V>
        
        internal init(observer: Observer<V>) {
            self.observer = observer
        }
        
    }
    
    private var observers = [Observer<V>]()
    
    /// Initializes an event.
    public init() {
        //
    }
    
    /// Adds an observer using a given handler.
    /// - parameter handler: The handler called when dispatching.
    /// - returns: An event token.
    @discardableResult
    public func addObserver(_ handler: @escaping (V)->()) -> Token<V> {
        
        let observer = Observer(handler: handler)
        self.observers.append(observer)
        return Token(observer: observer)
        
    }
    
    /// Removes an observer using an event token.
    /// - parameter token: The event token.
    public func removeObserver(token: Token<V>) {
        
        // We cannot just remove the observers from the array,
        // because to do that our observer class would have
        // to conform to the 'Equatable' protocol. The `Observer`
        // class only has a closure to compare, and that's not
        // allowed. So instead, we'll loop over our observers
        // array and add all elements EXCEPT the observer that
        // wants to be unsubscribed to a new array.
        
        let updatedObservers = self.observers
            .filter { $0 !== token.observer }
        
        self.observers = updatedObservers
        
    }
    
    /// Removes all observers.
    public func removeAllObservers() {
        self.observers.removeAll()
    }
    
    /// Emits a value to all observers.
    /// - parameter value: The value to emit.
    public func emit(value: V) {
        self.observers.forEach { $0.send(value: value) }
    }
    
}
