//
//  UIEdgeInsets+SwiftUI.swift
//  Espresso
//
//  Created by Mitch on 1/21/25.
//

#if canImport(UIKit)

import SwiftUI
import UIKit

public extension UIEdgeInsets /* SwiftUI */ {

    /// A SwiftUI `EdgeInsets` representation.
    func asSwiftEdgeInsets() -> EdgeInsets {
        
        return .init(
            top: self.top,
            leading: self.left,
            bottom: self.bottom,
            trailing: self.right
        )
        
    }
    
}

#endif
