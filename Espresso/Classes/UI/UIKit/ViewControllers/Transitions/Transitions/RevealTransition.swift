//
//  RevealTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 11/26/19.
//

import UIKit

/// A revealing view controller transition.
public class RevealTransition: ViewControllerDirectionalTransition {
        
    /// The alpha to apply to the revealed view while transitioning; _defaults to 0.7_.
    public var revealedViewAlpha: CGFloat = 0.7
    
    /// The parallax amount to move the revealed view by while transitioning; _defaults to 100_.
    public var revealedViewParallaxAmount: CGFloat = 100
    
    override public func animations(using ctx: Context) -> AnimationGroupController {
                
        return (ctx.operation == .presentation) ?
            present(ctx) :
            dismiss(ctx)
        
    }
    
    private func present(_ ctx: Context) -> AnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        return AnimationGroupController(setup: {
            
            destinationVC.view.alpha = self.revealedViewAlpha
            destinationVC.view.transform = self.translation(
                self.revealedViewParallaxAmount,
                direction: self.presentationDirection.inverted()
            )
            
            container.insertSubview(
                destinationVC.view,
                belowSubview: sourceVC.view
            )
            
        }, animations: {
            
            Animation(.defaultSpring, duration: self.duration) {
                
                sourceVC.view.transform = self.boundsTransform(
                    in: container,
                    direction: self.presentationDirection
                )
                
                destinationVC.view.alpha = 1
                destinationVC.view.transform = .identity
                
            }
            
        }, completion: {
            
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
    private func dismiss(_ ctx: Context) -> AnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        return AnimationGroupController(setup: {
            
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: self.dismissalDirection.inverted()
            )

            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            Animation(.defaultSpring, duration: self.duration) {
                
                sourceVC.view.alpha = self.revealedViewAlpha
                sourceVC.view.transform = self.translation(
                    self.revealedViewParallaxAmount,
                    direction: self.dismissalDirection
                )
                
                destinationVC.view.transform = .identity
                
            }
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
