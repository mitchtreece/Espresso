//
//  UICoverTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A covering view controller transition.
public class UICoverTransition: UIViewControllerDirectionalTransition {
    
    /// The alpha to apply to the covered view while transitioning; _defaults to 0.7_.
    public var coveredViewAlpha: CGFloat = 0.7
    
    /// The parallax amount to move the covered view by while transitioning; _defaults to 100_.
    public var coveredViewParallaxAmount: CGFloat = 100
    
    override public func animations(using ctx: Context) -> UIAnimationGroupController {
        
        return (ctx.operation == .presentation) ?
            present(ctx) :
            dismiss(ctx)
        
    }
    
    private func present(_ ctx: Context) -> UIAnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        return UIAnimationGroupController(setup: {
            
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: self.presentationDirection.inverted()
            )
            
            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            UIAnimation(.defaultSpring, duration: self.duration) {
                
                sourceVC.view.alpha = self.coveredViewAlpha
                sourceVC.view.transform = self.translation(
                    self.coveredViewParallaxAmount,
                    direction: self.presentationDirection
                )
                
                destinationVC.view.transform = .identity
                
            }
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
    private func dismiss(_ ctx: Context) -> UIAnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        return UIAnimationGroupController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.alpha = self.coveredViewAlpha
            container.insertSubview(
                destinationVC.view,
                belowSubview: sourceVC.view
            )
            
            destinationVC.view.transform = self.translation(
                self.coveredViewParallaxAmount,
                direction: self.dismissalDirection.inverted()
            )
            
        }, animations: {
            
            UIAnimation(.defaultSpring) {
                
                sourceVC.view.transform = self.boundsTransform(
                    in: container,
                    direction: self.dismissalDirection
                )
                
                destinationVC.view.alpha = 1
                destinationVC.view.transform = .identity
                
            }
            
        }, completion: {
                
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
                
        })
        
    }
    
}
