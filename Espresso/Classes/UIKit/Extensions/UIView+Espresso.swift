//
//  UIView+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

extension UIView: StaticIdentifiable {}

public extension UIView /* Corners */ {
    
    /// Masks the view's corners using a radius.
    /// - Parameter corners: The corners to mask; _defaults to all_.
    /// - Parameter radius: The corner radius.
    func roundCorners(_ corners: UIRectCorner = .allCorners,
                      radius: CGFloat) {
        
        self.layer.maskedCorners = corners.cornerMask
        self.layer.cornerRadius = radius
        
    }
    
    /// Rounds the view's corners using a radius & curve.
    /// - Parameter corners: The corners to mask; _defaults to all_.
    /// - Parameter radius: The corner radius.
    /// - Parameter curve: The corner curve; _defaults to circular_.
    @available(iOS 13, *)
    func roundCorners(_ corners: UIRectCorner = .allCorners,
                      radius: CGFloat,
                      curve: CALayerCornerCurve = .circular) {
        
        self.layer.maskedCorners = corners.cornerMask
        self.layer.cornerRadius = radius
        self.layer.cornerCurve = curve
        
    }
    
}

public extension UIView /* Shadow */ {
    
    /// Draws a drop-shadow on the view's layer with specified parameters.
    /// - Parameter color: The shadow color; _defaults to black_.
    /// - Parameter radius: The shadow radius; _defaults to 6_.
    /// - Parameter opacity: The shadow opacity; _defaults to 0.2_.
    /// - Parameter offset: The shadow offset; _defaults to zero_.
    /// - Parameter path: The optional shadow path.
    func drawShadow(color: UIColor = .black,
                           radius: CGFloat = 6,
                           opacity: CGFloat = 0.2,
                           offset: CGSize = .zero,
                           path: CGPath? = nil) {
        
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Float(opacity)
        self.layer.shadowOffset = offset
        self.layer.shadowPath = path
        
    }
    
}

public extension UIView /* Gestures */ {
    
    /// Adds a tap gesture recognizer to the receiver.
    /// - parameter setup: An optional `UITapGestureRecognizer` setup block.
    /// - parameter action: The gesture recognizer's action handler.
    func addTapGesture(setup: ((UITapGestureRecognizer)->())? = nil,
                       action: @escaping UIGestureRecognizer.Action) {
        
        let recognizer = UITapGestureRecognizer(action: action)
        setup?(recognizer)
        addGestureRecognizer(recognizer)
                
    }
    
    /// Adds a long-press gesture recognizer to the receiver.
    /// - parameter setup: An optional `UILongPressGestureRecognizer` setup block.
    /// - parameter action: The gesture recognizer's action handler.
    func addLongPressGesture(setup: ((UILongPressGestureRecognizer)->())? = nil,
                             action: @escaping UIGestureRecognizer.Action) {
        
        let recognizer = UILongPressGestureRecognizer(action: action)
        setup?(recognizer)
        addGestureRecognizer(recognizer)
        
    }
    
}

public extension UIView /* Motion */ {
    
    /// Adds an accelerometer-based parallax motion effect to the view.
    /// - Parameter:
    func addParallaxMotionEffect(movement: CGVector) {
        
        var effects = [UIInterpolatingMotionEffect]()
        var verticalEffect: UIInterpolatingMotionEffect?
        var horizontalEffect: UIInterpolatingMotionEffect?

        if movement.dy > 0 {
            
            verticalEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            verticalEffect!.minimumRelativeValue = -movement.dy
            verticalEffect!.maximumRelativeValue = movement.dy
            effects.append(verticalEffect!)
            
        }
        
        if movement.dx > 0 {
            
            horizontalEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            horizontalEffect!.minimumRelativeValue = -movement.dx
            horizontalEffect!.maximumRelativeValue = movement.dx
            effects.append(horizontalEffect!)
            
        }
        
        guard effects.count > 0 else { return }
        
        let group = UIMotionEffectGroup()
        group.motionEffects = effects
        addMotionEffect(group)
        
    }
    
    /// Removes all motion effects from the view.
    func removeAllMotionEffects() {
        
        self.motionEffects
            .forEach { self.removeMotionEffect($0) }
        
    }
    
}

