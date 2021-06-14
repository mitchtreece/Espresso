//
//  UIAnimationGroupAnimator.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

public struct UIAnimationGroupAnimator {
    
    private var setup: (()->())?
    private var group: UIAnimationGroup
    private var completion: (()->())?
    
    public var duration: TimeInterval {
        
        let totalDelayDuration = self.group
            .animations
            .compactMap { $0.delay }
            .reduce(0, +)
        
        let totalAnimationDuration = self.group
            .animations
            .compactMap { $0.duration }
            .reduce(0, +)
        
        return (totalDelayDuration + totalAnimationDuration)

    }
    
    public init(setup: (()->())? = nil,
                animations: ()->(UIAnimationGroupConvertible),
                completion: (()->())? = nil) {
        
        self.setup = setup
        self.group = animations().animationGroup
        self.completion = completion
        
    }
    
    public func run() {
        
        UIView.performWithoutAnimation {
            self.setup?()
        }
        
        self.group.run {
            self.completion?()
        }
        
    }
    
}
