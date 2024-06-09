//
//  UIViewModel.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/20.
//

#if canImport(UIKit)

import UIKit
import Espresso

// TODO: Remove this once `Pilot` is released
// All architecture-level stuff should be in that library.

/// Specialized base view-model class that manages a `UIView`.
///
/// This should never be used directly. Instead, create a specialized `UIViewModel` by subclassing it.
open class UIViewModel: ViewModel {
    
    /// The view model's managed view.
    public private(set) weak var view: UIView?

    /// Sets the view model's managed view.
    /// - parameter view: The view
    ///
    /// The view will only be set once. Subsequent calls to this function will be ignored.
    public func set(view: UIView) {
        
        guard self.view == nil else {
            
            // Cannot set the view model's
            // view more than once
            
            return
            
        }
        
        self.view = view
        
    }
    
}

#endif
