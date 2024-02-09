//
//  PlaceholderLoadingModifier.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import SwiftUI

@available(iOS 14.0, *)
public extension View /* Placeholder Loading */ {
    
    /// Sets the view as placeholder loading.
    ///
    /// - parameter condition: Flag indicating if the view is loading.
    /// - parameter animation: The loading shimmer animation.
    /// - parameter gradient: The loading shimmer gradient.
    /// - parameter animated: Flag indicating if the loading transition should happen with an animation.
    /// - returns: This view.
    @ViewBuilder
    func placeholderLoading(_ condition: Bool = true,
                            animation: Animation = Shimmer.defaultAnimation,
                            gradient: Gradient = Shimmer.defaultGradient,
                            animated: Bool = true) -> some View {
        
        if condition {
            
            let content = redacted(
                reason: .placeholder
            )
            .shimmer(
                animation: animation,
                gradient: gradient,
                size: 0.3
            )

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
