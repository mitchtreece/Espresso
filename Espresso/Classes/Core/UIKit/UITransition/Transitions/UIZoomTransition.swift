//
//  UIZoomTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 5/10/19.
//

import UIKit

/**
 A zooming view controller transition.
 */
public class UIZoomTransition: UITransition {
    
    /// The transition's duration; _defaults to 0.6_.
    public var duration: TimeInterval
    
    /// The transition's zoom scale; _defaults to 0.8_.
    public var scale: CGFloat
    
    /// The corner radius to apply to the animating view controller; _defaults to 20_.
    public var cornerRadius: CGFloat
    
    /**
     Initializes the transition with parameters.
     - Parameter duration: The transition's animation duration; _defaults to 0.6_.
     - Parameter scale: The transition's zoom scale; _defaults to 0.8_.
     - Parameter cornerRadius: The corner radius to apply to the animating view controller; _defaults to 20_.
     */
    public init(duration: TimeInterval = 0.6, scale: CGFloat = 0.8, cornerRadius: CGFloat = 20) {
        
        self.duration = duration
        self.scale = scale
        self.cornerRadius = cornerRadius
        
    }
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        
        let isPresentation = (transitionType == .presentation)
        
        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        return UITransitionController(setup: {
            
            if isPresentation {
                
                destinationVC.view.alpha = 0
                destinationVC.view.frame = context.finalFrame(for: destinationVC)
                destinationVC.view.transform = CGAffineTransform(scaleX: self.scale, y: self.scale)
                destinationVC.view.layer.cornerRadius = self.cornerRadius
                destinationVC.view.clipsToBounds = true
                container.addSubview(destinationVC.view)
                
            }
            else {
                
                destinationVC.view.frame = context.finalFrame(for: destinationVC)
                container.insertSubview(destinationVC.view, belowSubview: sourceVC.view)
                
            }
            
        }, animations: {
            
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), duration: self.duration, {
                
                if isPresentation {
                    
                    destinationVC.view.alpha = 1
                    destinationVC.view.layer.cornerRadius = 0
                    destinationVC.view.transform = .identity
                    
                }
                else {
                    
                    let scaleAddition = ((1 - self.scale) / 3)
                    let adjustedScale = (self.scale + scaleAddition)
                    
                    sourceVC.view.alpha = 0
                    sourceVC.view.layer.cornerRadius = self.cornerRadius
                    sourceVC.view.transform = CGAffineTransform(scaleX: adjustedScale, y: adjustedScale)
                    
                }
                
            })
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
