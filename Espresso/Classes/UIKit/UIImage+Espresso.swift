//
//  UIImage+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

// MARK: Color

public extension UIImage {
    
    public convenience init?(color: UIColor, size: CGSize) {
        
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

// MARK: Scale

public extension UIImage {
    
    public func scaled(to size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    
}
