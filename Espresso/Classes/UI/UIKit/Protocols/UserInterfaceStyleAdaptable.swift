//
//  UserInterfaceStyleAdaptable.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit

/// Protocol describing something that adapts to user interface style changes.
///
/// Adopters of this protocol should implement `traitCollectionDidChange(previousTraitCollection:)`
/// and call relevant functions when needed.
public protocol UserInterfaceStyleAdaptable: UITraitEnvironment {
    
    /// Called when the system's user interface style changes.
    func userInterfaceStyleDidChange()
    
}

public extension UserInterfaceStyleAdaptable {
    
    /// The trait environment's user interface style.
    var userInterfaceStyle: UIUserInterfaceStyle {
        return self.traitCollection.userInterfaceStyle
    }
    
}
