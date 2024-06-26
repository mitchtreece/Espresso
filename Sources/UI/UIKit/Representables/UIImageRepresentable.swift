//
//  UIImageRepresentable.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

#if canImport(UIKit)

import UIKit

/// Protocol describing something that can be represented as a `UIImage`.
public protocol UIImageRepresentable {
    
    /// An image representation.
    func asImage() -> UIImage?
    
}

public extension UIImageRepresentable {
    
    /// An image representation using a given rendering mode.
    /// - parameter renderingMode: The image rendering mode to use.
    func asImage(renderingMode: UIImage.RenderingMode) -> UIImage? {
        return asImage()?.withRenderingMode(renderingMode)
    }
    
    /// An image data representation.
    func asImageData() -> Data? {
        return asImage()?.pngData()
    }
    
}

extension UIImage: UIImageRepresentable {
    
    public func asImage() -> UIImage? {
        return self
    }
    
}

extension Data: UIImageRepresentable {
    
    public func asImage() -> UIImage? {
        return UIImage(data: self)
    }
    
}

#endif
