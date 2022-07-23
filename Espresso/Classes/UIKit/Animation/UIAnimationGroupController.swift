//
//  UIAnimationGroupController.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

/// Wrapper over an animation group that makes it simple to execute
/// setup & completion actions.
public class UIAnimationGroupController {
    
    private var setup: (()->())?
    private var group: UIAnimationGroup
    private var completion: UIAnimation.Completion?
    
    /// The underlying animation group's total duration.
    ///
    /// This duration includes the sum of all the underlying animation delay values.
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
    
    /// Initializes a new animation group controller.
    /// - parameter setup: An optional setup closure to run before animations start; _defaults to nil_.
    /// - parameter animations: A set of animations that can be represented as a `UIAnimationGroup`.
    /// - parameter completion: An optional completion closure; _defaults to nil_.
    ///
    /// Setup closures are forced to run without animation using `UIView.performWithoutAnimation(_:)`.
    public init(setup: (()->())? = nil,
                animations: ()->(UIAnimationGroupable),
                completion: UIAnimation.Completion? = nil) {
        
        self.setup = setup
        self.group = animations().asAnimationGroup()
        self.completion = completion
        
    }
    
    /// Starts the animations.
    public func start() {
        
        UIView.performWithoutAnimation {
            self.setup?()
        }
        
        self.group.start(completion: self.completion)
        
    }
    
}
