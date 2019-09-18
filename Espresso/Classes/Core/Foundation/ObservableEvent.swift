//
//  ObservableEvent.swift
//  Espresso
//
//  Created by Mitch Treece on 9/18/19.
//

import Foundation

public class ObservableEvent<V> {
    
    internal class Observer<V> {
        
        typealias Handler = (V)->()
        
        private var handler: Handler
        
        init(handler: @escaping Handler) {
            self.handler = handler
        }
        
        func dispatch(value: V) {
            self.handler(value)
        }
        
    }
    
    public class Token<V> {
        
        internal var observer: Observer<V>
        
        internal init(observer: Observer<V>) {
            self.observer = observer
        }
        
    }
    
    private var observers = [Observer<V>]()
    
    public init() {
        //
    }
    
    @discardableResult
    public func addObserver(_ handler: @escaping (V)->()) -> Token<V> {
        
        let observer = Observer(handler: handler)
        self.observers.append(observer)
        return Token(observer: observer)
        
    }
    
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
    
    public func removeAllObservers() {
        self.observers.removeAll()
    }
    
    public func dispatch(value: V) {
        self.observers.forEach { $0.dispatch(value: value) }
    }
    
}
