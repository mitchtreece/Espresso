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
    
    public override init() {
        
        super.init()
        
        self.presentation.springDamping = 1
        self.presentation.springVelocity = 1
        
        self.dismissal.springDamping = 1
        self.dismissal.springVelocity = 1
        
    }
    
    override public func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        return _animate(with: info, settings: self.settings(for: transitionType))
    }
    
    private func _animate(with info: Info, settings: Settings) -> UITransitionController {
        
        let sourceVC = info.sourceViewController
        let destinationVC = info.destinationViewController
        let container = info.transitionContainerView
        let context = info.context
        
        destinationVC.view.alpha = 0
        destinationVC.view.frame = context.finalFrame(for: destinationVC)
        container.addSubview(destinationVC.view)
        
        return UITransitionController(animations: {
            
            if self.fadeType == .cross {
                sourceVC.view.alpha = 0
            }
            
            destinationVC.view.alpha = 1
            
        }, completion: {
            
            sourceVC.view.alpha = 1
            context.completeTransition(!context.transitionWasCancelled)
            
        })
        
    }
    
}
