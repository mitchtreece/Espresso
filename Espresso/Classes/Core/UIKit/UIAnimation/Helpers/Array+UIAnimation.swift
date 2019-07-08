//
//  Array+UIAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import Foundation

public extension Array where Element: UIAnimation {

    /**
     Starts the array's animations.
     
     - Parameter completion: An optional completion handler; _defaults to nil_.
     */
    func run(completion: UIAnimationCompletion? = nil) {
        
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
