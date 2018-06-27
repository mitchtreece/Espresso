//
//  CustomTransition.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 6/27/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class CustomTransition: UITransition {
    
    override init() {
        
        super.init()
        self.presentation.duration = 0.7
        self.dismissal.duration = 0.7
        
    }
    
    override func transitionController(for transitionType: UITransition.TransitionType, info: UITransition.Info) -> UITransition.UITransitionController {
        
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        // Setup
        
        destinationVC.view.frame = context.finalFrame(for: destinationVC)
        destinationVC.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        destinationVC.view.alpha = 0
        container.addSubview(destinationVC.view)
        
        return UITransitionController(animations: {
            
            // Animations
            
            destinationVC.view.transform = .identity
            destinationVC.view.alpha = 1
            
        }, completion: {
            
            // Completion
            
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
