//
//  UIAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 6/28/18.
//

import UIKit

/// `UIAnimation` is a wrapper over `UIView` property animation.
///
/// ```
/// let view = UIView()
/// view.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
/// view.alpha = 0
///
/// UIAnimation {
///     view.alpha = 1
///     view.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
/// }.start()
/// ```
public class UIAnimation {
    
    /// An animation closure.
    public typealias Animations = ()->()
    
    /// An animation completion closure.
    public typealias Completion = ()->()
    
    /// Representation of the various animation timing curves.
    public enum TimingCurve {
        
        /// Representation of the various Material Design timing curves.
        public enum MaterialCurve {
            
            /// A standard Material Design timing curve.
            case standard
            
            /// An acceleration Material Design timing curve.
            case acceleration
            
            /// A deceleration Material Design timing curve.
            case deceleration
            
            internal var name: String {
                
                switch self {
                case .standard: return "standard"
                case .acceleration: return "acceleration"
                case .deceleration: return "deceleration"
                }
                
            }
            
            internal var controlPoints: (cp1: CGPoint, cp2: CGPoint) {
                
                switch self {
                case .standard: return (CGPoint(x: 0.4, y: 0), CGPoint(x: 0.2, y: 1))
                case .acceleration: return (CGPoint(x: 0.4, y: 0), CGPoint(x: 1, y: 1))
                case .deceleration: return (CGPoint(x: 0, y: 0), CGPoint(x: 0.2, y: 1))
                }
                
            }
            
        }
        
        /// A simple timing curve using one of the standard `UIView.AnimationCurve` types.
        case simple(UIView.AnimationCurve)
        
        /// A cubic bezier timing curve using two control points.
        case cubicBezier(cp1: CGPoint, cp2: CGPoint)
        
        /// A spring timing curve using a damping ratio & initial velocity.
        case spring(damping: CGFloat, velocity: CGFloat)
        
        /// A default spring timing curve using damping = 0.9, velocity = 0.2
        case defaultSpring
        
        /// A Material Design timing curve.
        case material(MaterialCurve)
        
        /// A custom timing curve using a given `UITimingCurveProvider`.
        case custom(UITimingCurveProvider)
        
    }
    
    /// The default duration for an animation.
    public static let defaultDuration: TimeInterval = 0.5
    
    /// The animation's timing curve.
    public private(set) var timingCurve: TimingCurve
    
    /// The animation's duration.
    public private(set) var duration: TimeInterval
    
    /// The animation's start delay.
    public private(set) var delay: TimeInterval
    
    /// The animation's animation closure.
    public private(set) var animations: Animations
    
    private var animator: UIViewPropertyAnimator?
    
    /// Initializes a new animation with the specified parameters.
    /// - Parameter timingCurve: The animation's timing curve; _defaults to simple(easeInOut)_.
    /// - Parameter duration: The animation's duration; _defaults to defaultDuration_.
    /// - Parameter delay: The animation's start delay; _defaults to 0_.
    /// - Parameter animations: The animation closure.
    /// - Returns: A new `Animation` instance.
    public init(_ timingCurve: TimingCurve = .simple(.easeInOut),
                duration: TimeInterval = UIAnimation.defaultDuration,
                delay: TimeInterval = 0,
                _ animations: @escaping Animations) {
        
        self.timingCurve = timingCurve
        self.duration = duration
        self.delay = delay
        self.animations = animations
        
    }
    
    /// Creates a new animation group containing the current animation,
    /// then appends a new animation with the specified parameters.
    /// - Parameter timingCurve: The animation's timing curve; _defaults to simple(easeInOut)_.
    /// - Parameter duration: The animation's duration; _defaults to defaultDuration_.
    /// - Parameter delay: The animation's start delay; _defaults to 0_.
    /// - Parameter animations: The animation closure.
    /// - Returns: A new `AnimationGroup` containing the current animation & chaining a new animation to the end.
    public func then(_ timingCurve: TimingCurve = .simple(.easeInOut),
                     duration: TimeInterval = UIAnimation.defaultDuration,
                     delay: TimeInterval = 0,
                     _ animations: @escaping Animations) -> UIAnimationGroup {
        
        let next = UIAnimation(
            timingCurve,
            duration: duration,
            delay: delay,
            animations
        )
        
        return UIAnimationGroup(animations: [
            self,
            next
        ])
        
    }

