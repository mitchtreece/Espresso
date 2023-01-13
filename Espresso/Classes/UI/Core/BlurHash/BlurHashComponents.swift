//
//  BlurHashComponents.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/23.
//

import Foundation

/// Set of components used to encode a `BlurHash`.
public struct BlurHashComponents {

    /// The number of x components.
    public var x: Int

    /// The number of y components.
    public var y: Int

    /// Initializes components with a number of x & y values.
    /// - parameter x: The number of x components.
    /// - parameter y: The number of y components.
    public init(x: Int, y: Int) {

        self.x = x
        self.y = y

    }

    /// A default square (4x4) component configuration.
    public static var defaultSquare: BlurHashComponents {
        return .init(x: 4, y: 4)
    }

    /// A default landscape (4x3) component configuration.
    public static var defaultLandscape: BlurHashComponents {
        return .init(x: 4, y: 3)
    }

    /// A default portrait (3x4) component configuration.
    public static var defaultPortrait: BlurHashComponents {
        return .init(x: 3, y: 4)
    }

}
