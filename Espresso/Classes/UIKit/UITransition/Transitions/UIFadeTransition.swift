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
    
    public override func presentationAnimation(inContainer container: UIView,
                                               fromVC: UIViewController,
                                               toVC: UIViewController,
                                               ctx: UIViewControllerContextTransitioning) {
        
        _animate(inContainer: container, fromVC: fromVC, toVC: toVC, ctx: ctx, presentationContext: .presentation)
        
    }
    
    public override func dismissalAnimation(inContainer container: UIView,
                                            fromVC: UIViewController,
                                            toVC: UIViewController,
                                            ctx: UIViewControllerContextTransitioning) {
        
        _animate(inContainer: container, fromVC: fromVC, toVC: toVC, ctx: ctx, presentationContext: .dismissal)
        
    }
    
    private func _animate(inContainer container: UIView,
                          fromVC: UIViewController,
                          toVC: UIViewController,
                          ctx: UIViewControllerContextTransitioning,
                          presentationContext: PresentationContext) {
        
        let settings = self.settings(for: presentationContext)
        
        toVC.view.alpha = 0
        toVC.view.frame = ctx.finalFrame(for: toVC)
        container.addSubview(toVC.view)
        
        UIView.animate(withDuration: settings.duration,
                       delay: settings.delay,
                       usingSpringWithDamping: settings.springDamping,
                       initialSpringVelocity: settings.springVelocity,
                       options: settings.animationOptions,
                       animations: {
                   
                        if self.fadeType == .cross {
                            fromVC.view.alpha = 0
                        }
                        
                        toVC.view.alpha = 1
                        
        }) { (finished) in
            
            fromVC.view.alpha = 1
            ctx.completeTransition(!ctx.transitionWasCancelled)
            
        }
        
    }
    
}
