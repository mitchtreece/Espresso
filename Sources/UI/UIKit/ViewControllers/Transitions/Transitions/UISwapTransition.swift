//
//  UISwapTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/27/18.
//

import UIKit

/// A swapping view controller transition.
public class UISwapTransition: UIViewControllerDirectionalTransition {
    
    /// The scale to apply to swapped views while transitioning; _defaults to 0.95_.
    public var swappedViewScale: CGFloat = 0.95
    
    /// The corner radius to apply to swapped views while transitioning; _defaults to 20_.
    public var swappedViewCornerRadius: CGFloat = 20
    
    /// The alpha to apply to the covered view while transitioning; _defaults to 0.7_.
    public var coveredViewAlpha: CGFloat = 0.7
    
    public override init() {
        
        super.init()
        self.duration = 0.7
        
    }
    
    public override func animations(using ctx: Context) -> UIAnimationGroupController {
                
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        let direction = ctx.operation == .presentation ?
            self.presentationDirection :
            self.dismissalDirection
        
        let previousSourceClipsToBound = sourceVC.view.clipsToBounds
        let previousSourceCornerRadius = sourceVC.view.layer.cornerRadius
        
        let previousDestinationClipsToBounds = destinationVC.view.clipsToBounds
        let previousDestinationCornerRadius = destinationVC.view.layer.cornerRadius
        
        return UIAnimationGroupController(setup: {
            
            sourceVC.view.clipsToBounds = true
            
            destinationVC.view.alpha = self.coveredViewAlpha
            destinationVC.view.clipsToBounds = true
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.insertSubview(
                destinationVC.view,
                belowSubview: sourceVC.view
            )
            
        }, animations: {
            
            UIAnimation(duration: (self.duration * 0.4)) {
                
                // Source
                
                let sourceTransform = self.halfBoundsTransform(
                    in: container,
                    direction: direction
                )
                
                sourceVC.view.transform = sourceTransform.scaledBy(
                    x: self.swappedViewScale,
                    y: self.swappedViewScale
                )
                
                sourceVC.view.layer.cornerRadius = self.swappedViewCornerRadius
                
                // Destination
                
                let destinationTransform = self.halfBoundsTransform(
                    in: container,
                    direction: direction.inverted()
                )
                
                destinationVC.view.transform = destinationTransform.scaledBy(
                    x: self.swappedViewScale,
                    y: self.swappedViewScale
                )
                
                destinationVC.view.alpha = 1
                destinationVC.view.layer.cornerRadius = self.swappedViewCornerRadius
                
            }
            .then(.defaultSpring, duration: (self.duration * 0.6)) {

                container.bringSubviewToFront(destinationVC.view)

                sourceVC.view.alpha = self.coveredViewAlpha
                sourceVC.view.transform = .identity
                sourceVC.view.layer.cornerRadius = previousSourceCornerRadius

                destinationVC.view.transform = .identity
                destinationVC.view.layer.cornerRadius = previousDestinationCornerRadius

            }
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            sourceVC.view.clipsToBounds = previousSourceClipsToBound
            
            destinationVC.view.alpha = 1
            destinationVC.view.transform = .identity
            destinationVC.view.clipsToBounds = previousDestinationClipsToBounds
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
