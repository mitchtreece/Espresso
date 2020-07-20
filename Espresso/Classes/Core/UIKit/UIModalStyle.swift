//
//  UIModalStyle.swift
//  Espresso
//
//  Created by Mitch Treece on 10/23/19.
//

import Foundation

// As of iOS 13:
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

/// `UIModalStyle` is a declarative wrapper over `UIModalPresentationStyle`.
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
    
    /// The `UIModalPresentationStyle` representation.
    public var presentationStyle: UIModalPresentationStyle {
        
        switch self {
        case .none: return .none
        case .default:
            
            if #available(iOS 13, *) {
                return .automatic
            }
            
            return .fullScreen
            
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
    
    /// Flag indicating if the modal style represents a card-like presentation style.
    ///
    /// This is **always** `false` on iOS 12 or lower.
    public var isModalCard: Bool {
        
        if #available(iOS 13, *) {
            
            switch self {
            case .default: fallthrough
            case .sheet(type: .page): return true
            default: return false
            }
            
        }
        
        return false
        
    }
    
    /// Creates a `UIModalStyle` from a given modal presentation style.
    /// - Parameter presentationStyle: The modal presentation style.
    /// - Returns: A `UIModalStyle` instance.
    public static func from(presentationStyle: UIModalPresentationStyle) -> UIModalStyle {
        
        switch presentationStyle {
        case .fullScreen: return .fullscreen(presentingView: .hidden)
        case .overFullScreen: return .fullscreen(presentingView: .visible)
        case .pageSheet: return .sheet(type: .page)
        case .formSheet: return .sheet(type: .form)
        case .currentContext: return .currentContext(presentingView: .hidden)
        case .overCurrentContext: return .currentContext(presentingView: .visible)
        case .custom: return .custom
        case .popover: return .popover
        case .automatic: return .default
        case .none: return .none
        @unknown default: return .default
        }
                
    }
    
}
