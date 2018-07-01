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
     Representation of the various animation types.
     */
    public enum AnimationType {
        
        /// A basic animation.
        case basic

        /// A spring animation using a specified damping value.
        case spring(damping: CGFloat)
        
    }
    
    /**
     The animation's type.
     */
    public private(set) var type: AnimationType
    
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
    
    /**
     Initializes a new animation with the specified parameters.

     - Parameter type: The animation's type; _defaults to basic_.
     - Parameter duration: The animation's duration; _defaults to 0.6_.
     - Parameter delay: The animation's start delay; _defaults to 0_.
     - Parameter curve: The animation's timing curve; _default to .easeInOut_.
     - Parameter animation: The animation block.
     - Returns: A new `UIAnimation` instance.
     */
    public init(_ type: AnimationType = .basic,
                duration: TimeInterval = 0.6,
                delay: TimeInterval = 0,
                curve: UIViewAnimationCurve = .easeInOut,
                _ animations: @escaping UIAnimationBlock) {
        
        self.type = type
        self.duration = duration
        self.delay = delay
        self.curve = curve
        self.animationBlock = animations
        
    }
    
    /**
     Creates a new animation group containing the current animation,
     then chains a new animation with the specified parameters.
     
     - Parameter type: The animation's type; _defaults to basic_.
     - Parameter duration: The animation's duration; _defaults to 0.6_.
     - Parameter delay: The animation's start delay; _defaults to 0_.
     - Parameter curve: The animation's timing curve; _default to .easeInOut_.
     - Parameter animations: The animation block.
     - Returns: A new `UIAnimationGroup` containing the current animation & chaining a new animation to the end.
     */
    public func then(_ type: UIAnimation.AnimationType = .basic,
                     duration: TimeInterval = 0.6,
                     delay: TimeInterval = 0,
                     curve: UIViewAnimationCurve = .easeInOut,
                     _ animations: @escaping UIAnimationBlock) -> UIAnimationGroup {
        
        let nextAnimation = UIAnimation(type, duration: duration, delay: delay, curve: curve, animations)
        return UIAnimationGroup(animations: [self, nextAnimation])
        
    }

    /**
     Starts the animation.
     
     - Parameter completion: An optional completion handler; _defaults to nil_.
     */
    public func run(completion: UIAnimationCompletion? = nil) {
        
        let animator: UIViewPropertyAnimator
        
        switch type {
        case .basic: animator = UIViewPropertyAnimator(duration: duration, curve: curve, animations: animationBlock)
        case .spring(let damping): animator = UIViewPropertyAnimator(duration: duration, dampingRatio: damping, animations: animationBlock)
        }
        
        animator.startAnimation(afterDelay: delay)
        animator.addCompletion { _ in
            completion?()
        }
        
    }
    
}
