//
//  UIViewControllerTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// `UIViewControllerTransition` subclass that's backed by a `UIPresentationController`.
///
/// This class is used to determine if the transition should ask it's delegate
/// for a presentation controller to use while transitioning. Subclasses must return
/// a valid presentation controller from `presentationController(forPresented:presenting:source:)`.
open class UIPresentationControllerTransition: UIViewControllerTransition {
    
    open func presentationController(forPresented presented: UIViewController,
                                     presenting: UIViewController?,
                                     source: UIViewController) -> UIPresentationController? {
        
        fatalError("UIPresentationControllerTransition subclasses must override `presentationController(forPresented:presenting:)`")
        
    }
    
}

/// `UIViewControllerTransition` is a base class for custom view controller transitions.
@objc open class UIViewControllerTransition: NSObject, UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    /// Struct containing the various properties of a view controller transition.
    public struct Context {
        
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
    
    /// Fetches the transition's settings for a specified transition type.
    /// - returns: Transition settings for a specified transition type.
    func settings(for transitionType: TransitionType) -> Settings {
        return (transitionType == .presentation) ? self.presentation : self.dismissal
    }
        
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
        
        return UIViewControllerTransitionAnimator(
            transition: self,
            presentation: true
        )
        
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return UIViewControllerTransitionAnimator(
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
            
            return UIViewControllerTransitionAnimator(
                transition: self,
                presentation: true
            )
                
        }
        else if (operation == .pop) {
            
            return UIViewControllerTransitionAnimator(
                transition: self,
                presentation: false
            )
            
        }

        return nil
        
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let animationController = animationController as? UIViewControllerTransitionAnimator,
            !animationController.isPresentation else { return nil }
        
        guard let interactor = self.interactor,
            interactor.transitionInProgress else { return nil }
        
        return interactor
        
    }
    
    // MARK: Public
    
    /// Asks the transition for a `UIAnimationGroupController` containing one or more animations to run while transitioning.
    ///
    /// **This should not be called directly**. Instead, override this function within a `UIViewControllerTransition` subclass and provide custom animations.
    /// - parameter transitionType: The transition's type.
    /// - parameter context: The transition's context.
    /// - returns: A new animation group controller.
    open func animations(for transitionType: TransitionType,
                         context ctx: Context) -> UIAnimationGroupController {
        
        fatalError("UIViewControllerTransition subclasses must override animations(for:context:)")

    }
    
}

public extension UIViewControllerTransition /* Helpers */ {
    
    /// Calculates a bounds translation-transform in a given view.
    /// - parameter container: The view.
    /// - parameter direction: The direction of the transform.
    /// - parameter offset: An optional offset to apply to the translation; _defaults to 0_.
    /// - returns: A bounds translated `CGAffineTransform`.
    func boundsTransform(in container: UIView,
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
    func halfBoundsTransform(in container: UIView,
                             direction: Direction,
                             offsetBy offset: CGFloat = 0) -> CGAffineTransform {
        
        let transform = boundsTransform(in: container, direction: direction, offsetBy: offset)
        return CGAffineTransform(translationX: (transform.tx / 2), y: (transform.ty / 2))
        
    }
    
    /// Calculates a bounds translation-transform in a given view.
    /// - parameter amount: The translation amount.
    /// - parameter direction: The direction of the transform.
    /// - returns: A translation `CGAffineTransform`.
    func translation(_ amount: CGFloat,
                     direction: Direction) -> CGAffineTransform {
        
        switch direction {
        case .up: return CGAffineTransform(translationX: 0, y: -amount)
        case .down: return CGAffineTransform(translationX: 0, y: amount)
        case .left: return CGAffineTransform(translationX: -amount, y: 0)
        case .right: return CGAffineTransform(translationX: amount, y: 0)
        }
        
    }
    
}
