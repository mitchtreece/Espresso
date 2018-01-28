//
//  UIView+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

// MARK: Motion Effects

public extension UIView {
    
    public func addParallaxMotionEffect(horizontalMovement: CGFloat, verticalMovement: CGFloat) {
        
        var effects = [UIInterpolatingMotionEffect]()
        var verticalEffect: UIInterpolatingMotionEffect?
        var horizontalEffect: UIInterpolatingMotionEffect?

        if verticalMovement > 0 {
            
            verticalEffect = UIInterpolatingMotionEffect(keyPath: "center.y", type: .tiltAlongVerticalAxis)
            verticalEffect!.minimumRelativeValue = -verticalMovement
            verticalEffect!.maximumRelativeValue = verticalMovement
            effects.append(verticalEffect!)
            
        }
        
        if horizontalMovement > 0 {
            
            horizontalEffect = UIInterpolatingMotionEffect(keyPath: "center.x", type: .tiltAlongHorizontalAxis)
            horizontalEffect!.minimumRelativeValue = -horizontalMovement
            horizontalEffect!.maximumRelativeValue = horizontalMovement
            effects.append(horizontalEffect!)
            
        }
        
        guard effects.count > 0 else { return }
        
        let group = UIMotionEffectGroup()
        group.motionEffects = effects
        self.addMotionEffect(group)
        
    }
    
}

// MARK: Nib

public extension UIView {
    
    private struct AssociatedKeys {
        static var nibs: UInt8 = 0
    }
    
    static func loadFromNib(name: String? = nil) -> Self {
        return _loadFromNib(name: name)
    }
    
    private class func _loadFromNib<T: UIView>(name: String? = nil) -> T {
        
        let name = name ?? String(describing: self)
        return Bundle.main.loadNibNamed(name, owner: self, options: nil)![0] as! T
        
    }
    
    fileprivate var className: String {
        return NSStringFromClass(type(of: self)).components(separatedBy: ".").last!
    }
    
    fileprivate static func _nibLoadingAssociatedNibWithName(_ name: String) -> UINib? {
        
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
    
    public func loadContentsFromNib() {
        loadContentsFromNib(name: self.className)
    }
    
    public func loadContentsFromNib(name: String) {
        
        let nib = type(of: self)._nibLoadingAssociatedNibWithName(name)
        
        if let nib = nib {
            
            let views = nib.instantiate(withOwner: self, options: nil) as NSArray
            assert(views.count == 1, "There must be exactly one root container view in \(name)")
            
            let containerView = views.firstObject as! UIView
            
            assert(containerView.isKind(of: UIView.self) || containerView.isKind(of: type(of: self)), "UIView - The container view in nib \(name) should be a UIView instead of \(containerView.className).")
            
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
            assert(nib != nil, "UIView - Can't load nib: \(name)")
        }
        
    }
    
}
