//
//  UIAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

public typealias UIAnimationBlock = ()->()
public typealias UIAnimationCompletion = ()->()

public class UIAnimation {
    
    public var duration: TimeInterval
    public var delay: TimeInterval = 0
    public var curve: UIViewAnimationCurve
    public var animations: UIAnimationBlock
    
    public init(duration: TimeInterval = 0.6,
                delay: TimeInterval = 0,
                curve: UIViewAnimationCurve = .easeInOut,
                _ animations: @escaping UIAnimationBlock) {
        
        self.duration = duration
        self.delay = delay
        self.curve = curve
        self.animations = animations
        
    }
    
    public func run(completion: UIAnimationCompletion? = nil) {
        
        let animator = UIViewPropertyAnimator(duration: duration, curve: curve, animations: animations)
        animator.startAnimation(afterDelay: delay)
        animator.addCompletion { (position) in
            completion?()
        }
        
    }
    
}
