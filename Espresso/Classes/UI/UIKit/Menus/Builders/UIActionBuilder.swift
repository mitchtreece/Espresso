//
//  UIActionBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public protocol UIActionBuildable {
    
    var title: String { get set }
    var image: UIImage? { get set }
    var identifier: String? { get set }
    var discoverabilityTitle: String? { get set }
    var attributes: UIMenuElement.Attributes { get set }
    var state: UIMenuElement.State { get set }
    var handler: UIActionHandler { get set }
    
    @available(iOS 15, *)
    var subtitle: String? { get set }
    
}

internal struct UIActionBuilder: Builder, UIActionBuildable {
        
    typealias BuildType = UIAction
    
    var title: String = .empty
    var image: UIImage?
    var identifier: String?
    var discoverabilityTitle: String?
    var attributes: UIMenuElement.Attributes = []
    var state: UIMenuElement.State = .off
    var handler: UIActionHandler = { _ in }
        
    @available(iOS 15, *)
    public var subtitle: String? {
        get {
            return self._subtitle
        }
        set {
            self._subtitle = newValue
        }
    }
    
    private var _subtitle: String?
    
    func build() -> UIAction {
        return UIAction(buildable: self)
    }
    
}

public extension UIAction {
    
    convenience init(builder: (inout UIActionBuildable)->()) {
        
        var buildable: UIActionBuildable = UIActionBuilder()
        
        builder(&buildable)

        self.init(buildable: buildable)
        
    }
    
    internal convenience init(buildable: UIActionBuildable) {
        
        if #available(iOS 15, *) {
            
            self.init(
                title: buildable.title,
                subtitle: buildable.subtitle,
                image: buildable.image,
                identifier: (buildable.identifier != nil) ? .init(buildable.identifier!) : nil,
                discoverabilityTitle: buildable.discoverabilityTitle ?? buildable.subtitle,
                attributes: buildable.attributes,
                state: buildable.state,
                handler: buildable.handler
            )
            
        }
        else {
                        
            self.init(
                title: buildable.title,
                image: buildable.image,
                identifier: (buildable.identifier != nil) ? .init(buildable.identifier!) : nil,
                discoverabilityTitle: buildable.discoverabilityTitle,
                attributes: buildable.attributes,
                state: buildable.state,
                handler: buildable.handler
            )
                        
        }
        
    }

}
