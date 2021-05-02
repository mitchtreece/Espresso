//
//  AsyncOperation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import Foundation

/// An async `Operation` subclass.
public class AsyncOperation: Operation {
    
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
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
        
    }
    
    public override var isAsynchronous: Bool {
        return true
    }
    
    public override var isExecuting: Bool {
        return state == .executing
    }
    
    public override var isFinished: Bool {
        return state == .finished
    }
    
    public override func start() {
        
        if self.isCancelled {
            state = .finished
        }
        else {
            state = .ready
            main()
        }
        
    }
    
    public override func main() {
        
        if self.isCancelled {
            state = .finished
        }
        else {
            state = .executing
        }
        
    }
    
}
