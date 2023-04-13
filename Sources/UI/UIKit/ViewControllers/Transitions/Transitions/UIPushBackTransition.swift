//
//  UIPushBackTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A push-back view controller transition.
public class UIPushBackTransition: UIViewControllerDirectionalTransition {
    
    /// The scale to apply to the pushed-back view while transitioning; _defaults to 0.9_.
    public var pushedBackViewScale: CGFloat = 0.9
    
    /// The alpha to apply to the pushed-back view while transitioning; _defaults to 0.7_.
    public var pushedBackViewAlpha: CGFloat = 0.7
    
    /// The corner radius to apply to the pushed-back view while transitioning; _defaults to 20_.
    public var pushedBackViewCornerRadius: CGFloat = 20
    
    public override init() {
        
        super.init()
        self.presentationDirection = .up
        self.dismissalDirection = .down
        
    }
    
    public override func animations(using ctx: Context) -> UIAnimationGroupController {

        return (ctx.operation == .presentation) ?
            present(ctx) :
            dismiss(ctx)
        
    }
    
    private func present(_ ctx: Context) -> UIAnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        let previousSourceClipsToBounds = sourceVC.view.clipsToBounds
        let previousSourceCornerRadius = sourceVC.view.layer.cornerRadius
        
        return UIAnimationGroupController(setup: {
            
            sourceVC.view.clipsToBounds = true
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.addSubview(destinationVC.view)
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: self.presentationDirection.inverted()
            )
                        
        }, animations: {
            
            UIAnimation(.defaultSpring, duration: self.duration) {
                
                sourceVC.view.alpha = self.pushedBackViewAlpha
                sourceVC.view.layer.cornerRadius = self.pushedBackViewCornerRadius
                sourceVC.view.transform = CGAffineTransform(
                    scaleX: self.pushedBackViewScale,
                    y: self.pushedBackViewScale
                )
                
                destinationVC.view.transform = .identity
                
            }
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            sourceVC.view.clipsToBounds = previousSourceClipsToBounds
            sourceVC.view.layer.cornerRadius = previousSourceCornerRadius
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
    private func dismiss(_ ctx: Context) -> UIAnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        let previousDestinationClipsToBounds = destinationVC.view.clipsToBounds
        let previousDestinationCornerRadius = destinationVC.view.layer.cornerRadius
        
        return UIAnimationGroupController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.alpha = self.pushedBackViewAlpha
            destinationVC.view.clipsToBounds = true
            destinationVC.view.layer.cornerRadius = self.pushedBackViewCornerRadius
            
            container.insertSubview(
                destinationVC.view,
                belowSubview: sourceVC.view
            )
            
            destinationVC.view.transform = CGAffineTransform(
                scaleX: self.pushedBackViewScale,
                y: self.pushedBackViewScale
            )
            
        }, animations: {
            
            UIAnimation(.defaultSpring, duration: self.duration) {
                
                sourceVC.view.transform = self.boundsTransform(
                    in: container,
                    direction: self.dismissalDirection
                )
                
                destinationVC.view.alpha = 1
                destinationVC.view.transform = .identity
                destinationVC.view.layer.cornerRadius = previousDestinationCornerRadius

            }
            
        }, completion: {
                
            sourceVC.view.transform = .identity
            
            destinationVC.view.alpha = 1
            destinationVC.view.clipsToBounds = previousDestinationClipsToBounds
            
            context.completeTransition(!context.transitionWasCancelled)
                
        })
        
    }
    
}
