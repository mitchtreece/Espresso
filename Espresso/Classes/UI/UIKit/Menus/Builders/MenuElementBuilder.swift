//
//  MenuElementBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import Foundation

internal protocol MenuElementBuilder {
    
    associatedtype ElementType: MenuElement

    func build() -> ElementType
    
}
