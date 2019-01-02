//
//  UICoverTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/**
 A covering view controller transition.
 */
public class UICoverTransition: UITransition {
    
    /**
     The covered view's alpha to animate to while transitioning; _defaults to 0.7_.
     */
    public var coveredViewAlpha: CGFloat
    
    /**
     The amount to move the covered view while transitioning; _defaults to 0_.
     */
    public var coveredViewParallaxAmount: CGFloat
    
    /**
     Initializes the transition with parameters.
     - Parameter coveredViewAlpha: The covered view's alpha to animate to while transitioning; _defaults to 0.7_.
     - Parameter coveredViewParallaxAmount: The amount to move the covered view while transitioning; _defaults to 0_.
     */
    public init(coveredViewAlpha: CGFloat = 0.7, coveredViewParallaxAmount: CGFloat = 0) {
        self.coveredViewAlpha = coveredViewAlpha
        self.coveredViewParallaxAmount = coveredViewParallaxAmount
    }
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        
        let isPresentation = (transitionType == .presentation)
        let settings = self.settings(for: transitionType)
        return isPresentation ? _present(with: info, settings: settings) : _dismiss(with: info, settings: settings)
        
    }
    
    private func _present(with info: Info, settings: Settings) -> UITransitionController {
        
        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        return UITransitionController(setup: {
            
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: settings.direction.reversed()
            )
            
            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), {
                
                sourceVC.view.alpha = self.coveredViewAlpha
                sourceVC.view.transform = self.translation(
                    self.coveredViewParallaxAmount,
                    direction: settings.direction
                )
                
                destinationVC.view.transform = .identity
                
            })
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
    private func _dismiss(with info: Info, settings: Settings) -> UITransitionController {
        
        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        return UITransitionController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.alpha = self.coveredViewAlpha
            destinationVC.view.transform = self.translation(
                self.coveredViewParallaxAmount,
                direction: settings.direction.reversed()
            )
            
            container.insertSubview(destinationVC.view, belowSubview: sourceVC.view)
            
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
                
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
                
        })
        
    }
    
}
