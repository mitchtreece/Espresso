//
//  UISlideTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public class UISlideTransition: UITransition {
    
    public override init() {
        
        super.init()
        self.presentation.duration = 0.6
        self.dismissal.duration = 0.6
        
    }
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        return _animate(with: info, settings: self.settings(for: transitionType))
    }
    
    private func _animate(with info: Info, settings: Settings) -> UITransitionController {
        
        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        destinationVC.view.frame = context.finalFrame(for: destinationVC)
        destinationVC.view.transform = self.boundsTransform(in: container, direction: settings.direction.reversed())
        container.addSubview(destinationVC.view)
        
        return UITransitionController(animations: {
            
            sourceVC.view.transform = self.boundsTransform(in: container, direction: settings.direction)
            destinationVC.view.transform = .identity
            
        }, completion: {
            
            sourceVC.view.transform = .identity
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
