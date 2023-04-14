//
//  CustomTransition.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit
import EspressoUI

class CustomTransition: UIViewControllerTransition {
    
    override func animations(using ctx: UIViewControllerTransition.Context) -> UIAnimationGroupController {
        
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        return UIAnimationGroupController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            destinationVC.view.alpha = 0
            container.addSubview(destinationVC.view)
            
        }, animations: {
        
            UIAnimation(.defaultSpring) {
                destinationVC.view.transform = .identity
                destinationVC.view.alpha = 1
            }
            
        }, completion: {
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
