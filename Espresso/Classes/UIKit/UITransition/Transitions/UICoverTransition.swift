//
//  UICoverTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public class UICoverTransition: UITransition {
    
    public var coverAlpha: CGFloat = 0.7
    
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
        
        if presentationContext == .presentation {
            
            toVC.view.frame = ctx.finalFrame(for: toVC)
            toVC.view.transform = self.boundsTransform(in: container, direction: settings.direction.reversed())
            container.addSubview(toVC.view)
            
        }
        else {
            
            toVC.view.frame = ctx.finalFrame(for: toVC)
            toVC.view.alpha = coverAlpha
            container.insertSubview(toVC.view, belowSubview: fromVC.view)
            
        }
        
        UIView.animate(withDuration: settings.duration,
                       delay: settings.delay,
                       usingSpringWithDamping: settings.springDamping,
                       initialSpringVelocity: settings.springVelocity,
                       options: settings.animationOptions,
                       animations: {
                        
                        if presentationContext == .presentation {
                            
                            fromVC.view.alpha = self.coverAlpha
                            toVC.view.transform = .identity
                            
                        }
                        else {
                            
                            fromVC.view.transform = self.boundsTransform(in: container, direction: settings.direction)
                            toVC.view.alpha = 1
                            
                        }
                        
        }) { (finished) in
            
            fromVC.view.alpha = 1
            fromVC.view.transform = .identity
            ctx.completeTransition(!ctx.transitionWasCancelled)
            
        }
        
    }
    
}
