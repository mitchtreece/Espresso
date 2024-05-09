//
//  FirstAppearModifier.swift
//  Espresso
//
//  Created by Mitch Treece on 2/8/24.
//

import SwiftUI
import Espresso

public struct FirstAppearModifier: ViewModifier {
    
    @State private var didAppear: Bool = false
    private let action: VoidAction
    
    public init(_ action: @escaping VoidAction) {
        self.action = action
    }
    
    public func body(content: Content) -> some View {
        
        content.onAppear {
            
            guard !self.didAppear else { return }
            
            self.didAppear = true
            
            self.action()
            
        }
        
    }
    
}

public extension View /* First Appear */ {
    
    /// Adds an action to perform before this view first appears.
    ///
    /// - parameter action: The action to perform when the view first appears.
    /// - returns: This view.
    func onFirstAppear(_ action: @escaping VoidAction) -> some View {
        modifier(FirstAppearModifier(action))
    }
    
}
