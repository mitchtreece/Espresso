//
//  UIImage+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import UIKit

public extension UIImage /* Color */ {
    
    /// Initializes a new image from a specified color & size.
    /// - parameter color: The image fill color.
    /// - parameter size: The image size.
    convenience init?(color: UIColor,
                      size: CGSize) {
        
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
    /// - parameter size: The desired image size.
    func scaled(to size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        self.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    
    /// Creates a new image from the reciever scaled by a specified factor.
    /// - parameter factor: The scale factor.
    func scaled(by factor: CGFloat) -> UIImage? {
        
        let width = (self.size.width * factor)
        let height = (self.size.height * factor)
        let size = CGSize(width: width, height: height)
        return scaled(to: size)
        
    }
    
}

public extension UIImage { /* JPEG */

    /// Representation of the various JPEG quality types.
    enum JPEGQuality: CGFloat {
        
        /// The lowest quality type, value = 0
        case lowest = 0
        
        /// A low quality type, value = 0.25
        case low = 0.25
        
        /// A medium quality type, value = 0.5
        case medium = 0.5
        
        /// A high quality type, value = 0.75
        case high = 0.75
        
        /// The highest quality type, value = 1
        case highest = 1
        
    }

    /// Converts the image into JPEG data using a given quality.
    /// - parameter quality: The JPEG quality to use.
    /// - returns: JPEG data.
    func jpegData(quality: JPEGQuality) -> Data? {
        jpegData(compressionQuality: quality.rawValue)
    }

}

public extension UIImage { /* Blur Hash */
    
    
    /// Initializes a new image from a blur-hash string.
    /// - parameter size: The requested output size. You should keep this small, and let the system scale it up for you.
    convenience init?(blurHash: String,
                      size: CGSize = .init(width: 32, height: 32)) {
        
        guard let image = BlurHashCoder.decode(string: blurHash, size: size),
              let cgImage = image.cgImage else { return nil }
        
        self.init(cgImage: cgImage)
        
    }
    
}
