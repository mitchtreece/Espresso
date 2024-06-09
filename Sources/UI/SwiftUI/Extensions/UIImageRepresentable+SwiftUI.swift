//
//  UIImageRepresentable+Image.swift
//  Espresso
//
//  Created by Mitch Treece on 1/12/23.
//

#if canImport(UIKit)

import UIKit
import SwiftUI

public extension UIImageRepresentable {
    
    /// A SwiftUI `Image` representation.
    func asSwiftImage() -> Image? {
        
        guard let image = asImage() else { return nil }
        
        return Image(uiImage: image)
        
    }
    
}

#endif
