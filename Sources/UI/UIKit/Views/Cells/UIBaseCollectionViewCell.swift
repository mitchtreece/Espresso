//
//  UIBaseCollectionViewCell.swift
//  Espresso
//
//  Created by Mitch Treece on 9/16/19.
//

#if canImport(UIKit)

import UIKit

/// `UICollectionViewCell` subclass that provides
/// common helper functions & properties.
open class UIBaseCollectionViewCell: UICollectionViewCell,
                                     UIUserInterfaceStyleAdaptable {
    
    private var traitChangeObserver: AnyObject?
    
    deinit {
        destroy()
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        setup()
        willAppear()
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        
        setup()
        willAppear()
        
    }
    
    /// Called when the view is about to appear.
    ///
    /// This function is called from `init(frame:)` *or* `init(coder:)`.
    /// Subview frames are not guaranteed to have accurate values at this point.
    open func willAppear() {
        
        DispatchQueue.main.async { [weak self] in
            self?.didAppear()
        }
        
    }
    
    /// Called when the view has finished appearing.
    /// Override this function to provide custom setup logic that depends
    /// on subview frames, positions, etc.
    ///
    /// This function is scheduled on the main-thread from `willAppear`.
    /// Subview frames should have accurate values at this point.
    open func didAppear() {
        // Override
    }
    
    @objc
    open func userInterfaceStyleDidChange() {
        // Override
    }
    
    // MARK: Private
    
    private func setup() {
        
        if #available(iOS 17, *) {
            
            self.traitChangeObserver = registerForTraitChanges(
                [UITraitUserInterfaceStyle.self],
                action: #selector(userInterfaceStyleDidChange)
            )

        }
        
    }
    
    private func destroy() {
        
        if #available(iOS 17, *) {
            
            if let observer = self.traitChangeObserver as? UITraitChangeRegistration {
                unregisterForTraitChanges(observer)
            }
            
        }
        
    }
    
    // MARK: Traits (Deprecated - iOS 17)
    
    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {

        super.traitCollectionDidChange(previousTraitCollection)
        
        if #unavailable(iOS 17) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                userInterfaceStyleDidChange()
            }
        }
        
    }
    
}

#endif
