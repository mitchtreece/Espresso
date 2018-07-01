//
//  UITransitionController.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

/**
 `UITransitionController` provides animations to run while transitioning between source & destination view controllers.
 */
public struct UITransitionController {
    
    public typealias SetupBlock = ()->()
    public typealias AnimationsBlock = ()->(UIAnimationGroupConvertible)
    public typealias Completion = ()->()
    
    internal private(set) var setup: SetupBlock?
    internal private(set) var group: UIAnimationGroup
    internal private(set) var completion: Completion
    
    internal var animationDuration: TimeInterval {
        
        let totalDelayDuration = group.animations.compactMap({ $0.delay }).reduce(0, +)
        let totalAnimationDuration = group.animations.compactMap({ $0.duration }).reduce(0, +)
        return (totalDelayDuration + totalAnimationDuration)

    }
    
    /**
     Initializes a new `UITransitionController` with specified setup, animation, & completion blocks.
     */
    public init(setup: SetupBlock?,
                animations: AnimationsBlock,
                completion: @escaping Completion) {
        
        self.setup = setup
        self.group = animations().animationGroup
        self.completion = completion
        
    }
    
}
