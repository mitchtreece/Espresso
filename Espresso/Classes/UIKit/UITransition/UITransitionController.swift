//
//  UITransitionController.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

public struct UITransitionController {
    
    public var setup: UITransition.VoidBlock
    public var animations: [UITransitionAnimation]
    public var completion: UITransition.VoidBlock
    
    internal var animationDuration: TimeInterval {
        
        let totalDelayDuration = animations.compactMap({ $0.options.delay }).reduce(0, +)
        let totalAnimationDuration = animations.compactMap({ $0.options.duration }).reduce(0, +)
        return (totalDelayDuration + totalAnimationDuration)

    }
    
    public init(setup: @escaping UITransition.VoidBlock,
                animations: [UITransitionAnimation],
                completion: @escaping UITransition.VoidBlock) {
        
        self.setup = setup
        self.animations = animations
        self.completion = completion
        
    }
    
}
