//
//  NavigationActionLink.swift
//  EspressoUI
//
//  Created by Mitch on 1/25/25.
//

import SwiftUI

/// View that controls a navigation action.
///
/// - Note: This mimics a standard `NavigationLink` style.
///   However, instead of providing a view to navigate to,
///   a generic action is performed instead.
public struct NavigationActionLink<Label: View>: View {
    
    private let label: ()->Label
    private let action: ()->()

    /// Initializes a navigation action link.
    /// - parameter action: The action to perform.
    /// - parameter label: The label view builder.
    public init(action: @escaping ()->(),
                @ViewBuilder label: @escaping ()->Label) {
        
        self.label = label
        self.action = action

    }
    
    /// Initializes a navigation action link.
    /// - parameter title: The link's title.
    /// - parameter action: The action to perform.
    public init(_ title: String,
                action: @escaping ()->()) where Label == Text {
        
        self.action = action
        self.label = { Text(title) }
        
    }
        
    /// Initializes a navigation action link.
    /// - parameter title: The link's title.
    /// - parameter image: The name of the link's icon image.
    /// - parameter action: The action to perform.
    public init(_ title: String,
                image: String,
                action: @escaping ()->()) where Label == SwiftUI.Label<Text, Image> {
    
        self.action = action
        self.label = { SwiftUI.Label(title, image: image) }
        
    }
    
    /// Initializes a navigation action link.
    /// - parameter title: The link's title.
    /// - parameter systemImage: The name of the link's system icon image.
    /// - parameter action: The action to perform.
    public init(_ title: String,
                systemImage: String,
                action: @escaping ()->()) where Label == SwiftUI.Label<Text, Image> {
        
        self.action = action
        self.label = { SwiftUI.Label(title, systemImage: systemImage) }
        
    }
    
    /// Initializes a navigation action link.
    /// - parameter title: The link's title.
    /// - parameter symbol: The link's icon symbol.
    /// - parameter action: The action to perform.
    public init(_ title: String,
                symbol: SFSymbol,
                action: @escaping ()->()) where Label == SwiftUI.Label<Text, Image> {
        
        self.init(
            title,
            systemImage: symbol.rawValue,
            action: action
        )
        
    }
    
    public var body: some View {

        Button(action: action) {
            
            HStack(spacing: 0) {
                
                self.label()
                
                Spacer()

                NavigationLink(
                    destination: EmptyView(),
                    label: { EmptyView() }
                )
                .layoutPriority(-1)
                
            }
            
        }
        
    }
    
}
