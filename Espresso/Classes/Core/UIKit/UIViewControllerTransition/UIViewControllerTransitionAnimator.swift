//
//  UIViewControllerTransitionAnimator.swift
//  Espresso
//
//  Created by Mitch Treece on 9/21/19.
//

import UIKit

internal class UIViewControllerTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private weak var transition: UIViewControllerTransition?
    private(set) var isPresentation = true
    
    init(transition: UIViewControllerTransition, presentation: Bool) {
        
        self.transition = transition
        self.isPresentation = presentation
        super.init()
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        guard let transition = self.transition else { return 0 }
        guard let transitionContext = transitionContext else { return 0 }
        guard let ctx = self.context(from: transitionContext) else { return 0 }
        
        return transition.animator(
            for: self.isPresentation ? .presentation : .dismissal,
            context: ctx
        )
        .duration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let transition = self.transition else { return transitionContext.completeTransition(true) }
        guard let ctx = self.context(from: transitionContext) else { return transitionContext.completeTransition(true) }
        
        let transitionType: UIViewControllerTransition.TransitionType = self.isPresentation ?
            .presentation :
            .dismissal
        
        transition.animator(
            for: transitionType,
            context: ctx
        )
        .run()
        
    }
    
    func context(from transitionContext: UIViewControllerContextTransitioning) -> UIViewControllerTransition.Context? {
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return nil }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return nil }
        
        return UIViewControllerTransition.Context(
            transitionContainerView: transitionContext.containerView,
            sourceViewController: fromVC,
            destinationViewController: toVC,
            context: transitionContext
        )
        
    }
    
}
