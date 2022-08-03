//
//  UIMenuBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public protocol UIMenuBuildable: UIMenuElementContainer {
    
    var title: String { get set }
    var image: UIImage? { get set }
    var identifier: String? { get set }
    var options: UIMenu.Options { get set }
    
    @available(iOS 15, *)
    var subtitle: String? { get set }
    
    @available(iOS 16, *)
    var elementSize: UIMenu.ElementSize { get set }
        
}

internal struct UIMenuBuilder: Builder, UIMenuBuildable {
    
    public typealias BuildType = UIMenu
    
    public var title: String = .empty
    public var image: UIImage?
    public var identifier: String?
    public var options: UIMenu.Options = []
    public var elements: [UIMenuElement] = []
    
    @available(iOS 15, *)
    public var subtitle: String? {
        get {
            return self._subtitle
        }
        set {
            self._subtitle = newValue
        }
    }
    
    @available(iOS 16, *)
    public var elementSize: UIMenu.ElementSize {
        get {
            return (self._elementSize as? UIMenu.ElementSize) ?? .large
        }
        set {
            self._elementSize = newValue
        }
    }
    
    private var _subtitle: String?
    private var _elementSize: Any?
    
    public func build() -> UIMenu {
        return UIMenu(buildable: self)
    }
    
}

public extension UIMenu {

    convenience init(builder: (inout UIMenuBuildable)->()) {
                
        var buildable: UIMenuBuildable = UIMenuBuilder()
        
        builder(&buildable)

        self.init(buildable: buildable)
        
    }
    
    internal convenience init(buildable: UIMenuBuildable) {

        if #available(iOS 16, *) {
            
            self.init(
                title: buildable.title,
                subtitle: buildable.subtitle,
                image: buildable.image,
                identifier: (buildable.identifier != nil) ? .init(buildable.identifier!) : nil,
                options: buildable.options,
                preferredElementSize: buildable.elementSize,
                children: buildable.elements
            )
            
        }
        else if #available(iOS 15, *) {
            
            self.init(
                title: buildable.title,
                subtitle: buildable.subtitle,
                image: buildable.image,
                identifier: (buildable.identifier != nil) ? .init(buildable.identifier!) : nil,
                options: buildable.options,
                children: buildable.elements
            )
            
        }
        else {
            
            self.init(
                title: buildable.title,
                image: buildable.image,
                identifier: (buildable.identifier != nil) ? .init(buildable.identifier!) : nil,
                options: buildable.options,
                children: buildable.elements
            )
            
        }
        
    }

}
