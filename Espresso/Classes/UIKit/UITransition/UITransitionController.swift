//
//  UITransitionController.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

public struct UITransitionController {
    
    public typealias SetupBlock = ()->()
    public typealias AnimationsBlock = ()->(UIAnimationGroupConvertible)
    public typealias Completion = ()->()
    
    public var setup: SetupBlock?
    public var group: UIAnimationGroup
    public var completion: Completion
    
    internal var animationDuration: TimeInterval {
        
        let totalDelayDuration = group.animations.compactMap({ $0.delay }).reduce(0, +)
        let totalAnimationDuration = group.animations.compactMap({ $0.duration }).reduce(0, +)
        return (totalDelayDuration + totalAnimationDuration)

    }
    
    public init(setup: SetupBlock?,
                animations: AnimationsBlock,
                completion: @escaping Completion) {
        
        self.setup = setup
        self.group = animations().animationGroup
        self.completion = completion
        
    }
    
}
