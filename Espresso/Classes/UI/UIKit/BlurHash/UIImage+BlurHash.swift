//
//  UIImage+BlurHash.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/23.
//

import UIKit

public extension UIImage /* Blur Hash */ {

    /// Initializes an image from a blur hash.
    /// - parameter hash: The blur hash.
    /// - parameter size: The requested output size.
    ///
    /// You should keep the size small, and let the system scale it up for you.
    convenience init?(hash: BlurHash,
                      size: CGSize = .init(width: 32, height: 32)) {
        
        guard let image = BlurHashCoder().decode(hash: hash, size: size),
              let cgImage = image.cgImage else { return nil }
        
        self.init(cgImage: cgImage)
        
    }
    
}
