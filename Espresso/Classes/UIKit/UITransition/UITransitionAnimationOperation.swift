//
//  UITransitionAnimationOperation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

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

internal class UITransitionAnimationOperation: AsyncOperation {
    
    private var animation: UITransitionAnimation
    private var index: Int
    
    init(animation: UITransitionAnimation, index: Int) {
        self.animation = animation
        self.index = index
    }
    
    override func main() {
        
        super.main()
        
        DispatchQueue.main.async {
            
            UIView.animate(withDuration: self.animation.options.duration,
                           delay: self.animation.options.delay,
                           usingSpringWithDamping: self.animation.options.springDamping,
                           initialSpringVelocity: self.animation.options.springVelocity,
                           options: self.animation.options.options,
                           animations: {
                            
                            self.animation.animations()
                            
            }, completion: { (finished) in
                
                self.state = .finished
                
            })
            
        }
        
    }
    
}
