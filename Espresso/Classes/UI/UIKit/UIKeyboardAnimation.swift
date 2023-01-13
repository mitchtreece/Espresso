//
//  UIKeyboardAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit

/// Object containing the various properties of a keyboard animation.
public struct UIKeyboardAnimation {
    
    /// The animation's beginning keyboard frame.
    public let beginFrame: CGRect
    
    /// The animation's ending keyboard frame.
    public let endFrame: CGRect
    
    /// The animation's duration.
    public let duration: TimeInterval
    
    /// The animation's options.
    public let options: UIView.AnimationOptions
    
    /// The animation's total movement vector.
    public var movement: CGVector {
        
        return CGVector(
            dx: 0,
            dy: (self.beginFrame.origin.y - self.endFrame.origin.y)
        )
        
    }
    
    internal init(beginFrame: CGRect,
                  endFrame: CGRect,
                  duration: TimeInterval,
                  options: UIView.AnimationOptions) {
        
        self.beginFrame = beginFrame
        self.endFrame = endFrame
        self.duration = duration
        self.options = options
        
    }
    
    internal init?(notification: Notification) {
        
        guard let info = notification.userInfo,
              let beginFrame = (info[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue,
              let endFrame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
              let curve = info[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber else { return nil }
        
        self.init(
            beginFrame: beginFrame,
            endFrame: endFrame,
            duration: duration,
            options: UIView.AnimationOptions(rawValue: curve.uintValue << 16)
        )
        
    }
    
    /// Performs animations by matching the keyboard animation's properties.
    ///
    /// - parameter animations: The animations to perform.
    /// - parameter completion: An optional completion handler to call once animations have finished.
    public func animate(_ animations: @escaping ()->(),
                        completion: (()->())? = nil) {
        
        UIView.animate(
            withDuration: self.duration,
            delay: 0,
            options: self.options,
            animations: animations,
            completion: { _ in completion?() }
        )
        
    }
    
}
