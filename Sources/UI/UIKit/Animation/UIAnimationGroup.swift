//
//  UIAnimationGroup.swift
//  Espresso
//
//  Created by Mitch Treece on 6/30/18.
//

import UIKit

/// `UIAnimationGroup` is a container over a set of animations.
///
/// ```
/// let view = UIView()
/// view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
/// view.alpha = 0
/// ...
///
/// UIAnimation {
///     view.alpha = 1
/// }.then {
///     view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
/// }.start()
/// ```
public class UIAnimationGroup {
        
    public private(set) var animations: [UIAnimation]

    internal init(animations: [UIAnimation]) {
        self.animations = animations
    }
    
    /// Appends a new animation to the group with the specified parameters.
    ///
    /// - parameter timingCurve: The animation's timing curve; _defaults to simple(easeInOut)_.
    /// - parameter duration: The animation's duration; _defaults to defaultDuration_.
    /// - parameter delay: The animation's start delay; _defaults to 0_.
    /// - parameter animations: The animation closure.
    /// - returns: A `AnimationGroup` by appending the new animation.
    public func then(_ timingCurve: UIAnimation.TimingCurve = .simple(.easeInOut),
                     duration: TimeInterval = UIAnimation.defaultDuration,
                     delay: TimeInterval = 0,
                     _ animations: @escaping UIAnimation.Animations) -> UIAnimationGroup {
        
        let animation = UIAnimation(
            timingCurve,
            duration: duration,
            delay: delay,
            animations
        )
        
        self.animations
            .append(animation)
        
        return self
        
    }
    
    /// Starts the group's animations.
    ///
    /// - parameter completion: An optional completion closure; _defaults to nil_.
    public func start(completion: UIAnimation.Completion? = nil) {
        
        self.animations
            .startAnimations(completion: completion)
        
    }
    
}

extension UIAnimationGroup: UIAnimationGroupRepresentable {
    
    public func asAnimationGroup() -> UIAnimationGroup {
        return self
    }
    
}
