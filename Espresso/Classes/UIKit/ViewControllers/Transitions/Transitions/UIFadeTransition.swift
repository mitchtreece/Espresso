//
//  UIFadeTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A fading view controller transition.
public class UIFadeTransition: UIViewControllerTransition {

    /// Representation of various fading methods.
    public enum FadeType {
        
        /// A fade over the source view controller.
        case over
        
        /// A Crossfade between the source & destination view controllers.
        case cross
        
    }

    /// The transition's fade type; _defaults to over_.
    public var fadeType: FadeType = .over

    override public func animations(using ctx: Context) -> UIAnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        return UIAnimationGroupController(setup: {
            
            destinationVC.view.alpha = 0
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            UIAnimation(duration: self.duration) {
                
                if self.fadeType == .cross {
                    sourceVC.view.alpha = 0
                }
                
                destinationVC.view.alpha = 1
                
            }
            
        }, completion: {
                
            sourceVC.view.alpha = 1
            context.completeTransition(!context.transitionWasCancelled)
                
        })
        
    }
    
}
