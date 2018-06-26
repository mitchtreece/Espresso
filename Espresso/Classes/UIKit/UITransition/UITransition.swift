//
//  UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

@objc public class UITransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    public enum Context {
        case presentation
        case dismissal
    }

    public var isInteractive: Bool = true
    private var interactor: UITransitionInteractionController?
    
    // MARK: Duration
    
    public func animationDuration(for context: Context) -> TimeInterval {
        return 0.5
    }
    
    // MARK: Modal
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
            if isInteractive {
                interactor = UITransitionInteractionController(viewController: presented, navigationController: nil)
            }
        
            return UITransitionAnimator(transition: self, presentation: true)
        
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return UITransitionAnimator(transition: self, presentation: false)
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactor
    }
    
    // MARK: Navigation
    
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationControllerOperation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
            if (operation == .push) {
                
                if isInteractive {
                    interactor = UITransitionInteractionController(viewController: toVC, navigationController: navigationController)
                }
            
                return UITransitionAnimator(transition: self, presentation: true)
                
            }
            else if (operation == .pop) {
                return UITransitionAnimator(transition: self, presentation: false)
            }

            return nil
        
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let animationController = animationController as? UITransitionAnimator, !animationController.isPresentation else { return nil }
        guard let interactor = interactor, interactor.transitionInProgress else { return nil }
        return interactor
        
    }
    
    // MARK: Public
    
    public func presentationAnimation(inContainer container: UIView,
                                      fromVC: UIViewController,
                                      toVC: UIViewController,
                                      ctx: UIViewControllerContextTransitioning) {
        // Override me
    }
    
    public func dismissalAnimation(inContainer container: UIView,
                                   fromVC: UIViewController,
                                   toVC: UIViewController,
                                   ctx: UIViewControllerContextTransitioning) {
        // Override me
    }
    
}

fileprivate class UITransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private weak var transition: UITransition?
    private(set) var isPresentation = true
    
    init(transition: UITransition, presentation: Bool) {
        self.transition = transition
        self.isPresentation = presentation
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        
        let presentationDuration = transition?.animationDuration(for: .presentation) ?? 0
        let dismissalDuration = transition?.animationDuration(for: .dismissal) ?? 0
        return isPresentation ? presentationDuration : dismissalDuration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let container = transitionContext.containerView
        
        if isPresentation {
            presentationAnimation(inContainer: container, fromVC: fromVC, toVC: toVC, ctx: transitionContext)
        }
        else {
            dismissalAnimation(inContainer: container, fromVC: fromVC, toVC: toVC, ctx: transitionContext)
        }
        
    }
    
    private func presentationAnimation(inContainer container: UIView,
                                       fromVC: UIViewController,
                                       toVC: UIViewController,
                                       ctx: UIViewControllerContextTransitioning) {
        
        transition?.presentationAnimation(inContainer: container, fromVC: fromVC, toVC: toVC, ctx: ctx)
        
    }
    
    private func dismissalAnimation(inContainer container: UIView,
                                    fromVC: UIViewController,
                                    toVC: UIViewController,
                                    ctx: UIViewControllerContextTransitioning) {
        
        transition?.dismissalAnimation(inContainer: container, fromVC: fromVC, toVC: toVC, ctx: ctx)
        
    }
    
}
