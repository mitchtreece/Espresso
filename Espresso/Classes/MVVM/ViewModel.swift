//
//  ViewModel.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import Foundation

public protocol ViewModelProtocol: Equatable {
    //
}

open class ViewModel: ViewModelProtocol {
    
    public init() {
        //
    }
    
    public static func == (lhs: ViewModel, rhs: ViewModel) -> Bool {
        return lhs === rhs
    }
    
}
