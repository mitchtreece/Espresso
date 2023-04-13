//
//  AsyncOperation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import Foundation

/// An async `Operation` subclass.
open class AsyncOperation: Operation {
    
    /// Representation of the various async operation states.
    public enum State: String {
        
        /// A ready state.
        case ready = "Ready"
        
        /// An executing state.
        case executing = "Executing"
        
        /// A finished state.
        case finished = "Finished"
        
        fileprivate var keyPath: String { return "is" + self.rawValue }
        
    }
    
    /// The async operation's current state.
    public var state: State = .ready {
        
        willSet {
            willChangeValue(forKey: self.state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: self.state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
        
    }
    
    open override var isAsynchronous: Bool {
        return true
    }
    
    open override var isExecuting: Bool {
        return self.state == .executing
    }
    
    open override var isFinished: Bool {
        return self.state == .finished
    }
    
    open override func start() {
        
        if self.isCancelled {
            self.state = .finished
        }
        else {
            self.state = .ready
            main()
        }
        
    }
    
    open override func main() {
        
        if self.isCancelled {
            self.state = .finished
        }
        else {
            self.state = .executing
        }
        
    }
    
}
