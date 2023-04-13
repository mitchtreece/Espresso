//
//  UIGestureRecognizer+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/28/18.
//

import UIKit

public extension UIGestureRecognizer /* Actions */ {
    
    typealias Action = (UIGestureRecognizer)->()
    
    private struct AssociatedKeys {
        static var action: UInt8 = 0
    }
    
    private var action: Action? {
        
        get {
            guard let value = objc_getAssociatedObject(self, &AssociatedKeys.action) as? Action else { return nil }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &AssociatedKeys.action, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
    }
    
    /// Initializes a new gesture recognizer with an action handler.
    /// - Parameter action: The gesture recognizer's action handler.
    convenience init(action: @escaping Action) {
        
        self.init()
        self.action = action
        
        self.addTarget(
            self,
            action: #selector(handleAction(_:))
        )
        
    }
    
    @objc private func handleAction(_ recognizer: UIGestureRecognizer) {
        action?(self)
    }
    
}

public extension UIGestureRecognizer /* Cancel */ {
    
    /// Cancels the gesture recognizer.
    func cancel() {
        
        guard self.isEnabled else { return }
        
        self.isEnabled = false
        self.isEnabled = true
        
    }
    
}
