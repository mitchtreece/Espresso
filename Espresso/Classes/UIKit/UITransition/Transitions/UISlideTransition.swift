//
//  UISlideTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public class UISlideTransition: UITransition {
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {

        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        let settings = self.settings(for: transitionType)
        
        return UITransitionController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.transform = self.boundsTransform(in: container, direction: settings.direction.reversed())
            container.addSubview(destinationVC.view)
            
        }, animations: [
            
            UITransitionAnimation {
                sourceVC.view.transform = self.boundsTransform(in: container, direction: settings.direction)
                destinationVC.view.transform = .identity
            }
            
        ], completion: {
                
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
                
        })

    }
    
}
