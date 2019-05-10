//
//  UISlideTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/**
 A sliding view controller transition.
 */
public class UISlideTransition: UITransition {
    
    public var duration: TimeInterval
    
    /**
     Initializes the transition with parameters.
     - Parameter duration: The transition's animation duration; _defaults to 0.6_.
     */
    public init(duration: TimeInterval = 0.6) {
        self.duration = duration
    }
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {

        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        let settings = self.settings(for: transitionType)
        
        return UITransitionController(setup: {
            
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            destinationVC.view.transform = self.boundsTransform(
                in: container,
                direction: settings.direction.reversed()
            )
            
            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), duration: self.duration, {
                
                sourceVC.view.transform = self.boundsTransform(
                    in: container,
                    direction: settings.direction
                )
                
                destinationVC.view.transform = .identity
                
            })
            
        }, completion: {
                
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
                
        })

    }
    
}
