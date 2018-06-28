//
//  UITransitionAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

public struct UITransitionAnimationOptions {
    
    public var duration: TimeInterval
    public var delay: TimeInterval
    public var springDamping: CGFloat
    public var springVelocity: CGFloat
    public var options: UIViewAnimationOptions
    
    public static func `default`(duration: TimeInterval = 0.6,
                                 delay: TimeInterval = 0,
                                 springDamping: CGFloat = 0.9,
                                 springVelocity: CGFloat = 0.25,
                                 options: UIViewAnimationOptions = [.curveEaseInOut]) -> UITransitionAnimationOptions {
        
        return UITransitionAnimationOptions(duration: duration,
                                            delay: delay,
                                            springDamping: springDamping,
                                            springVelocity: springVelocity,
                                            options: options)
        
    }
    
}

public struct UITransitionAnimation {
    
    public var options = UITransitionAnimationOptions.default()
    public var animations: UITransition.VoidBlock
    
    internal var index: Int = 0
    
    public init(_ animations: @escaping UITransition.VoidBlock) {
        self.animations = animations
    }
    
    public init(_ animations: @escaping UITransition.VoidBlock, options: UITransitionAnimationOptions) {
        self.init(animations)
        self.options = options
    }
    
}
