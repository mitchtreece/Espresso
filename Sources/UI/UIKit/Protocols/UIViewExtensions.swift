//
//  UIViewExtensions.swift
//  Espresso
//
//  Created by Mitch on 12/19/24.
//

#if canImport(UIKit)

import UIKit

public protocol UIViewCommon: Binder, ComponentBinder where Self: UIView {}

public protocol UIViewLifecycle where Self: UIView {
    
    /// A publisher that sends when the view is about to appear.
    var onWillAppear: GuaranteePublisher<Void> { get }
    
    /// A publisher that sends when the view has finished appearing.
    var onDidAppear: GuaranteePublisher<Void> { get }
    
    /// Called when the view is about to appear.
    ///
    /// Subview frames are not guaranteed to have accurate values at this point.
    func willAppear()
    
    /// Called when the view has finished appearing.
    /// Override this function to provide custom setup logic that depends
    /// on subview frames, positions, etc.
    ///
    /// Subview frames should have accurate values at this point.
    func didAppear()
    
}

public protocol UIViewAppearance: UIUserInterfaceStyleAdaptable where Self: UIView {}

#endif
