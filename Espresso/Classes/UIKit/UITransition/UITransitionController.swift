//
//  UITransitionController.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

public struct UITransitionController {
    
    public typealias SetupBlock = ()->()
    public typealias Completion = ()->()
    
    public var setup: SetupBlock?
    public var animations: [UIAnimation]
    public var completion: Completion
    
    internal var animationDuration: TimeInterval {
        
        let totalDelayDuration = animations.compactMap({ $0.delay }).reduce(0, +)
        let totalAnimationDuration = animations.compactMap({ $0.duration }).reduce(0, +)
        return (totalDelayDuration + totalAnimationDuration)

    }
    
    public init(setup: SetupBlock?,
                animations: [UIAnimation],
                completion: @escaping Completion) {
        
        self.setup = setup
        self.animations = animations
        self.completion = completion
        
    }
    
}
