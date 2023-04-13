//
//  View+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 10/17/22.
//

import SwiftUI

public extension View {
    
    /// Returns the view as a `UIKit`-hosted view representation.
    /// - returns: A `UIHostingView` instance over the receiver.
    func asHostingView() -> UIHostingView<Self> {
        return UIHostingView(content: self)
    }
    
    /// Returns the view as a `UIKit`-hosted controller representation.
    /// - returns: A `UIHostingController` instance over the receiver.
    func asHostingController() -> UIHostingController<Self> {
        return UIHostingController(rootView: self)
    }
    
}
