//
//  UIAnimationGroupConvertible.swift
//  Espresso
//
//  Created by Mitch Treece on 6/30/18.
//

import UIKit

/**
 `UIAnimationGroupConvertible` is a protocol describing the conversion to various `UIAnimationGroup` representations.
 */
public protocol UIAnimationGroupConvertible {
    
    /**
     A `UIAnimation` array representation.
     */
    var animations: [UIAnimation] { get }
    
    /**
     A `UIAnimationGroup` representation.
     */
    var animationGroup: UIAnimationGroup { get }
    
}

extension UIAnimation: UIAnimationGroupConvertible {
    
    public var animations: [UIAnimation] {
        return [self]
    }
    
    public var animationGroup: UIAnimationGroup {
        return UIAnimationGroup(animations: [self])
    }
    
}

extension UIAnimationGroup: UIAnimationGroupConvertible {
    
    public var animations: [UIAnimation] {
        return self._animations
    }
    
    public var animationGroup: UIAnimationGroup {
        return self
    }
    
}
