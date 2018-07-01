//
//  UIFadeTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public class UIFadeTransition: UITransition {

    public enum FadeType {
        case over
        case cross
    }
    
    public var fadeType: FadeType = .over
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        
        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        return UITransitionController(setup: {
            
            destinationVC.view.alpha = 0
            destinationVC.view.frame = context.finalFrame(for: destinationVC)
            container.addSubview(destinationVC.view)
            
        }, animations: {
            
            UIAnimation {
                
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
