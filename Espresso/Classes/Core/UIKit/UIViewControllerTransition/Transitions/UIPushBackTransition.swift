//
//  UIPushBackTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A push-back view controller transition.
public class UIPushBackTransition: UIViewControllerTransition {
    
    /// The covered view controller's scale; _defaults to 0.8_.
    public var pushBackScale: CGFloat
    
    /// The covered view controller's alpha; _defaults to 0.3_.
    public var pushBackAlpha: CGFloat
    
    /// The covered view controller's corner radius; _defaults to 20_.
    public var roundedCornerRadius: CGFloat
    
    /// Initializes the transition with parameters.
    /// - Parameter pushBackScale: The covered view controller's scale; _defaults to 0.8_.
    /// - Parameter pushBackAlpha: The covered view controller's alpha; _defaults to 0.3_.
    /// - Parameter roundedCornerRadius: The covered view controller's corner radius; _defaults to 20_.
    public init(pushBackScale: CGFloat = 0.8,
                pushBackAlpha: CGFloat = 0.3,
                roundedCornerRadius: CGFloat = 20) {
        
        self.pushBackScale = pushBackScale
        self.pushBackAlpha = pushBackAlpha
        self.roundedCornerRadius = roundedCornerRadius
        
        super.init()
        
        self.presentation.direction = .up
        self.dismissal.direction = .down
        
    }
    
    override public func animator(for transitionType: TransitionType,
                                  context ctx: Context) -> UIAnimationGroupAnimator {
        
        let isPresentation = (transitionType == .presentation)
        let settings = self.settings(for: transitionType)
        
        return isPresentation ?
            _present(with: ctx, settings: settings) :
            _dismiss(with: ctx, settings: settings)
        
    }
    
    private func _present(with ctx: Context,
                          settings: Settings) -> UIAnimationGroupAnimator {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.transitionContainerView
        let context = ctx.context
        
        let previousClipsToBound = sourceVC.view.clipsToBounds
        let previousCornerRadius = sourceVC.view.layer.cornerRadius
        
        return UIAnimationGroupAnimator(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            
            container.addSubview(destinationVC.view)
            
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: settings.direction.inverted()
            )
            
            sourceVC.view.clipsToBounds = true
            
        }, animations: {
            
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), {
                sourceVC.view.layer.cornerRadius = self.roundedCornerRadius
                sourceVC.view.transform = CGAffineTransform(scaleX: self.pushBackScale, y: self.pushBackScale)
                sourceVC.view.alpha = self.pushBackAlpha
                destinationVC.view.transform = .identity
            })
            
        }, completion: {
            
            sourceVC.view.clipsToBounds = previousClipsToBound
            sourceVC.view.layer.cornerRadius = previousCornerRadius
            sourceVC.view.transform = .identity
            sourceVC.view.alpha = 1
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
    private func _dismiss(with ctx: Context, settings: Settings) -> UIAnimationGroupAnimator {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.transitionContainerView
        let context = ctx.context
        
        let previousClipsToBound = destinationVC.view.clipsToBounds
        let previousCornerRadius = destinationVC.view.layer.cornerRadius
        
        return UIAnimationGroupAnimator(setup: {
            
            destinationVC.view.alpha = self.pushBackAlpha
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.insertSubview(destinationVC.view, belowSubview: sourceVC.view)
            destinationVC.view.transform = CGAffineTransform(scaleX: self.pushBackScale, y: self.pushBackScale)
            
            destinationVC.view.layer.cornerRadius = self.roundedCornerRadius
            destinationVC.view.clipsToBounds = true
            
        }, animations: {
            
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), {
                sourceVC.view.transform = self.boundsTransform(in: container, direction: settings.direction)
                destinationVC.view.layer.cornerRadius = previousCornerRadius
                destinationVC.view.transform = .identity
                destinationVC.view.alpha = 1
            })
            
        }, completion: {
                
            destinationVC.view.clipsToBounds = previousClipsToBound
            context.completeTransition(!context.transitionWasCancelled)
                
        })
        
    }
    
}
