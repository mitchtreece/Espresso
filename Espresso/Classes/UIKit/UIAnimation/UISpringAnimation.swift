//
//  UISpringAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import UIKit

internal class UISpringAnimation: UIAnimation {
    
    internal var damping: CGFloat
    
    internal init(duration: TimeInterval,
                  delay: TimeInterval,
                  damping: CGFloat,
                  _ animations: @escaping UIAnimationBlock) {
        
        self.damping = damping
        super.init(duration: duration, delay: delay, curve: .linear, animations)
        
    }
    
    override internal func run(completion: UIAnimationCompletion? = nil) {
        
        let animator = UIViewPropertyAnimator(duration: self.duration, dampingRatio: damping, animations: self.animationBlock)
        animator.startAnimation(afterDelay: delay)
        animator.addCompletion { (position) in
            completion?()
        }
        
    }
    
}
