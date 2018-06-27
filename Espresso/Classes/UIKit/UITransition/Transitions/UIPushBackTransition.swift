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
    public var roundedCornerRadius: CGFloat = 20
    
    public override init() {
        
        super.init()
        self.presentation.direction = .up
        self.dismissal.direction = .down
        
    }
    
    public override func presentationAnimation(inContainer container: UIView,
                                               fromVC: UIViewController,
                                               toVC: UIViewController,
                                               ctx: UIViewControllerContextTransitioning) {
        
        toVC.view.frame = ctx.finalFrame(for: toVC)
        container.addSubview(toVC.view)
        toVC.view.transform = self.boundsTransform(in: container, direction: self.presentation.direction.reversed())
        
        let previousClipsToBound = fromVC.view.clipsToBounds
        let previousCornerRadius = fromVC.view.layer.cornerRadius
        fromVC.view.clipsToBounds = true
        
        UIView.animate(withDuration: self.presentation.duration,
                       delay: self.presentation.delay,
                       usingSpringWithDamping: self.presentation.springDamping,
                       initialSpringVelocity: self.presentation.springVelocity,
                       options: self.presentation.animationOptions,
                       animations: {
                      
                        fromVC.view.layer.cornerRadius = self.roundedCornerRadius
                        fromVC.view.transform = CGAffineTransform(scaleX: self.pushBackScale, y: self.pushBackScale)
                        fromVC.view.alpha = self.pushBackAlpha
                        
                        toVC.view.transform = .identity
                        
        }) { (finished) in
            
            fromVC.view.clipsToBounds = previousClipsToBound
            fromVC.view.layer.cornerRadius = previousCornerRadius
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
        
        let previousClipsToBound = toVC.view.clipsToBounds
        let previousCornerRadius = toVC.view.layer.cornerRadius
        toVC.view.layer.cornerRadius = roundedCornerRadius
        toVC.view.clipsToBounds = true
        
        UIView.animate(withDuration: self.dismissal.duration,
                       delay: self.dismissal.delay,
                       usingSpringWithDamping: self.dismissal.springDamping,
                       initialSpringVelocity: self.dismissal.springVelocity,
                       options: self.dismissal.animationOptions,
                       animations: {
            
                        fromVC.view.transform = self.boundsTransform(in: container, direction: self.dismissal.direction)
                        
                        toVC.view.layer.cornerRadius = previousCornerRadius
                        toVC.view.transform = .identity
                        toVC.view.alpha = 1
                        
        }) { (finished) in
            
            toVC.view.clipsToBounds = previousClipsToBound
            ctx.completeTransition(!ctx.transitionWasCancelled)
            
        }
        
    }
    
}
