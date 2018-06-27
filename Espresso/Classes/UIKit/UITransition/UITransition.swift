//
//  UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

@objc public class UITransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    public enum PresentationContext {
        case presentation
        case dismissal
    }
    
    public enum Direction {
        
        case up
        case down
        case left
        case right
        
        func reversed() -> Direction {
            
            switch self {
            case .up: return .down
            case .down: return .up
            case .left: return .right
            case .right: return .left
            }
            
        }
        
    }
    
    public enum ViewControllerContext {
        case source
        case destination
    }
    
    public struct Settings {
        
        public var duration: TimeInterval
        public var direction: Direction
        public var delay: TimeInterval
        public var springDamping: CGFloat
        public var springVelocity: CGFloat
        public var animationOptions: UIViewAnimationOptions
        
        static func `default`(for context: PresentationContext) -> Settings {
            
            let isPresentation = (context == .presentation)
            
            return Settings(duration: 0.6,
                            direction: isPresentation ? .left : .right,
                            delay: 0,
                            springDamping: 0.9,
                            springVelocity: 0.25,
                            animationOptions: [.curveEaseInOut])
            
        }
        
    }
    
    // MARK: Settings
    
    public var presentation = Settings.default(for: .presentation)
    public var dismissal = Settings.default(for: .dismissal)
    
    public func settings(for context: PresentationContext) -> Settings {
        return (context == .presentation) ? presentation : dismissal
    }
    
    // MARK: Interactive

    public var isInteractive: Bool = false
    private var interactor: UITransitionInteractionController?
    
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
    
    // MARK: Helpers
    
    internal func boundsTransform(in container: UIView, direction: Direction) -> CGAffineTransform {
        
        switch direction {
        case .up: return CGAffineTransform(translationX: 0, y: -container.bounds.height)
        case .down: return CGAffineTransform(translationX: 0, y: container.bounds.height)
        case .left: return CGAffineTransform(translationX: -container.bounds.width, y: 0)
        case .right: return CGAffineTransform(translationX: container.bounds.width, y: 0)
        }
        
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
        
        let presentationDuration = transition?.presentation.duration ?? 0
        let dismissalDuration = transition?.dismissal.duration ?? 0
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
