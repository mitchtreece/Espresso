//
//  UIHostingView.swift
//  Espresso
//
//  Created by Mitch Treece on 10/17/22.
//

import UIKit
import SwiftUI

/// A `UIView` subclass that manages a SwiftUI view.
public class UIHostingView<Content: View>: UIView {
 
    private var viewController: UIHostingController<Content>?
    
    /// Initializes a hosting view with content.
    /// - parameter content: The content to host.
    public init(content: Content) {
        
        super.init(frame: .zero)
        
        setupSubviews()
        layout(for: content)
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setupSubviews()
        
    }
    
    /// Configures the hosting view with content.
    /// - returns: This hosting view instance.
    public func setup(content: Content) -> Self {
        
        layout(for: content)
        
        return self
        
    }
    
    // MARK: Private
    
    private func setupSubviews() {
        
        self.backgroundColor = .clear
        
    }
    
    private func layout(for content: Content) {
        
        self.viewController?.view
            .removeFromSuperview()
        
        self.viewController = UIHostingController(rootView: content)
        self.viewController!.view.backgroundColor = .clear
        self.viewController!.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(self.viewController!.view)
        
        NSLayoutConstraint.activate([
            self.viewController!.view.topAnchor.constraint(equalTo: self.topAnchor),
            self.viewController!.view.leftAnchor.constraint(equalTo: self.leftAnchor),
            self.viewController!.view.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.viewController!.view.rightAnchor.constraint(equalTo: self.rightAnchor)
        ])
        
    }
}
