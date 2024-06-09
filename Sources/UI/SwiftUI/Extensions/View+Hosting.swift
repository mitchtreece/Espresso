//
//  View+Hosting.swift
//  Espresso
//
//  Created by Mitch Treece on 2/19/24.
//

#if canImport(UIKit)

import SwiftUI

public extension View /* Hosting View */ {
    
    /// Returns the view as a `UIKit`-hosted view representation.
    /// - returns: A `UIHostingView` instance over the receiver.
    func asHostingView() -> UIHostingView<Self> {
        return UIHostingView(content: self)
    }
    
}

#endif
