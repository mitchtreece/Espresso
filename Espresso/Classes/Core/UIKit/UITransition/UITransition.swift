//
//  UITransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// `UITransition` subclass that's backed by a `UIPresentationController`.
///
/// This class is used to determine if the transition should ask it's delegate
/// for a presentation controller to use while transitioning. Subclasses must return
/// a valid presentation controller from `presentationController(forPresented:presenting:source:)`.
open class UIPresentationTransition: UITransition {
    
    public func presentationController(forPresented presented: UIViewController,
                                       presenting: UIViewController?,
                                       source: UIViewController) -> UIPresentationController? {
        fatalError("")
    }
    
}

/// `UITransition` is a base class for custom view controller transitions.
@objc open class UITransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    /// Struct containing the various properties of a view controller transition.
    public struct Info {
        
        /// The transition's container view.
        public private(set) var transitionContainerView: UIView
        
        /// The transition's source (from) view controller.
        public private(set) var sourceViewController: UIViewController
        
        /// The transition's destination (to) view controller.
        public private(set) var destinationViewController: UIViewController
        
        /// The transitioning context.
        public private(set) var context: UIViewControllerContextTransitioning
        
    }
    
    /// Representation of the different transition types.
    public enum TransitionType {
        
        /// A presentation transition type.
        case presentation
        
        /// A dismissal transition type.
        case dismissal
        
    }
    
    /// Representation of the different 2D directions.
    public enum Direction {
        
        /// The upwards direction
        case up
        
        /// The downwards direction
        case down
        
        /// The left direction
        case left
        
        /// The right direction
        case right
        
        /// Helper function that returns the current direction's reversed direction.
        ///
        /// `up <-> down`
        ///
        /// `left <-> right`
        func reversed() -> Direction {
            
            switch self {
            case .up: return .down
            case .down: return .up
            case .left: return .right
            case .right: return .left
            }
            
        }
        
    }
    
    /// Representation of the different view controller types.
    public enum ViewControllerType {
        
        /// The source (from) view controller type.
        case source
        
        /// The destination (to) view controller type.
        case destination
        
    }
    
    /// Struct containing the various configuration options for a view controller transition.
    public struct Settings {
        
        /// The transitional direction.
        public var direction: Direction
        
        /// Helper function that returns the default transition settings for a specified type.
        /// - parameter transitionType: The desired transition type.
        /// - returns: Default transition settings for a specified transition type.
        public static func `default`(for transitionType: TransitionType) -> Settings {
            
            let isPresentation = (transitionType == .presentation)
            return Settings(direction: isPresentation ? .left : .right)
            
        }
        
    }
    
    /// The transition's presentation settings.
    public var presentation = Settings.default(for: .presentation)
    
    /// The transition's dismissal settings.
    public var dismissal = Settings.default(for: .dismissal)
    
    /// Flag indicating whether the transition should be performed interactively.
    public var isInteractive: Bool = false
    private var interactor: UITransitionInteractionController?
    
    /// An optional modal presentation style to be set on the destination view controller
    /// before the transition is performed.
    public var modalPresentationStyleOverride: UIModalPresentationStyle?
        
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if self.isInteractive {
                
            self.interactor = UITransitionInteractionController(
                viewController: presented,
                navigationController: nil
            )
                
        }
        
        return UITransitionAnimator(
            transition: self,
            presentation: true
        )
        
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return UITransitionAnimator(
            transition: self,
            presentation: false
        )
        
    }
    
    public func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return nil
    }
    
    public func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactor
    }
        
    public func navigationController(_ navigationController: UINavigationController,
                                     animationControllerFor operation: UINavigationController.Operation,
                                     from fromVC: UIViewController,
                                     to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if (operation == .push) {
                
            if self.isInteractive {
                
                self.interactor = UITransitionInteractionController(
                    viewController: toVC,
                    navigationController: navigationController
                )
                
            }
            
            return UITransitionAnimator(transition: self, presentation: true)
                
        }
        else if (operation == .pop) {
            
            return UITransitionAnimator(
                transition: self,
                presentation: false
            )
            
        }

        return nil
        
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let animationController = animationController as? UITransitionAnimator,
            !animationController.isPresentation else { return nil }
        
        guard let interactor = self.interactor,
            interactor.transitionInProgress else { return nil }
        
        return interactor
        
    }
    
    // MARK: Public
    
    /// Asks the transition for a `UITransitionController` containing one or more animations to run while transitioning.
    ///
    /// **This should not be called directly**. Instead, override this function within a `UITransition` subclass and provide custom animations.
    /// - parameter transitionType: The transition's type.
    /// - parameter info: The transition's info.
    /// - returns: A `UITransitionController` containing animations to run while transitioning between source & destination view controllers.
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
    
    /// Fetches the transition's settings for a specified transition type.
    /// - returns: Transition settings for a specified transition type.
    public func settings(for transitionType: TransitionType) -> Settings {
        return (transitionType == .presentation) ? self.presentation : self.dismissal
    }
    
    /// Calculates a bounds translation-transform in a given view.
    /// - parameter container: The view.
    /// - parameter direction: The direction of the transform.
    /// - parameter offset: An optional offset to apply to the translation; _defaults to 0_.
    /// - returns: A bounds translated `CGAffineTransform`.
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
    
    /// Calculates a half-bounds translation-transform in a given view.
    /// - parameter container: The view.
    /// - parameter direction: The direction of the transform.
    /// - parameter offset: An optional offset to apply to the translation; _defaults to 0_.
    /// - returns: A half-bounds translated `CGAffineTransform`.
    public func halfBoundsTransform(in container: UIView,
                                    direction: Direction,
                                    offsetBy offset: CGFloat = 0) -> CGAffineTransform {
        
        let transform = boundsTransform(in: container, direction: direction, offsetBy: offset)
        return CGAffineTransform(translationX: (transform.tx / 2), y: (transform.ty / 2))
        
    }
    
    /// Calculates a bounds translation-transform in a given view.
    /// - parameter amount: The translation amount.
    /// - parameter direction: The direction of the transform.
    /// - returns: A translation `CGAffineTransform`.
    public func translation(_ amount: CGFloat, direction: Direction) -> CGAffineTransform {
        
        switch direction {
        case .up: return CGAffineTransform(translationX: 0, y: -amount)
        case .down: return CGAffineTransform(translationX: 0, y: amount)
        case .left: return CGAffineTransform(translationX: -amount, y: 0)
        case .right: return CGAffineTransform(translationX: amount, y: 0)
        }
        
    }
    
}
