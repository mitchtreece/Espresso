//
//  UIFadeTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A fading view controller transition.
public class UIFadeTransition: UIViewControllerTransition {

    /// Representation of different fading methods.
    public enum FadeType {
        
        /// Fade over the source view controller
        case over
        
        /// Crossfade between the source & destination view controllers
        case cross
        
    }
    
    /// The transition's duration; _defaults to 0.6_.
    public var duration: TimeInterval
    
    /// The transition's fade type; _defaults to over_.
    public var fadeType: FadeType
    
    /// Initializes the transition with parameters.
    /// - Parameter duration: The transition's animation duration; _defaults to 0.6_.
    /// - Parameter fadeType: The transition's fade type; _defaults to over_.
    public init(duration: TimeInterval = 0.6,
                fadeType: FadeType = .over) {
        
        self.duration = duration
        self.fadeType = fadeType
        
    }
    
    override public func animations(for transitionType: TransitionType,
                                    context ctx: Context) -> UIAnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.transitionContainerView
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
