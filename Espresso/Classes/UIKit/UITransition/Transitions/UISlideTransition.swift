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
        
        self.presentation.duration = 0.3
        self.presentation.direction = .left
        
        self.dismissal.duration = 0.3
        self.dismissal.direction = self.presentation.direction.reversed()
        
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
        
        let direction = self.settings(for: presentationContext).direction
        
        toVC.view.frame = ctx.finalFrame(for: toVC)
        toVC.view.transform = self.boundsTransform(in: container, direction: direction.reversed())
        container.addSubview(toVC.view)
        
        UIView.animate(withDuration: self.dismissal.duration, delay: 0, options: [.curveEaseInOut], animations: {

            fromVC.view.transform = self.boundsTransform(in: container, direction: direction)
            toVC.view.transform = .identity
            
        }) { (finished) in
            
            fromVC.view.transform = .identity
            ctx.completeTransition(!ctx.transitionWasCancelled)
            
        }
        
    }
    
}
