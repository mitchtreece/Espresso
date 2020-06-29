//
//  UIRevealTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 11/26/19.
//

import UIKit

/// A revealing view controller transition.
public class UIRevealTransition: UITransition {
    
    /// The revealed view's alpha to animate from while transitioning; _defaults to 0.7_.
    public var revealedViewAlpha: CGFloat
    
    /// The amount to move the revealed view while transitioning; _defaults to 0_.
    public var revealedViewParallaxAmount: CGFloat
    
    /// Initializes the transition with parameters.
    /// - Parameter revealedViewAlpha: The revealed view's alpha to animate from while transitioning; _defaults to 0.7_.
    /// - Parameter revealedViewParallaxAmount: The amount to move the revealed view while transitioning; _defaults to 0_.
    public init(revealedViewAlpha: CGFloat = 0.7, revealedViewParallaxAmount: CGFloat = 0) {
        self.revealedViewAlpha = revealedViewAlpha
        self.revealedViewParallaxAmount = revealedViewParallaxAmount
    }
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        
        return _animate(
            with: info,
            settings: settings(for: transitionType)
        )
        
    }
    
    private func _animate(with info: Info, settings: Settings) -> UITransitionController {
        
        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        return UITransitionController(setup: {
            
            destinationVC.view.alpha = self.revealedViewAlpha
            destinationVC.view.transform = self.translation(
                self.revealedViewParallaxAmount,
                direction: settings.direction.reversed()
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
