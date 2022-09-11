//
//  KeyboardAnimationInfo.swift
//  Espresso
//
//  Created by Mitch Treece on 9/11/22.
//

import UIKit

public struct KeyboardAnimationInfo {
    
    public let beginFrame: CGRect
    public let endFrame: CGRect
    public let duration: TimeInterval
    public let options: UIView.AnimationOptions
    
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
    
}
