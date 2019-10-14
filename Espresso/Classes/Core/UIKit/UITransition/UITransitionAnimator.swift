//
//  UITransitionAnimator.swift
//  Espresso
//
//  Created by Mitch Treece on 9/21/19.
//

import UIKit

internal class UITransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private weak var transition: UITransition?
    private(set) var isPresentation = true
    
    init(transition: UITransition, presentation: Bool) {
        
        self.transition = transition
        self.isPresentation = presentation
        super.init()
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        guard let transition = transition else { return 0 }
        guard let context = transitionContext else { return 0 }
        guard let info = self.info(from: context) else { return 0 }
        
        return transition.transitionController(
            for: self.isPresentation ? .presentation : .dismissal,
            info: info
        ).animationDuration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let transition = self.transition else { return transitionContext.completeTransition(true) }
        guard let info = self.info(from: transitionContext) else { return transitionContext.completeTransition(true) }
        
        let transitionType: UITransition.TransitionType = isPresentation ? .presentation : .dismissal
        let controller = transition.transitionController(for: transitionType, info: info)
        
        UIView.performWithoutAnimation {
            controller.setup?()
        }
        
        controller.group.run {
            controller.completion()
        }
        
    }
    
    func info(from context: UIViewControllerContextTransitioning) -> UITransition.Info? {
        
        guard let fromVC = context.viewController(forKey: .from) else { return nil }
        guard let toVC = context.viewController(forKey: .to) else { return nil }
        
        return UITransition.Info(
            transitionContainerView: context.containerView,
            sourceViewController: fromVC,
            destinationViewController: toVC,
            context: context
        )
        
    }
    
}
