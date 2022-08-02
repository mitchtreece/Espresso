//
//  CustomTransition.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 6/27/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class CustomTransition: ViewControllerTransition {
    
    override func animations(using ctx: ViewControllerTransition.Context) -> AnimationGroupController {
        
        let destinationVC = ctx.destinationViewController
        let container = ctx.containerView
        let context = ctx.context
        
        return AnimationGroupController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            destinationVC.view.alpha = 0
            container.addSubview(destinationVC.view)
            
        }, animations: {
        
            Animation(.defaultSpring) {
                destinationVC.view.transform = .identity
                destinationVC.view.alpha = 1
            }
            
        }, completion: {
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