    /// Starts or resumes the animation.
    /// - Parameter completion: An optional completion closure; _defaults to nil_.
    public func start(completion: Completion? = nil) {
        
        if let animator = self.animator {
            
            animator.addCompletion { _ in
                completion?()
            }
            
            animator
                .startAnimation()
            
            return
            
        }

        var curve: UIView.AnimationCurve?
        var provider: UITimingCurveProvider?
        
        switch timingCurve {
        case .simple(let _curve): curve = _curve
        case .cubicBezier(let cp1, let cp2):
            
            provider = UICubicTimingParameters(
                controlPoint1: cp1,
                controlPoint2: cp2
            )
            
        case .spring(let damping, let velocity):
            
            provider = UISpringTimingParameters(
                dampingRatio: damping,
                initialVelocity: CGVector(
                    dx: velocity,
                    dy: velocity
                ))
            
        case .defaultSpring:
            
            provider = UISpringTimingParameters(
                dampingRatio: 0.9,
                initialVelocity: CGVector(
                    dx: 0.2,
                    dy: 0.2
                ))
            
        case .material(let easing):
            
            provider = UICubicTimingParameters(
                controlPoint1: easing.controlPoints.cp1,
                controlPoint2: easing.controlPoints.cp2
            )

        case .custom(let _provider):
            
            provider = _provider
            
        }
                
        if let curve = curve {
            
            self.animator = UIViewPropertyAnimator(
                duration: self.duration,
                curve: curve
            )
            
        }
        else if let provider = provider {
            
            self.animator = UIViewPropertyAnimator(
                duration: self.duration,
                timingParameters: provider
            )
                                    
        }
        
        self.animator?
            .addAnimations(self.animations)
        
        self.animator?.addCompletion { _ in
            completion?()
        }
        
        self.animator?
            .startAnimation(afterDelay: self.delay)

    }
    
    /// Pauses the animation.
    public func pause() {
        
        guard let animator = self.animator,
              animator.state == .active else { return }
        
        animator
            .pauseAnimation()
        
    }
    
    /// Stops the animation.
    /// - parameter finish: Flag indicating if the underlying animator should be told to finish; _defaults to false_.
    ///
    /// If the `finish` flag is `false`, the animator's finishing actions (i.e. completion closures) will **not** be called.
    /// You can manually call `finish(at:)` after calling `stop(finish: true)` if you want to manually invoke the animator's
    /// finishing actions.
    public func stop(finish: Bool = false) {
        
        guard let animator = self.animator,
              animator.state != .stopped else { return }
        
        animator
            .stopAnimation(!finish)
        
    }
    
    /// Finishes the animation.
    /// - parameter position: The position to set animation values to; _defaults to end_.
    ///
    /// This should only be called after calling `stop(finish: true)` to manually invoke the animator's finishing actions.
    public func finish(at position: UIViewAnimatingPosition = .end) {
        
        guard let animator = self.animator,
              animator.state == .stopped else { return }
        
        animator
            .finishAnimation(at: position)
        
    }
    
}

extension UIAnimation: UIAnimationGroupRepresentable {
    
    public func asAnimationGroup() -> UIAnimationGroup {
        return UIAnimationGroup(animations: [self])
    }
    
}

extension UIAnimation: CustomStringConvertible,
                       CustomDebugStringConvertible {
    
    public var description: String {
        
        var curveString: String
        
        switch timingCurve {
        case .simple(let curve):
            
            switch curve {
            case .linear: curveString = "simple(linear)"
            case .easeIn: curveString = "simple(easeIn)"
            case .easeOut: curveString = "simple(easeOut)"
            case .easeInOut: curveString = "simple(easeInOut)"
            @unknown default: curveString = "unknown"
            }
            
        case .cubicBezier(let cp1, let cp2): curveString = "cubicBezier(cp1: (\(cp1.x), \(cp1.y)), cp2: (\(cp2.x), \(cp2.y)))"
        case .spring(let damping, let velocity): curveString = "spring(damping: \(damping), velocity: \(velocity))"
        case .defaultSpring: curveString = "defaultSpring"
        case .material(let easing): curveString = "material(\(easing.name))"
        case .custom: curveString = "custom"
        }

        return "<Animation: \(curveString), duration: \(duration), delay: \(delay)>"
        
    }
    
    public var debugDescription: String {
        return self.description
    }
    
}
