//
//  HorizontalEdgeInsets+UIKit.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public extension HorizontalEdgeInsets {
    
    /// A traditional `UIEdgeInsets` representation.
    func asEdgeInsets() -> UIEdgeInsets {
        
        return UIEdgeInsets(
            top: 0,
            left: self.left,
            bottom: 0,
            right: self.right
        )
        
    }
    
}
