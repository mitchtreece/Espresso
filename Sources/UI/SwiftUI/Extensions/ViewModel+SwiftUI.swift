//
//  ViewModel+SwiftUI.swift
//  EspressoUI
//
//  Created by Mitch on 1/31/25.
//

import Espresso
import SwiftUI

public extension ViewModel {
    
    /// Gets a `StateObject` representation of the view model.
    func asStateObject() -> StateObject<Self> {
        return .init(wrappedValue: self)
    }
    
}
