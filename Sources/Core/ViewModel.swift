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
public protocol ViewModelProtocol: Equatable {
    //
}

/// Base view-model class.
///
/// This should never be used directly. Instead, create a specialized `ViewModel` by subclassing it.
open class ViewModel: ViewModelProtocol {
     
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        return lhs === rhs
    }
    
    public init() {
        //
    }
    
}
