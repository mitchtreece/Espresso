//
//  UIShuffleTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/27/18.
//

#if canImport(UIKit)

import UIKit
import SwiftUI

/// A shuffling view controller transition.
public class UIShuffleTransition: UIViewControllerTransition {
    
    /// The scale to apply to shuffled views while transitioning; _defaults to 0.95_.
    public var shuffleScale: CGFloat = 0.95
    
    /// The rotation angle to apply to shuffled views while transitioning; _defaults to degrees(6)_.
    public var shuffleAngle: Angle = .degrees(6)
    
    /// The corner radius to apply to shuffled views while transitioning; _defaults to 20_.
    public var shuffleCornerRadius: CGFloat = 20
    
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

                sourceVC.view.transform = self.halfBoundsTransform(
                    in: container,
                    direction: .left
                )
                .scaledBy(
                    x: self.shuffleScale,
                    y: self.shuffleScale
                )
                .rotated(
                    by: -self.shuffleAngle.radians
                )
                
                sourceVC.view.layer.cornerRadius = self.shuffleCornerRadius
                
                // Destination
                
                destinationVC.view.transform = self.halfBoundsTransform(
                    in: container,
                    direction: .right
                )
                .scaledBy(
                    x: self.shuffleScale,
                    y: self.shuffleScale
                )
                .rotated(
                    by: self.shuffleAngle.radians
                )
                
                destinationVC.view.alpha = 1
                destinationVC.view.layer.cornerRadius = self.shuffleCornerRadius
                
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

#endif
