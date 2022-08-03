//
//  UIMenuBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public protocol UIMenuBuildable: UIMenuElementContainer {
    
    var title: String { get set }
    var subtitle: String? { get set }
    var image: UIImage? { get set }
    var identifier: String? { get set }
    var options: UIMenu.Options { get set }
    var elementSize: UIMenuElementSize { get set }
    
}

internal struct UIMenuBuilder: Builder, UIMenuBuildable {
    
    public typealias BuildType = UIMenu
    
    public var title: String = .empty
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    public var options: UIMenu.Options = []
    public var elementSize: UIMenuElementSize = .large
    public var elements: [UIMenuElement] = []
    
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
                preferredElementSize: buildable.elementSize.asMenuElementSize(),
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
