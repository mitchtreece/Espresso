//
//  RxCellViewModel.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import RxDataSources

/**
 An Rx-based cell view model base class.
 
 This should never be used directly. Instead, create a specialized `RxCellViewModel` by subclassing it.
 */
open class RxCellViewModel: ViewModel, IdentifiableType, Identifiable {
    
    /// The view model identity type used by RxDataSources.
    public typealias Identity = String
    
    /// The view model's identity used by RxDataSources.
    public private(set) var identity: String = ""
    
    /**
     Initializes an `RxCellViewModel`.
     - Parameter identity: The identity to use for the view model; _defaults to nil_.
     
     If no identity is specified, one will be derived from the view model's class name via the `Identifiable` protocol.
     */
    public init(identity: String? = nil) {
        
        if let identity = identity {
            self.identity = identity
        }
        
        self.identity = type(of: self).identifier
        
    }
    
}
