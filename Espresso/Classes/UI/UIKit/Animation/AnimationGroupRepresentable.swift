//
//  AnimationGroupRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 6/14/21.
//

import Foundation

public protocol AnimationGroupRepresentable {
    
    /// A `AnimationGroup` representation.
    ///
    /// - returns: A new animation group.
    func asAnimationGroup() -> AnimationGroup
    
}
