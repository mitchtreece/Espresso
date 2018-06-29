//
//  UISpringAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import UIKit

public class UISpringAnimation: UIAnimation {
    
    public var damping: CGFloat
    
    public init(duration: TimeInterval = 0.6,
                delay: TimeInterval = 0,
                damping: CGFloat = 0.9,
                _ animations: @escaping UIAnimationBlock) {
        
        self.damping = damping
        super.init(duration: duration, delay: delay, animations)
        
    }
    
    override public func run(completion: UIAnimationCompletion? = nil) {
        
        let animator = UIViewPropertyAnimator(duration: self.duration, dampingRatio: damping, animations: self.animations)
        animator.startAnimation(afterDelay: delay)
        animator.addCompletion { (position) in
            completion?()
        }
        
    }
    
}
