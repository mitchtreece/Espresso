//
//  ImageType.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import UIKit

/// Protocol describing something that can be represented as an image.
public protocol ImageRepresentable {
    
    /// An image representation.
    /// - returns: An image.
    func asImage() -> UIImage?
    
}

public extension ImageRepresentable {
    
    /// An image representation using a given rendering mode.
    /// - parameter renderingMode: The image rendering mode to use.
    /// - returns: An image using the give rendering mode.
    func asImage(renderingMode: UIImage.RenderingMode) -> UIImage? {
        return asImage()?.withRenderingMode(renderingMode)
    }
    
}

extension UIImage: ImageRepresentable {
    
    public func asImage() -> UIImage? {
        return self
    }
    
}

extension Data: ImageRepresentable {
    
    public func asImage() -> UIImage? {
        return UIImage(data: self)
    }
    
}
