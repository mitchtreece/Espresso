//
//  VisibilityChangeModifier.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/24.
//

import SwiftUI

public extension View {
    
    /// Adds an action to perform after this view's visibility changes.
    ///
    /// - parameter container: The containing geometry to check visibility against.
    /// - parameter action: The action to perform.
    /// - returns: This view.
    @ViewBuilder
    func onVisibilityChange(in container: FrameProvider = .screen,
                            perform action: @escaping (Bool)->()) -> some View {

        
        modifier(VisibilityChangeModifier(
            container: container,
            action: action
        ))
        
    }
    
}

public struct VisibilityChangeModifier: ViewModifier {
    
    private let containerGeometry: FrameProvider
    private let onVisibilityChange: (Bool)->()
    
    @State private var isVisible: Bool = false
    
    init(container: FrameProvider,
         action: @escaping (Bool)->()) {
        
        self.containerGeometry = container
        self.onVisibilityChange = action
        
    }
    
    public func body(content: Content) -> some View {
        
        content.overlay {
            
            GeometryReader { proxy in
                
                EmptyView()
                    .onAppear() {
                        updateVisible(proxy: proxy)
                    }
                    .onChange(of: proxy.frame(in: .global), perform: { _ in
                        updateVisible(proxy: proxy)
                    })
                    .onDisappear {
                        
                        updateVisible(
                            proxy: proxy,
                            value: false
                        )
                        
                    }
                
            }
            
        }
        
    }
    
    // MARK: Private
    
    private func updateVisible(proxy: GeometryProxy,
                               value: Bool? = nil) {
        
        if let value {
            
            _updateVisibleIfNeeded(visible: value)
            return
            
        }
        
        let containerFrame = self.containerGeometry.frame
        let viewFrame = proxy.frame(in: .global)
        let visible = containerFrame.intersects(viewFrame)
        
        _updateVisibleIfNeeded(visible: visible)
        
    }
    
    private func _updateVisibleIfNeeded(visible: Bool) {
        
        guard visible != self.isVisible else {
            return
        }
        
        self.isVisible = visible
        self.onVisibilityChange(visible)
        
    }
    
}
