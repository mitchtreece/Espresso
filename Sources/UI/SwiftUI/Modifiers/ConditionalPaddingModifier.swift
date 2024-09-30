//
//  ConditionalPaddingModifier.swift
//  Espresso
//
//  Created by Mitch Treece on 6/10/24.
//

import SwiftUI

public struct ConditionalPaddingModifier: ViewModifier {
    
    private let edges: SwiftUI.Edge.Set
    private let length: CGFloat?
    private let condition: Bool

    public init(edges: SwiftUI.Edge.Set,
                length: CGFloat?,
                condition: Bool) {
        
        self.edges = edges
        self.length = length
        self.condition = condition
        
    }
    
    public func body(content: Content) -> some View {
        
        if self.condition {
            
            return content.padding(
                self.edges,
                self.length
            )
            .asAnyView()
            
        }
        else {
            
            return content
                .asAnyView()
            
        }
        
    }
    
}

public extension View {
    
    func conditionalPadding(_ edges: SwiftUI.Edge.Set = .all,
                            length: CGFloat? = nil,
                            condition: Bool) -> some View {
        
        modifier(ConditionalPaddingModifier(
            edges: edges,
            length: length,
            condition: condition
        ))
        
    }
    
}
