//
//  UIImage+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

public extension UIImage /* Color */ {
    
    /// Initializes a new image from a specified color & size.
    /// - Parameter color: The image fill color.
    /// - Parameter size: The image size.
    convenience init?(color: UIColor, size: CGSize) {
        
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
        
    }
    
}

public extension UIImage /* Scale */ {
    
    /// Creates a new image from the reciever scaled to a specific size.
    /// - Parameter size: The desired image size.
    func scaled(to size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    
    /// Creates a new image from the reciever scaled by a specified factor.
    /// - Parameter factor: The scale factor.
    func scaled(by factor: CGFloat) -> UIImage? {
        
        let width = (self.size.width * factor)
        let height = (self.size.height * factor)
        let size = CGSize(width: width, height: height)
        return scaled(to: size)
        
    }
    
}
