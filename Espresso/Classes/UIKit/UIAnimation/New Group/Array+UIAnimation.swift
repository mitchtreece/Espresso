//
//  Array+UIAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import Foundation

internal extension Array where Element: UIAnimation {

    internal func run(completion: UIAnimationCompletion? = nil) {
        
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
