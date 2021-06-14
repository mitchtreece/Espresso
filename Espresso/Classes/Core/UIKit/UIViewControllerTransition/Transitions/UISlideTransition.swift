//
//  UISlideTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A sliding view controller transition.
public class UISlideTransition: UIViewControllerTransition {
    
    public var duration: TimeInterval
    
    /// Initializes the transition with parameters.
    /// - Parameter duration: The transition's animation duration; _defaults to 0.6_.
    public init(duration: TimeInterval = 0.6) {
        self.duration = duration
    }
    
    override public func animator(for transitionType: TransitionType,
                                  context ctx: Context) -> UIAnimationGroupAnimator {

        let settings = self.settings(for: transitionType)
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.transitionContainerView
        let context = ctx.context
        
        return UIAnimationGroupAnimator(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: settings.direction.inverted()
            )
            
            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), duration: self.duration, {
                
                sourceVC.view.transform = self.boundsTransform(
                    in: container,
                    direction: settings.direction
                )
                
                destinationVC.view.transform = .identity
                
            })
            
        }, completion: {
                
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
                
        })

    }
    
}
