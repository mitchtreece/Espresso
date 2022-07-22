//
//  UIViewControllerTransition.swift
//  Espresso
//
//  Created by Mitch Treece on 6/26/18.
//

import UIKit

/// View controller transition base class.
@objc open class UIViewControllerTransition: NSObject,
                                             UIViewControllerTransitioningDelegate,
                                             UINavigationControllerDelegate {
    
    /// Transitioning context object containing the various attributes of a view controller transition.
    public struct Context {
        
        /// Representation of the various transition operations.
        public enum Operation {
            
            /// A presentation operation.
            case presentation
            
            /// A dismissal operation.
            case dismissal
            
        }
        
        /// The transition's operation.
        public private(set) var operation: Operation
        
        /// The transition's container view.
        public private(set) var containerView: UIView
        
        /// The transition's source (from) view controller.
        public private(set) var sourceViewController: UIViewController
        
        /// The transition's destination (to) view controller.
        public private(set) var destinationViewController: UIViewController
        
        /// The view controller transitioning context.
        public private(set) var context: UIViewControllerContextTransitioning
        
    }
    
    /// The transition's duration; _defaults to 0.6_.
    public var duration: TimeInterval = 0.6
    
    /// Flag indicating whether the transition should be performed interactively.
    public var isInteractive: Bool = false
    
    private var isPresentationControllerBacked: Bool {
        
        let fakeViewController = UIViewController()
        
        guard let _ = self.presentationController(
            forPresented: fakeViewController,
            presenting: nil,
            source: fakeViewController
        ) else { return false }
        
        return true
        
    }
    
    internal var modalPresentationStyle: UIModalPresentationStyle {
        return self.isPresentationControllerBacked ? .custom : .fullScreen
    }
    
    private var animator: UIViewControllerTransitionAnimator?
    private var interactor: UIViewControllerTransitionInteractor?
    
    // MARK: UIViewControllerTransitioningDelegate
    
    public func animationController(forPresented presented: UIViewController,
                                    presenting: UIViewController,
                                    source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if self.isInteractive {
                
            self.interactor = UIViewControllerTransitionInteractor(
                viewController: presented,
                navigationController: nil
            )
                
        }
        
        self.animator = UIViewControllerTransitionAnimator(transition: self)
        return self.animator
        
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        self.animator?.isPresentation = false
        return self.animator
        
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
                
                self.interactor = UIViewControllerTransitionInteractor(
                    viewController: toVC,
                    navigationController: navigationController
                )
                
            }
            
            self.animator = UIViewControllerTransitionAnimator(transition: self)
                
        }
        else if (operation == .pop) {
            self.animator?.isPresentation = false
        }

        return self.animator
        
    }
    
    public func navigationController(_ navigationController: UINavigationController,
                                     interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        guard let animationController = animationController as? UIViewControllerTransitionAnimator,
            !animationController.isPresentation else { return nil }
        
        guard let interactor = self.interactor,
            interactor.transitionInProgress else { return nil }
        
        return interactor
        
    }
    
    open func presentationController(forPresented presented: UIViewController,
                                     presenting: UIViewController?,
                                     source: UIViewController) -> UIPresentationController? {
        
        return nil
        
    }
    
    // MARK: Public
    
    /// Asks the transition for a `UIAnimationGroupController` containing one or more animations to run while transitioning.
    ///
    /// **This should not be called directly**. Instead, override this function within a `UIViewControllerTransition` subclass and provide custom animations.
    /// - parameter ctx: The transition's context.
    /// - returns: A new animation group controller.
    open func animations(using ctx: Context) -> UIAnimationGroupController {
        fatalError("UIViewControllerTransition subclasses must override animations(using:)")
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
