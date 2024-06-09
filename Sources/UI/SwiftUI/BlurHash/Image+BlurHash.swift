//
//  Image+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/12/23.
//

#if canImport(UIKit)

import UIKit
import SwiftUI

public extension Image {

    /// Initializes an image from a blur hash.
    /// - parameter hash: The blur hash.
    /// - parameter size: The requested output size.
    ///
    /// You should keep the size small, and let the system scale it up for you.
    init?(hash: BlurHash,
          size: CGSize = .init(width: 32, height: 32)) {

        guard let image = UIBlurHashCoder()
            .decode(hash: hash, size: size) else { return nil }

        self.init(uiImage: image)
        
    }

}

#endif
