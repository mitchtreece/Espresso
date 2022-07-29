//
//  UIAnimationGroupRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/21.
//

import Foundation

public protocol UIAnimationGroupRepresentable {
    
    /// A `UIAnimationGroup` representation.
    /// - returns: A new animation group.
    func asAnimationGroup() -> UIAnimationGroup
    
}
