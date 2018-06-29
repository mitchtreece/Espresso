//
//  UIAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

public class UIAnimation {
    
    public typealias UIAnimationBlock = ()->()
    public typealias UIAnimationCompletion = ()->()
    
    public var duration: TimeInterval = 0.6
    public var delay: TimeInterval = 0
    public var options: UIViewAnimationOptions = [.curveEaseInOut]
    public var animations: UIAnimationBlock
    
    public init(duration: TimeInterval = 0.6,
                delay: TimeInterval = 0,
                options: UIViewAnimationOptions = [.curveEaseInOut],
                _ animations: @escaping UIAnimationBlock) {
        
        self.duration = duration
        self.delay = delay
        self.options = options
        self.animations = animations
        
    }
    
    public func run(completion: UIAnimationCompletion? = nil) {
        
        UIView.animate(withDuration: duration, delay: delay, options: options, animations: animations) { (finished) in
            completion?()
        }
        
    }
    
}
