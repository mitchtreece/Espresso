//
//  UIAnimationGroup.swift
//  Espresso
//
//  Created by Mitch Treece on 6/30/18.
//

import UIKit

/**
 `UIAnimationGroup` is a container for a set of animations.
 
 Animations can be _chained_ to a group by using it's respective `then` functions.
 
 ```
 let view = UIView()
 view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
 view.alpha = 0
 ...
 
 UIAnimation.basic {
    view.alpha = 1
 }.then {
    view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
 }.run()
 ```
 */
public class UIAnimationGroup {
        
    internal private(set) var _animations: [UIAnimation]

    internal init(animations: [UIAnimation]) {
        self._animations = animations
    }
    
    /**
     Chains a new animation to the group with the specified parameters.
     
     - Parameter type: The animation's type; _defaults to basic_.
     - Parameter duration: The animation's duration; _defaults to 0.6_.
     - Parameter delay: The animation's start delay; _defaults to 0_.
     - Parameter curve: The animation's timing curve; _default to .easeInOut_.
     - Parameter animation: The animation block.
     - Returns: A `UIAnimationGroup` by appending the new animation.
     */
    public func then(_ type: UIAnimation.AnimationType = .basic,
                     duration: TimeInterval = 0.6,
                     delay: TimeInterval = 0,
                     curve: UIViewAnimationCurve = .easeInOut,
                     _ animations: @escaping UIAnimationBlock) -> UIAnimationGroup {
        
        let animation = UIAnimation(type, duration: duration, delay: delay, curve: curve, animations)
        self._animations.append(animation)
        return self
        
    }
    
    /**
     Starts the group's animations.
     
     - Parameter completion: An optional completion handler; _defaults to nil_.
     */
    public func run(completion: UIAnimationCompletion? = nil) {
        self._animations.run(completion: completion)
    }
    
}
