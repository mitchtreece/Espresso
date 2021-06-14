//
//  UICoverTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A covering view controller transition.
public class UICoverTransition: UIViewControllerTransition {
    
    /// The covered view's alpha to animate to while transitioning; _defaults to 0.7_.
    public var coveredViewAlpha: CGFloat
    
    /// The amount to move the covered view while transitioning; _defaults to 0_.
    public var coveredViewParallaxAmount: CGFloat
    
    /// Initializes the transition with parameters.
    /// - Parameter coveredViewAlpha: The covered view's alpha to animate to while transitioning; _defaults to 0.7_.
    /// - Parameter coveredViewParallaxAmount: The amount to move the covered view while transitioning; _defaults to 0_.
    public init(coveredViewAlpha: CGFloat = 0.7,
                coveredViewParallaxAmount: CGFloat = 0) {
        
        self.coveredViewAlpha = coveredViewAlpha
        self.coveredViewParallaxAmount = coveredViewParallaxAmount
        
    }
    
    override public func animator(for transitionType: TransitionType,
                                  context ctx: Context) -> UIAnimationGroupAnimator {
        
        let isPresentation = (transitionType == .presentation)
        let settings = self.settings(for: transitionType)
        
        return isPresentation ?
            _present(with: ctx, settings: settings) :
            _dismiss(with: ctx, settings: settings)
        
    }
    
    private func _present(with ctx: Context, settings: Settings) -> UIAnimationGroupAnimator {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.transitionContainerView
        let context = ctx.context
        
        return UIAnimationGroupAnimator(setup: {
            
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: settings.direction.inverted()
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
    
    private func _dismiss(with ctx: Context, settings: Settings) -> UIAnimationGroupAnimator {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.transitionContainerView
        let context = ctx.context
        
        return UIAnimationGroupAnimator(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.alpha = self.coveredViewAlpha
            destinationVC.view.transform = self.translation(
                self.coveredViewParallaxAmount,
                direction: settings.direction.inverted()
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
