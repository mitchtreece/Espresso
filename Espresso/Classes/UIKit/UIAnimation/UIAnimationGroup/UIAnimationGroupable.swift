//
//  UIAnimationGroupable.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/21.
//

import Foundation

public protocol UIAnimationGroupable {
    
    /// Returns an animation group over a set of animations.
    /// - returns: A new animation group.
    func asAnimationGroup() -> UIAnimationGroup
    
}
