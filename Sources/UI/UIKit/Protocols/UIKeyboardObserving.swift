//
//  File.swift
//  Espresso
//
//  Created by Mitch on 12/19/24.
//

#if canImport(UIKit)

import UIKit
import Espresso

/// Protocol describing the characteristics of something that
/// observes and publishes keybaord events.
public protocol UIKeyboardObserving {
    
    // MARK: Publishers
    
    /// A publisher that sends when the keyboard is about to be presented.
    var onKeyboardWillShow: GuaranteePublisher<UIKeyboardAnimation> { get }
    
    /// A publisher that sends when the keyboard finished presenting.
    var onKeyboardDidShow: GuaranteePublisher<UIKeyboardAnimation> { get }
    
    /// A publisher that sends when the keyboard's frame is about to change.
    var onKeyboardWillChangeFrame: GuaranteePublisher<UIKeyboardAnimation> { get }
    
    /// A publisher that sends when the keyboard's frame finishes changing.
    var onKeyboardDidChangeFrame: GuaranteePublisher<UIKeyboardAnimation> { get }
    
    /// A publisher that sends when the keyboard is about to be dismissed.
    var onKeyboardWillHide: GuaranteePublisher<UIKeyboardAnimation> { get }
    
    /// A publisher that sends when the keyboard finishes dismissing.
    var onKeyboardDidHide: GuaranteePublisher<UIKeyboardAnimation> { get }
    
    // MARK: Getters
    
    /// Flag indicating if the system keyboard is currently visible.
    var isKeyboardVisible: Bool { get }
    
    // MARK: Functions
    
    /// Called when the keyboard is about to be presented.
    ///
    /// - parameter animation: The keyboard's animation info.
    func keyboardWillShow(_ animation: UIKeyboardAnimation)

    /// Called when the keyboard finishes presenting.
    ///
    /// - parameter animation: The keyboard's animation info.
    func keyboardDidShow(_ animation: UIKeyboardAnimation)
    
    /// Called when the keyboard's frame is about to change.
    ///
    /// - parameter animation: The keyboard's animation info.
    func keyboardWillChangeFrame(_ animation: UIKeyboardAnimation)
    
    /// Called when the keyboard's frame finishes changing.
    ///
    /// - parameter animation: The keyboard's animation info.
    func keyboardDidChangeFrame(_ animation: UIKeyboardAnimation)
    
    /// Called when the keyboard is about to be dismissed.
    ///
    /// - parameter animation: The keyboard's animation info.
    func keyboardWillHide(_ animation: UIKeyboardAnimation)
    
    /// Called when the keyboard finishes dismissing.
    ///
    /// - parameter animation: The keyboard's animation info.
    func keyboardDidHide(_ animation: UIKeyboardAnimation)
    
}

#endif
