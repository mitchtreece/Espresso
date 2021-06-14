//
//  CustomTransition.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 6/27/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class CustomTransition: UIViewControllerTransition {
    
    override func animator(for transitionType: UIViewControllerTransition.TransitionType,
                           context ctx: UIViewControllerTransition.Context) -> UIAnimationGroupAnimator {
        
        let destinationVC = ctx.destinationViewController
        let container = ctx.transitionContainerView
        let context = ctx.context
        
        return UIAnimationGroupAnimator(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            destinationVC.view.alpha = 0
            container.addSubview(destinationVC.view)
            
        }, animations: {
        
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), {
                destinationVC.view.transform = .identity
                destinationVC.view.alpha = 1
            })
            
        }, completion: {
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
