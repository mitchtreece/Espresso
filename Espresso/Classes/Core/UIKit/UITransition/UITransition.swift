//
//  UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/**
 `UITransition` is a base class for custom view controller transitions.
 */
@objc open class UITransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    /**
     Struct containing the various properties of a view controller transition.
     */
    public struct Info {
        
        /**
         The transition's container view.
         */
        public private(set) var transitionContainerView: UIView
        
        /**
         The transition's source (from) view controller.
         */
        public private(set) var sourceViewController: UIViewController
        
        /**
         The transition's destination (to) view controller.
         */
        public private(set) var destinationViewController: UIViewController
        
        /**
         The transitioning context.
         */
        public private(set) var context: UIViewControllerContextTransitioning
        
    }
    
    /**
     Representation of the different transition types.
     */
    public enum TransitionType {
        
        /// A presentation transition type.
        case presentation
        
        /// A dismissal transition type.
        case dismissal
        
    }
    
    /**
     Representation of the different 2D directions.
     */
    public enum Direction {
        
        /// The upwards direction
        case up
        
        /// The downwards direction
        case down
        
        /// The left direction
        case left
        
        /// The right direction
        case right
        
        /**
         Helper function that returns the current direction's opposite.
         
         `up <-> down`
         
         `left <-> right`
         */
        func reversed() -> Direction {
            
            switch self {
            case .up: return .down
            case .down: return .up
            case .left: return .right
            case .right: return .left
            }
            
        }
        
    }
    
    /**
     Representation of the different view controller types.
     */
    public enum ViewControllerType {
        
        /// The source (from) view controller type.
        case source
        
        /// The destination (to) view controller type.
        case destination
        
    }
    
    /**
     Struct containing the various configuration options for a view controller transition.
     */
    public struct Settings {
        
        /**
         The transitional direction.
         */
        public var direction: Direction
        
        /**
         Helper function that returns the default transition settings for a specified type.
         
         - Parameter transitionType: The desired transition type.
         - Returns: Default transition settings for a specified transition type.
         */
        public static func `default`(for transitionType: TransitionType) -> Settings {
            
            let isPresentation = (transitionType == .presentation)
            return Settings(direction: isPresentation ? .left : .right)
            
        }
        
    }
    
    // MARK: Settings
    
    /**
     The transition's presentation settings.
     */
    public var presentation = Settings.default(for: .presentation)
    
    /**
     The transition's dismissal settings.
     */
    public var dismissal = Settings.default(for: .dismissal)
    
    /**
     Helper function that returns the transition's settings for a specified type.
     
     - Returns: Transition settings for a specified transition type.
     */
    public func settings(for transitionType: TransitionType) -> Settings {
        return (transitionType == .presentation) ? presentation : dismissal
    }
    
    // MARK: Interactive

    /**
     Flag indicating whether the transition should be performed interactively.
     */
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
                                     animationControllerFor operation: UINavigationController.Operation,
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
    
    /**
     Asks the transition for a `UITransitionController` containing one or more animations to run while transitioning.
     
     **This should not be called directly**. Instead, override this function within a `UITransition` subclass and provide custom animations.
     
     - Parameter transitionType: The transition's type.
     - Parameter info: The transition's info.
     - Returns: A `UITransitionController` containing animations to run while transitioning between source & destination view controllers.
     */
    open func transitionController(for transitionType: TransitionType, info: Info) -> UITransitionController {
        
        // Override me
        
        let container = info.transitionContainerView
        let destinationVC = info.destinationViewController
        let finalFrame = info.context.finalFrame(for: destinationVC)
        
        return UITransitionController(setup: nil, animations: {
            
            UIAnimation(.spring(damping: 0.9, velocity: CGVector(dx: 0.25, dy: 0)), {
                container.addSubview(destinationVC.view)
                destinationVC.view.frame = finalFrame
            })
            
        }, completion: {
            
            info.context.completeTransition(!info.context.transitionWasCancelled)
            
        })
        
    }
    
    // MARK: Helpers
    
    /**
     Calculates a bounds translation-transform in a given view.
     - Parameter container: The view.
     - Parameter direction: The direction of the transform.
     - Parameter offset: An optional offset to apply to the translation; _defaults to 0_.
     - Returns: A bounds translated `CGAffineTransform`.
     */
    public func boundsTransform(in container: UIView,
                                direction: Direction,
                                offsetBy offset: CGFloat = 0) -> CGAffineTransform {
        
        switch direction {
        case .up: return CGAffineTransform(translationX: 0, y: -container.bounds.height + offset)
        case .down: return CGAffineTransform(translationX: 0, y: container.bounds.height + offset)
        case .left: return CGAffineTransform(translationX: -container.bounds.width + offset, y: 0)
        case .right: return CGAffineTransform(translationX: container.bounds.width + offset, y: 0)
        }
        
    }
    
    /**
     Calculates a half-bounds translation-transform in a given view.
     - Parameter container: The view.
     - Parameter direction: The direction of the transform.
     - Parameter offset: An optional offset to apply to the translation; _defaults to 0_.
     - Returns: A half-bounds translated `CGAffineTransform`.
     */
    public func halfBoundsTransform(in container: UIView,
                                    direction: Direction,
                                    offsetBy offset: CGFloat = 0) -> CGAffineTransform {
        
        let transform = boundsTransform(in: container, direction: direction, offsetBy: offset)
        return CGAffineTransform(translationX: (transform.tx / 2), y: (transform.ty / 2))
        
    }
    
    /**
     Calculates a bounds translation-transform in a given view.
     - Parameter amount: The translation amount.
     - Parameter direction: The direction of the transform.
     - Returns: A translation `CGAffineTransform`.
     */
    public func translation(_ amount: CGFloat, direction: Direction) -> CGAffineTransform {
        
        switch direction {
        case .up: return CGAffineTransform(translationX: 0, y: -amount)
        case .down: return CGAffineTransform(translationX: 0, y: amount)
        case .left: return CGAffineTransform(translationX: -amount, y: 0)
        case .right: return CGAffineTransform(translationX: amount, y: 0)
        }
        
    }
    
}

private class UITransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
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
            controller.setup?()
        }
        
        controller.group.run {
            controller.completion()
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
