//
//  UIRevealTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 11/26/19.
//

import UIKit

/// A revealing view controller transition.
public class UIRevealTransition: UIViewControllerTransition {
    
    /// The revealed view's alpha to animate from while transitioning; _defaults to 0.7_.
    public var revealedViewAlpha: CGFloat
    
    /// The amount to move the revealed view while transitioning; _defaults to 0_.
    public var revealedViewParallaxAmount: CGFloat
    
    /// Initializes the transition with parameters.
    /// - Parameter revealedViewAlpha: The revealed view's alpha to animate from while transitioning; _defaults to 0.7_.
    /// - Parameter revealedViewParallaxAmount: The amount to move the revealed view while transitioning; _defaults to 0_.
    public init(revealedViewAlpha: CGFloat = 0.7,
                revealedViewParallaxAmount: CGFloat = 0) {
        
        self.revealedViewAlpha = revealedViewAlpha
        self.revealedViewParallaxAmount = revealedViewParallaxAmount
        
    }
    
    override public func animator(for transitionType: TransitionType,
                                  context ctx: Context) -> UIAnimationGroupAnimator {
        
        let settings = self.settings(for: transitionType)
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.transitionContainerView
        let context = ctx.context
        
        return UIAnimationGroupAnimator(setup: {
            
            destinationVC.view.alpha = self.revealedViewAlpha
            destinationVC.view.transform = self.translation(
                self.revealedViewParallaxAmount,
                direction: settings.direction.inverted()
            )
            
            container.insertSubview(
                destinationVC.view,
                belowSubview: sourceVC.view
            )
            
        }, animations: {
            
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), {
                
                sourceVC.view.transform = self.boundsTransform(
                    in: container,
                    direction: settings.direction
                )
                
                destinationVC.view.alpha = 1
                destinationVC.view.transform = .identity
                
            })
            
        }, completion: {
            
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
