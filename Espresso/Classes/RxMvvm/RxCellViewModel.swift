//
//  RxCellViewModel.swift
//  Espresso
//
//  Created by Mitch Treece on 11/3/18.
//

import RxDataSources

public typealias RxCellViewModelProtocol = (ViewModel & IdentifiableType & Equatable)

public class RxCellViewModel: RxCellViewModelProtocol, Identifiable {
    
    public typealias Identity = String
    
    public private(set) var identity: String = ""
    
    public init(identity: String? = nil) {
        self.identity = identity ?? type(of: self).identifier
    }
    
    public static func == (lhs: RxCellViewModel, rhs: RxCellViewModel) -> Bool {
        return lhs === rhs
    }
    
}
