//
//  Array+UIAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import Foundation

public extension Array where Element: UIAnimation {

    /// Starts the array's animations.
    /// - parameter completion: An optional completion closure; _defaults to nil_.
    func startAnimations(completion: UIAnimation.Completion? = nil) {
        
        let queue = UIAnimationOperationQueue()
        
        for i in 0..<self.count {
            
            let animation = self[i]
            let operation = UIAnimationOperation(animation: animation, index: i)
            queue.addOperation(operation)
            
        }
        
        queue.operations.completion {
            DispatchQueue.main.async {
                completion?()
            }
        }
        
    }
    
}
