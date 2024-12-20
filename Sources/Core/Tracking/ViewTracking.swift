//
//  ViewTracking.swift
//  Espresso
//
//  Created by Mitch on 12/19/24.
//

import Foundation

/// Protocol describing something that tracks a view.
public protocol ViewTracker {
    
    /// Tracks a view.
    func trackView()
    
}

/// Protocol describing something that manages
/// view tracking execution.
public protocol ViewTracking: ViewTracker {
    
    /// The managed view tracker.
    var viewTracker: ViewTracker? { get }
    
    /// The view tracking mode.
    var viewTrackingMode: ViewTrackingMode { get }
    
    /// Flag indicating if a view has been tracked or not.
    var didTrackView: Bool { get }
        
}

/// Representation of the various view tracking modes.
public enum ViewTrackingMode {
    
    /// A tracking mode associated with a view instance.
    case instance
    
    /// A tracking mode associated with a view's appearance.
    case appearance
    
}
