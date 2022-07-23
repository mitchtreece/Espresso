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

    /// Initializes a `BlurView` with a default style.
    public init() {
        self.init(style: .systemMaterial)
    }
    
    /// Initializes a `BlurView` with a blur style.
    /// - parameter style: The blur style.
    public init(style: UIBlurEffect.Style) {
        self._style = .constant(style)
    }
    
    /// Initializes a `BlurView` with a blur style binding.
    /// - parameter style: The blur style binding.
    public init(style: Binding<UIBlurEffect.Style>) {
        self._style = style
    }
    
    public func makeUIView(context: Context) -> UIBlurView {
        
        return UIBlurView(
            frame: .zero,
            style: self.style
        )
        
    }
    
    public func updateUIView(_ uiView: UIBlurView,
                             context: Context) {
        
        uiView.blurStyle = self.style
        
    }
    
}
