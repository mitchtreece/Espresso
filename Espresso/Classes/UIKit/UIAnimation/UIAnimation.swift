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
 
 UIAnimation {
    view.alpha = 1
    view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
 }.run()
 ```
 */
public class UIAnimation {
    
    /**
     Representation of the various animation timing curves.
     */
    public enum TimingCurve {
        
        /// A simple timing curve using one of the built-in `UIViewAnimationCurve` types.
        case simple(UIView.AnimationCurve)
        
        /// A cubic bezier timing curve using two control points.
        case cubicBezier(cp1: CGPoint, cp2: CGPoint)
        
        /// A spring timing curve using a damping ratio & initial velocity.
        case spring(damping: CGFloat, velocity: CGVector)
        
        /// A custom timing curve using a specified `UITimingCurveProvider`.
        case custom(UITimingCurveProvider)
        
    }
    
    /**
     The animation's timing curve.
     */
    public private(set) var timingCurve: TimingCurve
    
    /**
     The animation's duration.
     */
    public private(set) var duration: TimeInterval
    
    /**
     The animation's start delay.
     */
    public private(set) var delay: TimeInterval
    
    /**
     The animation block.
     */
    public private(set) var animationBlock: UIAnimationBlock
    
    /**
     Initializes a new animation with the specified parameters.

     - Parameter timingCurve: The animation's timing curve; _defaults to simple(easeInOut)_.
     - Parameter duration: The animation's duration; _defaults to 0.6_.
     - Parameter delay: The animation's start delay; _defaults to 0_.
     - Parameter animations: The animation block.
     - Returns: A new `UIAnimation` instance.
     */
    public init(_ timingCurve: TimingCurve = .simple(.easeInOut),
                duration: TimeInterval = 0.6,
                delay: TimeInterval = 0,
                _ animations: @escaping UIAnimationBlock) {
        
        self.timingCurve = timingCurve
        self.duration = duration
        self.delay = delay
        self.animationBlock = animations
        
    }
    
    /**
     Creates a new animation group containing the current animation,
     then chains a new animation with the specified parameters.
     
     - Parameter timingCurve: The animation's timing curve; _defaults to simple(easeInOut)_.
     - Parameter duration: The animation's duration; _defaults to 0.6_.
     - Parameter delay: The animation's start delay; _defaults to 0_.
     - Parameter animations: The animation block.
     - Returns: A new `UIAnimationGroup` containing the current animation & chaining a new animation to the end.
     */
    public func then(_ timingCurve: TimingCurve = .simple(.easeInOut),
                     duration: TimeInterval = 0.6,
                     delay: TimeInterval = 0,
                     _ animations: @escaping UIAnimationBlock) -> UIAnimationGroup {
        
        let nextAnimation = UIAnimation(timingCurve, duration: duration, delay: delay, animations)
        return UIAnimationGroup(animations: [self, nextAnimation])
        
    }

    /**
     Starts the animation.
     
     - Parameter completion: An optional completion handler; _defaults to nil_.
     */
    public func run(completion: UIAnimationCompletion? = nil) {

        let animator: UIViewPropertyAnimator
        var parameters: UITimingCurveProvider
        
        switch timingCurve {
        case .simple(let curve):
            
            animator = UIViewPropertyAnimator(duration: duration, curve: curve, animations: animationBlock)
            animator.startAnimation(afterDelay: delay)
            animator.addCompletion { _ in
                completion?()
            }
            
            return
            
        case .cubicBezier(let cp1, let cp2): parameters = UICubicTimingParameters(controlPoint1: cp1, controlPoint2: cp2)
        case .spring(let damping, let velocity): parameters = UISpringTimingParameters(dampingRatio: damping, initialVelocity: velocity)
        case .custom(let provider): parameters = provider
        }
        
        animator = UIViewPropertyAnimator(duration: duration, timingParameters: parameters)
        animator.addAnimations(animationBlock)
        animator.startAnimation(afterDelay: delay)
        animator.addCompletion { _ in
            completion?()
        }
        
    }
    
}

extension UIAnimation: CustomStringConvertible, CustomDebugStringConvertible {
    
    public var description: String {
        
        var curveString: String
        
        switch timingCurve {
        case .simple(let curve):
            
            switch curve {
            case .linear: curveString = "simple(linear)"
            case .easeIn: curveString = "simple(easeIn)"
            case .easeOut: curveString = "simple(easeOut)"
            case .easeInOut: curveString = "simple(easeInOut)"
            }
            
        case .cubicBezier(let cp1, let cp2): curveString = "cubicBezier(cp1: (\(cp1.x), \(cp1.y)), cp2: (\(cp2.x), \(cp2.y)))"
        case .spring(let damping, let velocity): curveString = "spring(damping: \(damping), velocity: (\(velocity.dx), \(velocity.dy)))"
        case .custom: curveString = "custom"
        }

        return "<UIAnimation: \(curveString), duration: \(duration), delay: \(delay)>"
        
    }
    
    public var debugDescription: String {
        return description
    }
    
}
