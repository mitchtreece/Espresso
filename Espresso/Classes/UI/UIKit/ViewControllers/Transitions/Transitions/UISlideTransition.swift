//
//  UISlideTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// A sliding view controller transition.
public class UISlideTransition: UIViewControllerDirectionalTransition {
    
    public override func animations(using ctx: Context) -> UIAnimationGroupController {
        
        let sourceVC = ctx.sourceViewController
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        let direction = ctx.operation == .presentation ?
            self.presentationDirection :
            self.dismissalDirection
        
        return UIAnimationGroupController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: direction.inverted()
            )
            
            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            UIAnimation(.defaultSpring, duration: self.duration) {
                
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
