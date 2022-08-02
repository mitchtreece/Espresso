//
//  BlurHashRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/28/22.
//

import Foundation

/// Protocol describing something that can be represented as a `BlurHash`.
///
/// [blurha.sh](https://blurha.sh)
///
/// [github.com/woltapp/blurhash](https://github.com/woltapp/blurhash)
public protocol BlurHashRepresentable {
    
    /// A `BlurHash` representation.
    /// - parameter components: The components to use when generating the hash.
    /// - returns: A new `BlurHash`.
    func asBlurHash(components: BlurHash.Components) -> BlurHash?
    
}

public extension BlurHashRepresentable {
    
    /// A `BlurHash` representation using `defaultSquare` (4, 4) components.
    /// - returns: A new `BlurHash`.
    func asBlurHash() -> BlurHash? {
        return asBlurHash(components: .defaultSquare)
    }
    
}

extension BlurHash: BlurHashRepresentable {
    
    /// A `BlurHash` representation.
    /// - parameter components: The components to use when generating the hash.
    /// - returns: A new `BlurHash`.
    ///
    /// **Note**: Calling this function on a concrete `BlurHash` instance
    /// will ignore passed in components, and return `self`.
    public func asBlurHash(components: Components) -> BlurHash? {
        return self
    }
    
}

extension UIImage: BlurHashRepresentable {
    
    public func asBlurHash(components: BlurHash.Components) -> BlurHash? {
        
        return BlurHash(
            image: self,
            components: components
        )
        
    }
    
}
