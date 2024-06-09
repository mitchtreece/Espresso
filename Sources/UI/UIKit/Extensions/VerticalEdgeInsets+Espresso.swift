//
//  VerticalEdgeInsets+UIKit.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

#if canImport(UIKit)

import UIKit

public extension VerticalEdgeInsets {
    
    /// A traditional `UIEdgeInsets` representation.
    func asEdgeInsets() -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: self.top,
            left: 0,
            bottom: self.bottom,
            right: 0
        )
        
    }
    
}

#endif
