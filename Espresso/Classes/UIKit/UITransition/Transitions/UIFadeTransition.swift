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
    public var duration: TimeInterval = 0.5
    
    public override func animationDuration(for context: UITransition.Context) -> TimeInterval {
        return duration
    }
    
    public override func presentationAnimation(inContainer container: UIView,
                                               fromVC: UIViewController,
                                               toVC: UIViewController,
                                               ctx: UIViewControllerContextTransitioning) {
        
        _animate(inContainer: container, fromVC: fromVC, toVC: toVC, ctx: ctx)
        
    }
    
    public override func dismissalAnimation(inContainer container: UIView,
                                            fromVC: UIViewController,
                                            toVC: UIViewController,
                                            ctx: UIViewControllerContextTransitioning) {
        
        _animate(inContainer: container, fromVC: fromVC, toVC: toVC, ctx: ctx)
        
    }
    
    private func _animate(inContainer container: UIView,
                          fromVC: UIViewController,
                          toVC: UIViewController,
                          ctx: UIViewControllerContextTransitioning) {
        
        toVC.view.alpha = 0
        toVC.view.frame = ctx.finalFrame(for: toVC)
        container.addSubview(toVC.view)
        
        UIView.animate(withDuration: animationDuration(for: .presentation), delay: 0, options: [.curveEaseOut], animations: {
            
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
