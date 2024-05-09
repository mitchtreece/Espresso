//
//  ShimmerModifier.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import SwiftUI

public struct Shimmer: ViewModifier {
    
    @SwiftUI.Environment(\.layoutDirection) private var layoutDirection
    @State private var isInitialState: Bool = true
    
    private let animation: Animation
    private let gradient: Gradient
    private let min, max: CGFloat
    
    public static let defaultGradient = Gradient(colors: [
        .black.opacity(0.4),
        .black.opacity(0.1),
        .black.opacity(0.4)
    ])
    
    public static let lightGradient = Gradient(colors: [
        .white.opacity(0.8),
        .white.opacity(0.4),
        .white.opacity(0.8)
    ])
    
    public static let defaultAnimation = Animation
        .linear(duration: 1.5)
        .delay(0.25)
        .repeatForever(autoreverses: false)
    
    private var start: UnitPoint {
        
        if self.layoutDirection == .rightToLeft {
            
            return self.isInitialState ?
                .init(x: self.max, y: self.min) :
                .init(x: 0, y: 1)
            
        }
        else {
            
            return self.isInitialState ?
                .init(x: self.min, y: self.min) :
                .init(x: 1, y: 1)
            
        }
        
    }
    
    private var end: UnitPoint {
     
        if self.layoutDirection == .rightToLeft {
            
            return self.isInitialState ?
                .init(x: 1, y: 0) :
                .init(x: self.min, y: self.max)
            
        }
        else {
            
            return self.isInitialState ?
                .zero :
                .init(x: self.max, y: self.max)
            
        }
        
    }
    
    public init(animation: Animation,
                gradient: Gradient,
                size: CGFloat) {
        
        self.animation = animation
        self.gradient = gradient
        self.min = (0 - size)
        self.max = (1 + size)
        
    }
    
    public func body(content: Content) -> some View {
        
        return content
            .mask(LinearGradient(
                gradient: self.gradient,
                startPoint: self.start,
                endPoint: self.end
            ))
            .animation(
                self.animation,
                value: self.isInitialState
            )
            .onAppear {
                self.isInitialState = false
            }
        
    }
    
}

public extension View /* Shimmer */ {
    
    /// Sets the view as shimmering.
    ///
    /// - parameter condition: Flag indicating if the view is shimmering.
    /// - parameter animation: The shimmer animation.
    /// - parameter gradient: The shimmer gradient.
    /// - parameter size: The shimmer band size.
    /// - returns: This view.
    @ViewBuilder
    func shimmer(_ condition: Bool = true,
                 animation: Animation = Shimmer.defaultAnimation,
                 gradient: Gradient = Shimmer.defaultGradient,
                 size: CGFloat = 0.3) -> some View {
        
        if condition {
            
            modifier(Shimmer(
                animation: animation,
                gradient: gradient,
                size: size
            ))
            
        }
        else { self }
        
    }
    
}
