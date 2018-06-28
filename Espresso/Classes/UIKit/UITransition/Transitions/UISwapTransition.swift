//
//  UISwapTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/27/18.
//

import Foundation

public class UISwapTransition: UITransition {
    
    public var swapScale: CGFloat = 0.9
    public var swapAlpha: CGFloat = 0.7
    public var roundedCornerRadius: CGFloat = 10
    
    public override init() {
        
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
        let options = UITransitionAnimationOptions.default(duration: 0.45, options: [.curveEaseInOut])
        
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
            
        }, animations: [
            
            UITransitionAnimation({
                
                let sourceTransform = self.halfBoundsTransform(in: container, direction: settings.direction)
                sourceVC.view.transform = sourceTransform.scaledBy(x: self.swapScale, y: self.swapScale)
                sourceVC.view.layer.cornerRadius = self.roundedCornerRadius
                //sourceVC.view.alpha = self.swapAlpha
                
                let destinationTransform = self.halfBoundsTransform(in: container, direction: settings.direction.reversed())
                destinationVC.view.transform = destinationTransform.scaledBy(x: self.swapScale, y: self.swapScale)
                destinationVC.view.layer.cornerRadius = self.roundedCornerRadius
                destinationVC.view.alpha = 1
                
            }, options: options),
            
            UITransitionAnimation({
                
                container.bringSubview(toFront: destinationVC.view)
                
                sourceVC.view.alpha = self.swapAlpha
                sourceVC.view.transform = .identity
                sourceVC.view.layer.cornerRadius = previousSourceCornerRadius
                
                destinationVC.view.transform = .identity
                destinationVC.view.layer.cornerRadius = previousDestinationCornerRadius
                
            }, options: options)
            
        ], completion: {
            
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            sourceVC.view.clipsToBounds = previousSourceClipsToBound
            
            destinationVC.view.transform = .identity
            destinationVC.view.clipsToBounds = previousDestinationClipsToBounds
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