public extension UIView /* Subviews */ {
    
    /// Removes all subviews from the view.
    func removeAllSubviews() {
        self.subviews.forEach { $0.removeFromSuperview() }
    }
    
}

public extension UIView /* Nib Loading */ {
    
    private struct AssociatedKeys {
        static var nibs: UInt8 = 0
    }
    
    /// Load's a view from a nib with a specified name & bundle. If no name is provided, the class name will be used.
    /// If no bundle is provided, the main bundle will be used.
    ///
    /// - Parameter name: The nib's name.
    /// - Parameter bundle: The bundle to load the nib from.
    /// - Returns: A typed nib-loaded view instance.
    static func loadFromNib(name: String? = nil, bundle: Bundle = Bundle.main) -> Self {
        
        return _loadFromNib(
            name: name,
            bundle: bundle
        )
        
    }
    
    private class func _loadFromNib<T: UIView>(name: String?, bundle: Bundle) -> T {
        
        let name = name ?? String(describing: self)
        
        return bundle.loadNibNamed(
            name,
            owner: self,
            options: nil
        )!.first! as! T
        
    }
    
    private var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    private static func _nibLoadingAssociatedNibWithName(_ name: String) -> UINib? {
        
        let nibs = objc_getAssociatedObject(self, &AssociatedKeys.nibs) as? NSDictionary
        var nib: UINib? = nibs?.object(forKey: name) as? UINib
        
        if (nib == nil) {
            
            nib = UINib(nibName: name, bundle: nil)
            
            let updatedAssociatedNibs = NSMutableDictionary()
            
            if (nibs != nil) {
                updatedAssociatedNibs.addEntries(from: nibs! as! [String: UINib])
            }
            
            updatedAssociatedNibs.setObject(nib!, forKey: name as NSCopying)
            objc_setAssociatedObject(self, &AssociatedKeys.nibs, updatedAssociatedNibs, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            
        }
        
        return nib
        
    }
    
    /// Load's a view's contents from a nib with a specified name. If no name is provided, the class name will be used.
    /// - Parameter name: The nib's name.
    func loadContentsFromNib(name: String? = nil) {
        
        let _name = name ?? self.className
        
        if let nib = type(of: self)._nibLoadingAssociatedNibWithName(_name) {
            
            let views = nib.instantiate(withOwner: self, options: nil) as NSArray
            assert(views.count == 1, "There must be exactly one root container view in \(_name)")
            
            let containerView = views.firstObject as! UIView
            
            assert(containerView.isKind(of: UIView.self) || containerView.isKind(of: type(of: self)), "UIView - The container view in nib \(_name) should be a UIView instead of \(containerView.className).")
            
            containerView.translatesAutoresizingMaskIntoConstraints = false
            
            if self.bounds.equalTo(CGRect.zero) {
                // `self` has no size : use the containerView's size, from the nib file
                self.bounds = containerView.bounds
            }
            else {
                // `self` has a specific size : resize the containerView to this size, so that the subviews are autoresized.
                containerView.bounds = self.bounds
            }
            
            // Save constraints for later
            let constraints = containerView.constraints
            
            // Reparent the subviews from the nib file
            for view in containerView.subviews {
                self.addSubview(view)
            }
            
            // Re-add constraints, replace containerView with self
            for constraint in constraints {
                
                var firstItem: Any = constraint.firstItem!
                var secondItem: Any? = constraint.secondItem
                
                if firstItem as? NSObject == containerView {
                    firstItem = self
                }
                
                if secondItem as? NSObject == containerView {
                    secondItem = self
                }
                
                // Re-add
                let _constraint = NSLayoutConstraint(item: firstItem,
                                                     attribute: constraint.firstAttribute,
                                                     relatedBy: constraint.relation,
                                                     toItem: secondItem,
                                                     attribute: constraint.secondAttribute,
                                                     multiplier: constraint.multiplier,
                                                     constant: constraint.constant)
                
                self.addConstraint(_constraint)
                
            }
            
        }
        else {
            assert(false, "UIView: error loading nib: \(_name)")
        }
        
    }
    
}
