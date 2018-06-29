//
//  UISpringAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/29/18.
//

import UIKit

public class UISpringAnimation: UIAnimation {
    
    public var damping: CGFloat = 0.9
    public var initialVelcoty: CGFloat = 0.25
    
    public init(duration: TimeInterval = 0.6,
                delay: TimeInterval = 0,
                damping: CGFloat = 0.9,
                initialVelocity: CGFloat = 0.25,
                options: UIViewAnimationOptions = [.curveEaseInOut],
                _ animations: @escaping UIAnimationBlock) {
        
        super.init(duration: duration, delay: delay, options: options, animations)
        self.damping = damping
        
    }
    
    override public func run(completion: UIAnimationCompletion? = nil) {
        
        UIView.animate(withDuration: self.duration,
                       delay: self.delay,
                       usingSpringWithDamping: damping,
                       initialSpringVelocity: initialVelcoty,
                       options: self.options,
                       animations: self.animations) { (finished) in
                        
                        completion?()
                        
        }
        
    }
    
}
