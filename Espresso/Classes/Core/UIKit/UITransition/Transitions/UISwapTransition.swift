//
//  UISwapTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/27/18.
//

import Foundation

/**
 A swapping view controller transition.
 */
public class UISwapTransition: UITransition {
    
    /**
     The source & destination view controller's scale; _defaults to 1_.
     */
    public var swapScale: CGFloat
    
    /**
     The covered view controller's alpha; _defaults to 0.6_.
     */
    public var swapAlpha: CGFloat
    
    /**
     The source & destination view controller's corner radius; _defaults to 10_.
     */
    public var roundedCornerRadius: CGFloat
    
    /**
     Initializes the transition with parameters.
     - Parameter swapScale: The source & destination view controller's scale; _defaults to 1_.
     - Parameter swapAlpha: The covered view controller's alpha; _defaults to 0.6_.
     - Parameter roundedCornerRadius: The source & destination view controller's corner radius; _defaults to 10_.
     */
    public init(swapScale: CGFloat = 1, swapAlpha: CGFloat = 0.6, roundedCornerRadius: CGFloat = 10) {
        
        self.swapScale = swapScale
        self.swapAlpha = swapAlpha
        self.roundedCornerRadius = roundedCornerRadius
        
        super.init()
        
        self.presentation.direction = .left
        self.dismissal.direction = .left
        
    }
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        
        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        let settings = self.settings(for: transitionType)
        
        let previousSourceClipsToBound = sourceVC.view.clipsToBounds
        let previousSourceCornerRadius = sourceVC.view.layer.cornerRadius
        
        let previousDestinationClipsToBounds = destinationVC.view.clipsToBounds
        let previousDestinationCornerRadius = destinationVC.view.layer.cornerRadius
        
        return UITransitionController(setup: {
            
            sourceVC.view.clipsToBounds = true
            destinationVC.view.clipsToBounds = true
            destinationVC.view.alpha = self.swapAlpha
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.insertSubview(destinationVC.view, belowSubview: sourceVC.view)
            
        }, animations: {
            
            UIAnimation(duration: 0.3, {
                
                let sourceTransform = self.halfBoundsTransform(in: container, direction: settings.direction)
                sourceVC.view.transform = sourceTransform.scaledBy(x: self.swapScale, y: self.swapScale)
                sourceVC.view.layer.cornerRadius = self.roundedCornerRadius
                
                let destinationTransform = self.halfBoundsTransform(in: container, direction: settings.direction.reversed())
                destinationVC.view.transform = destinationTransform.scaledBy(x: self.swapScale, y: self.swapScale)
                destinationVC.view.layer.cornerRadius = self.roundedCornerRadius
                destinationVC.view.alpha = 1
                
            }).then(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), duration: 0.4, {
                
                container.bringSubviewToFront(destinationVC.view)
                
                sourceVC.view.alpha = self.swapAlpha
                sourceVC.view.transform = .identity
                sourceVC.view.layer.cornerRadius = previousSourceCornerRadius
                
                destinationVC.view.transform = .identity
                destinationVC.view.layer.cornerRadius = previousDestinationCornerRadius
                
            })
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            sourceVC.view.clipsToBounds = previousSourceClipsToBound
            
            destinationVC.view.transform = .identity
            destinationVC.view.clipsToBounds = previousDestinationClipsToBounds
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
