//
//  UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

@objc open class UITransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    public typealias VoidBlock = ()->()
    public typealias UITransitionController = (animations: VoidBlock, completion: VoidBlock)
    
    public struct Info {
        
        public private(set) var transitionContainerView: UIView
        public private(set) var sourceViewController: UIViewController
        public private(set) var destinationViewController: UIViewController
        public private(set) var context: UIViewControllerContextTransitioning
        
    }
    
    public enum TransitionType {
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
    
    public enum ViewControllerType {
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
        
        public static func `default`(for transitionType: TransitionType) -> Settings {
            
            let isPresentation = (transitionType == .presentation)
            
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
    
    public func settings(for transitionType: TransitionType) -> Settings {
        return (transitionType == .presentation) ? presentation : dismissal
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
    
    open func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        
        // Override me
        
        let container = info.transitionContainerView
        let destinationVC = info.destinationViewController
        let finalFrame = info.context.finalFrame(for: destinationVC)
        
        return UITransitionController(animations: {
            
            container.addSubview(destinationVC.view)
            destinationVC.view.frame = finalFrame
            
        }, completion: {
            
            info.context.completeTransition(!info.context.transitionWasCancelled)
            
        })
        
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
        
        guard let transition = transition else { return transitionContext.completeTransition(true) }
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        let container = transitionContext.containerView
        
        let transitionType: UITransition.TransitionType = isPresentation ? .presentation : .dismissal
        let info = UITransition.Info(transitionContainerView: container,
                                     sourceViewController: fromVC,
                                     destinationViewController: toVC,
                                     context: transitionContext)
        
        let controller = transition.transitionController(for: transitionType, info: info)
        let settings = transition.settings(for: transitionType)
        
        UIView.animate(withDuration: settings.duration,
                       delay: settings.delay,
                       usingSpringWithDamping: settings.springDamping,
                       initialSpringVelocity: settings.springVelocity,
                       options: settings.animationOptions,
                       animations: {
                        
                        controller.animations()
                        
        }) { (finished) in
            
            controller.completion()
            
        }
        
    }
    
}
