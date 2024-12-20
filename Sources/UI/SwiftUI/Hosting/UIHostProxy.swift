//
//  UIHostProxy.swift
//  Espresso
//
//  Created by Mitch on 12/18/24.
//

import UIKit
import SwiftUI

/// Class that acts as the link between a `SwiftUI` view,
/// and its parent hosting controller and/or view.
public final class UIHostProxy<Content: View>: ObservableObject {
    
    /// The hosting view.
    public internal(set) weak var view: UIView?
    
    /// The hosting controller.
    public internal(set) weak var controller: UIViewController?
    
    /// Initializes a host proxy.
    public init() {}
    
}
