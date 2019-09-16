//
//  DIStorage.swift
//  Director
//
//  Created by Mitch Treece on 9/14/19.
//

import Swinject

internal class DIStorage {
    
    static let shared = DIStorage()
    
    var resolver: Resolver?
    
    private init() {
        //
    }
    
}
