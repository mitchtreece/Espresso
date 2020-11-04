//
//  ViewModel.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import Foundation

/// Abstract protocol representing a view model.
public protocol ViewModelProtocol: Equatable {
    //
}

/// View model base class.
///
/// This should never be used directly. Instead, create a specialized `ViewModel` by subclassing it.
open class ViewModel: ViewModelProtocol {
        
    public init() {
        //
    }
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        return lhs === rhs
    }
    
}
