//
//  UIDeferredMenuElementBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/3/22.
//

import UIKit

@available(iOS 14, *)
public typealias UIDeferredMenuElementCompletion = ([UIMenuElement])->()

@available(iOS 14, *)
public protocol UIDeferredMenuElementBuildable {
    
    var elementProvider: ((@escaping UIDeferredMenuElementCompletion)->())? { get set }
    
}

@available(iOS 14, *)
internal struct UIDeferredMenuElementBuilder: Builder, UIDeferredMenuElementBuildable {
    
    typealias BuildType = UIDeferredMenuElement
    
    var elementProvider: ((@escaping UIDeferredMenuElementCompletion)->())?

    func build() -> UIDeferredMenuElement {
        return UIDeferredMenuElement(buildable: self)
    }
    
}

@available(iOS 14, *)
public extension UIDeferredMenuElement {
    
    convenience init(builder: (inout UIDeferredMenuElementBuildable)->()) {
                
        var buildable: UIDeferredMenuElementBuildable = UIDeferredMenuElementBuilder()
        
        builder(&buildable)

        self.init(buildable: buildable)
        
    }
    
    internal convenience init(buildable: UIDeferredMenuElementBuildable) {
        
        self.init(buildable.elementProvider ?? { completion in
            completion([])
        })
        
    }
    
}
