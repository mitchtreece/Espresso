//
//  Array+UIAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import Foundation

public extension Array where Element: UIAnimation {

    /// Starts the array's animations.
    /// - parameter completion: An optional completion closure.
    func startAnimations(completion: UIAnimation.Completion? = nil) {
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        for i in 0..<self.count {
            
            let animation = self[i]
            
            queue.addOperation(UIAnimationOperation(
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

extension Array: UIAnimationGroupRepresentable where Element: UIAnimation {
    
    public func asAnimationGroup() -> UIAnimationGroup {
        return UIAnimationGroup(animations: self)
    }
    
}
