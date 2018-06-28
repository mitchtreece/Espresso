//
//  UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

@objc open class UITransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    public typealias VoidBlock = ()->()
    
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
        
        public var direction: Direction
        
        public static func `default`(for transitionType: TransitionType) -> Settings {
            
            let isPresentation = (transitionType == .presentation)
            return Settings(direction: isPresentation ? .left : .right)
            
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
        
        return UITransitionController(setup: {
            
            // None
            
        }, animations: [
            
            UITransitionAnimation({
                container.addSubview(destinationVC.view)
                destinationVC.view.frame = finalFrame
            })
            
        ], completion: {
            
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
    
    internal func halfBoundsTransform(in container: UIView, direction: Direction) -> CGAffineTransform {
        
        let transform = boundsTransform(in: container, direction: direction)
        return CGAffineTransform(translationX: (transform.tx / 2), y: (transform.ty / 2))
        
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
        
        guard let transition = transition else { return 0 }
        guard let context = transitionContext else { return 0 }
        guard let info = self.info(from: context) else { return 0 }
        
        return transition.transitionController(for: isPresentation ? .presentation : .dismissal,
                                               info: info).animationDuration
        
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let transition = transition else { return transitionContext.completeTransition(true) }
        guard let info = self.info(from: transitionContext) else { return transitionContext.completeTransition(true) }
        
        let transitionType: UITransition.TransitionType = isPresentation ? .presentation : .dismissal
        let controller = transition.transitionController(for: transitionType, info: info)
        
        UIView.performWithoutAnimation {
            controller.setup()
        }
        
        let queue = UITransitionAnimationQueue()
        
        for i in 0..<controller.animations.count {

            let animation = controller.animations[i]
            let operation = UITransitionAnimationOperation(animation: animation, index: i)
            queue.addOperation(operation)
            
        }
        
        queue.operations.completion {
            
            DispatchQueue.main.async {
                controller.completion()
            }
            
        }
        
    }
    
    func info(from context: UIViewControllerContextTransitioning) -> UITransition.Info? {
        
        guard let fromVC = context.viewController(forKey: .from) else { return nil }
        guard let toVC = context.viewController(forKey: .to) else { return nil }
        
        return UITransition.Info(transitionContainerView: context.containerView,
                                 sourceViewController: fromVC,
                                 destinationViewController: toVC,
                                 context: context)
        
    }
    
}
