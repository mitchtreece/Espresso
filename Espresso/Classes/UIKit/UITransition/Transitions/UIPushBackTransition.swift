//
//  UIPushBackTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

public class UIPushBackTransition: UITransition {
    
    public var pushBackScale: CGFloat = 0.8
    public var pushBackAlpha: CGFloat = 0.3
    
    public override func presentationAnimation(inContainer container: UIView,
                                               fromVC: UIViewController,
                                               toVC: UIViewController,
                                               ctx: UIViewControllerContextTransitioning) {
        
        toVC.view.frame = ctx.finalFrame(for: toVC)
        container.addSubview(toVC.view)
        toVC.view.transform = CGAffineTransform(translationX: 0, y: container.bounds.height)
        
        UIView.animate(withDuration: self.presentation.duration,
                       delay: 0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.25,
                       options: [.curveEaseInOut],
                       animations: {
                      
                        fromVC.view.transform = CGAffineTransform(scaleX: self.pushBackScale, y: self.pushBackScale)
                        fromVC.view.alpha = self.pushBackAlpha
                        toVC.view.transform = .identity
                        
        }) { (finished) in
            
            fromVC.view.transform = .identity
            fromVC.view.alpha = 1
            ctx.completeTransition(!ctx.transitionWasCancelled)
            
        }
        
    }
    
    public override func dismissalAnimation(inContainer container: UIView,
                                            fromVC: UIViewController,
                                            toVC: UIViewController,
                                            ctx: UIViewControllerContextTransitioning) {
        
        toVC.view.alpha = pushBackAlpha
        toVC.view.frame = ctx.finalFrame(for: toVC)
        container.insertSubview(toVC.view, belowSubview: fromVC.view)
        toVC.view.transform = CGAffineTransform(scaleX: pushBackScale, y: pushBackScale)
        
        UIView.animate(withDuration: self.dismissal.duration,
                       delay: 0,
                       usingSpringWithDamping: 0.9,
                       initialSpringVelocity: 0.25,
                       options: [.curveEaseInOut], animations: {
            
                        fromVC.view.transform = CGAffineTransform(translationX: 0, y: container.bounds.height)
                        toVC.view.transform = .identity
                        toVC.view.alpha = 1
                        
        }) { (finished) in
            
            ctx.completeTransition(!ctx.transitionWasCancelled)
            
        }
        
    }
    
}
