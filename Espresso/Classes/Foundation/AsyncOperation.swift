//
//  AsyncOperation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import Foundation

internal class AsyncOperation: Operation {
    
    enum State: String {
        
        case ready = "Ready"
        case executing = "Executing"
        case finished = "Finished"
        
        fileprivate var keyPath: String { return "is" + self.rawValue }
        
    }
    
    var state: State = .ready {
        
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
        
    }
    
    override var isAsynchronous: Bool {
        return true
    }
    
    override var isExecuting: Bool {
        return state == .executing
    }
    
    override var isFinished: Bool {
        return state == .finished
    }
    
    override func start() {
        
        if self.isCancelled {
            state = .finished
        }
        else {
            state = .ready
            main()
        }
        
    }
    
    override func main() {
        
        if self.isCancelled {
            state = .finished
        }
        else {
            state = .executing
        }
        
    }
    
}
