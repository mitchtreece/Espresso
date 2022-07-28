//
//  BlurHash.swift
//  Espresso
//
//  Created by Mitch Treece on 7/28/22.
//

import UIKit

/// A lightweight blurred image hash container.
///
/// [blurha.sh](https://blurha.sh)
///
/// [github.com/woltapp/blurhash](https://github.com/woltapp/blurhash)
public struct BlurHash {
    
    /// Set of components used to encode a `BlurHash`.
    public struct Components {
        
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
        public static var defaultSquare: Components {
            return Components(x: 4, y: 4)
        }
        
        /// A default landscape (4x3) component configuration.
        public static var defaultLandscape: Components {
            return Components(x: 4, y: 3)
        }
        
        /// A default portrait (3x4) component configuration.
        public static var defaultPortrait: Components {
            return Components(x: 3, y: 4)
        }
        
    }
    
    /// The hash value.
    public private(set) var value: String

    /// Initializes a blur hash with an image & component configuration.
    /// - parameter image: The image to encode.
    /// - parameter components: The blur hash component configuration; _defaults to defaultSquare_.
    public init?(image: UIImage?,
                 components: Components = .defaultSquare) {
        
        guard let image = image,
              let hashString = BlurHashCoder.encode(image: image, components: components) else { return nil }
        
        self.value = hashString
        
    }
    
}
