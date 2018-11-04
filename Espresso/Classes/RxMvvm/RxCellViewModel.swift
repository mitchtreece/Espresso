//
//  RxCellViewModel.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import RxDataSources

open class RxCellViewModel: ViewModel, IdentifiableType, Identifiable {
    
    public typealias Identity = String
    
    public private(set) var identity: String = ""
    
    public init(identity: String? = nil) {
        
        if let identity = identity {
            self.identity = identity
        }
        
        self.identity = type(of: self).identifier
        
    }
    
    public static func == (lhs: RxCellViewModel, rhs: RxCellViewModel) -> Bool {
        return lhs === rhs
    }
    
}
