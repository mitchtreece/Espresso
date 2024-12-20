//
//  View+Hosting.swift
//  Espresso
//
//  Created by Mitch Treece on 2/19/24.
//

#if canImport(UIKit)

import SwiftUI

public extension View /* Hosting */ {
    
    /// Returns the view as a UIKit-hosted view representation.
    ///
    /// - returns: A `UIHostingView` instance over the receiver.
    ///
    /// @note
    /// This also injects a proxy into the view's environment for
    /// direct UIKit access from the SwiftUI view.
    ///
    /// ```
    /// struct HostedView: View {
    ///
    ///     @EnvironmentObject var proxy: UIHostProxy<Self>
    ///
    ///     var body: some View {
    ///
    ///         VStack { ... }.onAppear {
    ///             print("Hosting view: \(self.proxy.view)")
    ///         }
    ///
    ///     }
    ///
    /// }
    /// ```
    func asHostingView() -> UIHostingView<Self> {
        
        let proxy = UIHostProxy<Self>()
        let hostingView = UIHostingView(content: self)
        
        proxy.view = hostingView
        
        return hostingView
        
    }
    
    /// Returns the view wrapped in a hosting controller.
    ///
    /// - returns: A `UIHostingController` instance over the receiver.
    ///
    /// @note
    /// This also injects a proxy into the view's environment for
    /// direct UIKit access from the SwiftUI view.
    ///
    /// ```
    /// struct HostedView: View {
    ///
    ///     @EnvironmentObject var proxy: UIHostProxy<Self>
    ///
    ///     var body: some View {
    ///
    ///         VStack { ... }.onAppear {
    ///
    ///             // UIViewController
    ///             print("Hosting controller: \(self.proxy.controller)")
    ///
    ///             // UIView (self.proxy.controller.view)
    ///             print("Hosting view: \(self.proxy.view)")
    ///
    ///         }
    ///
    ///     }
    ///
    /// }
    /// ```
    func asHostingController() -> UIHostingController<Self> {
        
        let proxy = UIHostProxy<Self>()
        let hostingController = UIHostingController(rootView: self)
        
        proxy.controller = hostingController
        proxy.view = hostingController.view

        return hostingController
        
    }
    
    /// Returns the view wrapped in an extended hosting controller.
    ///
    /// - returns: A `UIHostingControllerEx` instance over the receiver.
    ///
    /// @note
    /// This also injects a proxy into the view's environment for
    /// direct UIKit access from the SwiftUI view.
    ///
    /// ```
    /// struct HostedView: View {
    ///
    ///     @EnvironmentObject var proxy: UIHostProxy<Self>
    ///
    ///     var body: some View {
    ///
    ///         VStack { ... }.onAppear {
    ///
    ///             // UIViewController
    ///             print("Hosting controller: \(self.proxy.controller)")
    ///
    ///             // UIView (self.proxy.controller.view)
    ///             print("Hosting view: \(self.proxy.view)")
    ///
    ///         }
    ///
    ///     }
    ///
    /// }
    /// ```
    func asHostingControllerEx(_ builder: UIHostingControllerExBuilder? = nil) -> UIHostingControllerEx<Self> {
        
        let proxy = UIHostProxy<Self>()
        
        let hostingController = UIHostingControllerEx(
            rootView: self,
            builder: builder
        )
        
        proxy.controller = hostingController
        proxy.view = hostingController.view
        
        return hostingController
        
    }
    
}

#endif
