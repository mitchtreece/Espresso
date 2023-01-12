//
//  UIModalStyle.swift
//  Espresso
//
//  Created by Mitch Treece on 10/23/19.
//

import UIKit

// Updated for iOS 16:
// UIModalPresentationFullScreen = 0,
// UIModalPresentationPageSheet API_AVAILABLE(ios(3.2)) API_UNAVAILABLE(tvos),
// UIModalPresentationFormSheet API_AVAILABLE(ios(3.2)) API_UNAVAILABLE(tvos),
// UIModalPresentationCurrentContext API_AVAILABLE(ios(3.2)),
// UIModalPresentationCustom API_AVAILABLE(ios(7.0)),
// UIModalPresentationOverFullScreen API_AVAILABLE(ios(8.0)),
// UIModalPresentationOverCurrentContext API_AVAILABLE(ios(8.0)),
// UIModalPresentationPopover API_AVAILABLE(ios(8.0)) API_UNAVAILABLE(tvos),
// UIModalPresentationBlurOverFullScreen API_AVAILABLE(tvos(11.0)) API_UNAVAILABLE(ios) API_UNAVAILABLE(watchos),
// UIModalPresentationNone API_AVAILABLE(ios(7.0)) = -1,
// UIModalPresentationAutomatic API_AVAILABLE(ios(13.0)) = -2,

/// Declarative wrapper over `UIModalPresentationStyle`.
public enum UIModalStyle {
    
    /// Representation of the various presenting view modes.
    public enum PresentingViewMode {
        
        /// A mode where the presenting view is visible.
        ///
        /// This corresponds with modal presentation styles where
        /// the presenting view controller should remain in the window
        /// hierarchy after the presentation finishes.
        ///
        /// i.e. `overFullscreen` & `overCurrentContext`.
        case visible
        
        /// A mode where the presenting view is hidden.
        ///
        /// This corresponds with modal presentation styles where
        /// the presenting view controller should be removed from
        /// the window hierarchy after the presentation finishes.
        ///
        /// i.e. `fullscreen` & `currentContext`.
        case hidden
        
    }
    
    /// Representation of the various modal sheet types.
    public enum SheetType {
        
        /// A page sheet type.
        ///
        /// This corresponds with the `pageSheet` modal presentation style.
        case page
        
        /// A form sheet type.
        ///
        /// This corresponds with the `formSheet` modal presentation style.
        case form
        
    }
    
    /// A modal style representing the absence of a modal style.
    case none
    
    /// A default modal style.
    ///
    /// On iOS 13, this corresponds to the `automatic` modal presentation style.
    /// On prior iOS versions, this corresponds to the `fullscreen` modal presentation style.
    case `default`
    
    /// A fullscreen modal style.
    ///
    /// **presentingView**: The presenting view mode.
    case fullscreen(presentingView: PresentingViewMode)
    
    /// A contextual modal style.
    ///
    /// **presentingView**: The presenting view mode.
    case currentContext(presentingView: PresentingViewMode)
    
    /// A sheet modal style.
    ///
    /// **type**: The sheet type.
    case sheet(type: SheetType)
    
    /// A popover modal style.
    case popover
    
    /// A custom modal style.
    case custom
    
    /// Flag indicating if the modal style represents a sheet presentation style.
    ///
    /// This is **always** `false` on iOS 12 or lower.
    public var isModalSheet: Bool {
        
        switch self {
        case .default: fallthrough
        case .sheet: return true
        default: return false
        }
        
    }
    
    /// Initializes a `ModalStyle` from a modal presentation style.
    ///
    /// - parameter modalPresentationStyle: The modal presentation style.
    public init(modalPresentationStyle: UIModalPresentationStyle) {
        
        switch modalPresentationStyle {
        case .fullScreen: self = .fullscreen(presentingView: .hidden)
        case .overFullScreen: self = .fullscreen(presentingView: .visible)
        case .pageSheet: self = .sheet(type: .page)
        case .formSheet: self = .sheet(type: .form)
        case .currentContext: self = .currentContext(presentingView: .hidden)
        case .overCurrentContext: self = .currentContext(presentingView: .visible)
        case .custom: self = .custom
        case .popover: self = .popover
        case .automatic: self = .default
        case .none: self = .none
        @unknown default: self = .default
        }
        
    }
    
    /// A `UIModalPresentationStyle` representation.
    public func asModalPresentationStyle() -> UIModalPresentationStyle {
        
        switch self {
        case .none: return .none
        case .default: return .automatic
        case .fullscreen(let mode):
            
            switch mode {
            case .visible: return .overFullScreen
            case .hidden: return .fullScreen
            }
        
        case .currentContext(let mode):
            
            switch mode {
            case .visible: return .overCurrentContext
            case .hidden: return .currentContext
            }
            
        case .sheet(let type):
            
            switch type {
            case .page: return .pageSheet
            case .form: return .formSheet
            }
            
        case .popover: return .popover
        case .custom: return .custom
        }
        
    }
    
}
