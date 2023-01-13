//
//  KeyboardAnimation.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit

public struct KeyboardAnimation {
    
    public let beginFrame: CGRect
    public let endFrame: CGRect
    public let duration: TimeInterval
    public let options: UIView.AnimationOptions
    
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
