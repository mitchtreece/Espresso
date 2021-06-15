//
//  ImageType.swift
//  Espresso
//
//  Created by Mitch Treece on 5/3/21.
//

import UIKit

/// Protocol describing something that can be represented as a `UIImage`.
public protocol ImageType {
    
    /// An image representation.
    var imageValue: UIImage? { get }
    
}

extension String: ImageType {
    
    public var imageValue: UIImage? {
        return UIImage(named: self)
    }
    
}
