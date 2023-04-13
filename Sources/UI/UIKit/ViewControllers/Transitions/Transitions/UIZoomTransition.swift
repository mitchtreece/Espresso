//
//  UIZoomTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 5/10/19.
//

import UIKit

/// A zooming view controller transition.
public class UIZoomTransition: UIViewControllerTransition {
    
    /// The scale to apply to the zoomed view while transitioning; _defaults to 0.9_.
    public var zoomedViewScale: CGFloat = 0.9
    
    public override func animations(using ctx: Context) -> UIAnimationGroupController {
                
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        let isPresentation = (ctx.operation == .presentation)
        
        return UIAnimationGroupController(setup: {
            
            if isPresentation {
                
                destinationVC.view.alpha = 0
                destinationVC.view.frame = context.finalFrame(for: destinationVC)
                destinationVC.view.clipsToBounds = true
                container.addSubview(destinationVC.view)
                
                destinationVC.view.transform = CGAffineTransform(
                    scaleX: self.zoomedViewScale,
                    y: self.zoomedViewScale
                )
                
            }
            else {
                
                destinationVC.view.frame = context.finalFrame(for: destinationVC)
                container.insertSubview(
                    destinationVC.view,
                    belowSubview: sourceVC.view
                )
                
            }
            
        }, animations: {
            
            UIAnimation(.defaultSpring, duration: self.duration) {
                
                if isPresentation {
                    
                    destinationVC.view.alpha = 1
                    destinationVC.view.layer.cornerRadius = 0
                    destinationVC.view.transform = .identity
                    
                }
                else {
                    
                    let scaleAddition = ((1 - self.zoomedViewScale) / 3)
                    let adjustedScale = (self.zoomedViewScale + scaleAddition)
                    
                    sourceVC.view.alpha = 0
                    sourceVC.view.transform = CGAffineTransform(
                        scaleX: adjustedScale,
                        y: adjustedScale
                    )
                    
                }
                
            }
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
