//
//  UIHostingView.swift
//  Espresso
//
//  Created by Mitch Treece on 10/17/22.
//

#if canImport(UIKit)

import UIKit
import SwiftUI
import SnapKit

/// A `UIView` subclass that manages a SwiftUI view.
///
/// @note
/// It's recommended to use `view.asHostingView()` as opposed to directly initializing via `UIHostingView(content:)`.
/// Using the helper `as` function has additional benefits like host-proxy injection.
///
/// @note
/// You can also manually provide a host-proxy to an initialized hosting view.
///
/// ```
/// let view: HostedView = ...
/// let proxy = UIHostProxy<HostedView>()
/// let hostingView = UIHostingView(content: view)
///
/// proxy.view = hostingView
///
/// return hostingView
/// ```
public class UIHostingView<Content: View>: UIView {
 
    private var hostingController: UIHostingController<Content>?

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
                
        self.hostingController?
            .view
            .removeFromSuperview()
        
        self.hostingController = UIHostingController(rootView: content)
        self.hostingController!.view.backgroundColor = .clear
        self.hostingController!.view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(self.hostingController!.view)
        self.hostingController!.view!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
}

#endif
