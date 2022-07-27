//
//  Placeholder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/22/22.
//

import SwiftUI

/// Blurred view that adapts to tint color changes.
public struct BlurView: UIViewRepresentable {
    
    public typealias UIViewType = UIBlurView
    
    @Binding private var style: UIBlurEffect.Style

    /// Initializes a `BlurView` with a blur style.
    /// - parameter style: The blur style.
    public init(style: Binding<UIBlurEffect.Style> = .value(.systemMaterial)) {
        self._style = style
    }
    
    public func makeUIView(context: Context) -> UIBlurView {
        return UIBlurView(style: self.style)
    }
    
    public func updateUIView(_ uiView: UIBlurView,
                             context: Context) {
        
        uiView.blurStyle = self.style
        
    }
    
}
