//
//  ViewModelView.swift
//  Espresso
//
//  Created by Mitch Treece on 8/7/22.
//

import SwiftUI

// Ignore this import warning
//
// We need to import this so SPM modules
// have access to 'Core' classes
import Espresso
////////////////////////////////////////

/// Protocol describing a view that is backed by a view model.
public protocol ViewModelView: View {
    
    associatedtype V: ViewModel
    
    /// The view's backing view model.
    var viewModel: V { get }
    
    /// Initializes a view with a view model.
    /// - parameter viewModel: The view model.
    init(viewModel: V)
    
}
