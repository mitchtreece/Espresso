//
//  Binding+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/10/23.
//

#if canImport(UIKit)

import UIKit
import SwiftUI

public extension UIColorRepresentable {
    
    /// A SwiftUI `Color` representation.
    func asSwiftColor() -> Color {
        return Color(asColor())
    }
    
}

#endif
