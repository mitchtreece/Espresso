//
//  SlideTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A sliding view controller transition.
public class SlideTransition: ViewControllerDirectionalTransition {
    
    override public func animations(using ctx: Context) -> AnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        let direction = ctx.operation == .presentation ?
            self.presentationDirection :
            self.dismissalDirection
        
        return AnimationGroupController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: direction.inverted()
            )
            
            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            Animation(.defaultSpring, duration: self.duration) {
                
                sourceVC.view.transform = self.boundsTransform(
                    in: container,
                    direction: direction
                )
                
                destinationVC.view.transform = .identity
                
            }
            
        }, completion: {
                
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
                
        })

    }
    
}
