//
//  ContextMenuElementBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import Foundation

internal protocol ContextMenuElementBuilder {
    
    func build() -> ContextMenuElement
    
}
