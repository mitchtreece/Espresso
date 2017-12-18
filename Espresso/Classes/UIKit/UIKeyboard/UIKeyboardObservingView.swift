//
//  UIKeyboardObservingView.swift
//  Espresso
//
//  Created by Mitch Treece on 12/17/17.
//

import UIKit

public class UIKeyboardObservingView: UIView, UIKeyboardObserver {
    
    private var _keyboardObserverId: String?
    public var keyboardObserverId: String {
        
        if let id = _keyboardObserverId {
            return id
        }
        
        let id = UUID().uuidString
        _keyboardObserverId = id
        return id
        
    }
    
    public func keyboardWillShow(with context: UIKeyboardAnimationContext) {
        // Override me
    }
    
    public func keyboardWillHide(with context: UIKeyboardAnimationContext) {
        // Override me
    }
    
}
