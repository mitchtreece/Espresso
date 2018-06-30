//
//  UIAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

/**
 A typealias representing an animation block.
 */
public typealias UIAnimationBlock = ()->()

/**
 A typealias representing an animation completion handler.
 */
public typealias UIAnimationCompletion = ()->()

/**
 `UIAnimation` is a wrapper over `UIView` property animation.

 ```
 let view = UIView()
 view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
 view.alpha = 0
 ...
 
 UIAnimation.basic {
    view.alpha = 1
    view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
 }.run()
 ```
 
 Supported animtions:
 - `basic`
 - `spring`
 */
public class UIAnimation {
    
    /**
     The animation's duration.
     */
    public private(set) var duration: TimeInterval
    
    /**
     The animation's start delay.
     */
    public private(set) var delay: TimeInterval
    
    /**
     The animation's timing curve.
     */
    public private(set) var curve: UIViewAnimationCurve
    
    /**
     The animation block.
     */
    public private(set) var animationBlock: UIAnimationBlock
    
    internal init(duration: TimeInterval,
                 delay: TimeInterval,
                 curve: UIViewAnimationCurve,
                 _ animations: @escaping UIAnimationBlock) {
        
        self.duration = duration
        self.delay = delay
        self.curve = curve
        self.animationBlock = animations
        
    }
    
    // MARK: Animation building
    
    /**
     Creates a new basic animation with the specified parameters.
     
     - Parameter duration: The animation's duration; _defaults to 0.6_.
     - Parameter delay: The animation's start delay; _defaults to 0_.
     - Parameter curve: The animation's timing curve; _default to .easeInOut_.
     - Parameter animation: The animation block.
     - Returns: A `UIAnimationGroup` containing the new animation.
     */
    public static func basic(duration: TimeInterval = 0.6,
                             delay: TimeInterval = 0,
                             curve: UIViewAnimationCurve = .easeInOut,
                             _ animations: @escaping UIAnimationBlock) -> UIAnimationGroup {
        
        let animation = UIBasicAnimation(duration: duration, delay: delay, curve: curve, animations)
        return UIAnimationGroup(animation: animation)
        
    }
    
    /**
     Creates a new spring animation with the specified parameters.
     
     - Parameter duration: The animation's duration; _defaults to 0.6_.
     - Parameter delay: The animation's start delay; _defaults to 0_.
     - Parameter damping: The animation's spring damping; _default to 0.9_.
     - Parameter animation: The animation block.
     - Returns: A `UIAnimationGroup` containing the new animation.
     */
    public static func spring(duration: TimeInterval = 0.6,
                              delay: TimeInterval = 0,
                              damping: CGFloat = 0.9,
                              _ animations: @escaping UIAnimationBlock) -> UIAnimationGroup {
        
        let animation = UISpringAnimation(duration: duration, delay: delay, damping: damping, animations)
        return UIAnimationGroup(animation: animation)
        
    }
    
    // MARK: Execution
    
    // This function doesn't need to be public as it's called only internally.
    // The public builder functions return `UIAnimationGroup` instances.
    // `run()` should be called on them, not directly on `UIAnimation`.
    
    internal func run(completion: UIAnimationCompletion? = nil) {
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: curve, animations: animationBlock)
        animator.startAnimation(afterDelay: delay)
        animator.addCompletion { (position) in
            completion?()
        }
        
    }
    
}
