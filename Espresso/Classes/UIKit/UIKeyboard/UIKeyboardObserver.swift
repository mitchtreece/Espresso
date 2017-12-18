//
//  UIKeyboardObserver.swift
//  Espresso
//
//  Created by Mitch Treece on 12/17/17.
//

import Foundation

public protocol UIKeyboardObserver {
    
    var keyboardObserverId: String { get }
    func keyboardWillShow(with context: UIKeyboardAnimationContext)
    func keyboardWillHide(with context: UIKeyboardAnimationContext)
    
}

extension UIKeyboardObserver {
    
    public func registerForKeyboardEvents() {
        UIKeyboardManager.shared.add(observer: self)
    }
    
}
