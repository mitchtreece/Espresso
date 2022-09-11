//
//  UIView+SafeAreaInsetsDidChange.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit

internal extension UIView {
    
    typealias Handler = ()->()
    
    static var swizzled = false
    
    var onSafeAreaInsetsDidChange: Handler? {
        get {
            return associatedObject(forKey: "onSafeAreaInsetsDidChange") as? Handler
        }
        set {
            
            Self.swizzleSafeAreaInsetsDidChangeIfNeeded()
            
            setAssociatedObject(
                newValue,
                forKey: "onSafeAreaInsetsDidChange"
            )
            
        }
    }
    
    
    static func swizzleSafeAreaInsetsDidChangeIfNeeded() {
        
        guard swizzled == false else { return }
        
        swizzle(
            method: "safeAreaInsetsDidChange",
            selector: #selector(originalSafeAreaInsetsDidChange),
            newSelector: #selector(swizzledSafeAreaInsetsDidChange),
            forClass: Self.self
        )
        
        swizzled = true
        
    }
    
    @objc func originalSafeAreaInsetsDidChange() {
        // Original implementaion will be copied here.
    }
    
    @objc func swizzledSafeAreaInsetsDidChange() {
        
        originalSafeAreaInsetsDidChange()
        onSafeAreaInsetsDidChange?()
        
    }
    
}
