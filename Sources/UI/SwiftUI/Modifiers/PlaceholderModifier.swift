//
//  PlaceholderModifier.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import SwiftUI

@available(iOS 14.0, *)
public extension View /* Placeholder */ {
    
    /// Sets the view as a placeholder.
    ///
    /// - parameter condition: Flag indicating if the view should be a placeholder.
    /// - parameter animated: Flag indicating if the placeholder transition should happen with an animation.
    /// - returns: This view.
    @ViewBuilder
    func placeholder(_ condition: Bool = true,
                     animated: Bool = true) -> some View {
        
        if condition {
            
            let content = redacted(reason: .placeholder)
            
            if animated {
                
                content
                    .transition(.opacity.animation(.default))
                
            }
            
        }
        else if animated {
            transition(.opacity.animation(.default))
        }
        else { self }
        
    }
    
}
