//
//  ViewModel.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import Foundation

// TODO: Remove this once `Pilot` is released
// All architecture-level stuff should be in that library.

/// Abstract protocol representing a view model.
public protocol ViewModel: Equatable, ObservableObject {}

/// Base view-model class.
///
/// - Note: This should never be used directly.
///   Instead, create a specialized `ESViewModel` by subclassing it.
open class ViewModelBase: ViewModel {
     
    public static func == (lhs: ViewModelBase, rhs: ViewModelBase) -> Bool {
        return lhs === rhs
    }
    
    public init() {}
    
}
