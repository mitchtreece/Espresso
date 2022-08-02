//
//  Array+Animation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import Foundation

public extension Array where Element: Animation {

    /// Starts the array's animations.
    ///
    /// - parameter completion: An optional completion closure; _defaults to nil_.
    func startAnimations(completion: Animation.Completion? = nil) {
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        for i in 0..<self.count {
            
            let animation = self[i]
            
            queue.addOperation(AnimationOperation(
                animation: animation,
                index: i
            ))
            
        }
        
        queue.operations.completion {
            DispatchQueue.main.async {
                completion?()
            }
        }
        
    }
    
}

extension Array: AnimationGroupRepresentable where Element: Animation {
    
    public func asAnimationGroup() -> AnimationGroup {
        return AnimationGroup(animations: self)
    }
    
}
