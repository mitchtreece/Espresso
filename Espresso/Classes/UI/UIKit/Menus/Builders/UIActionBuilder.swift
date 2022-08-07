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
    var identifier: MenuElementIdentifier? { get set }
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
    var identifier: MenuElementIdentifier?
    var discoverabilityTitle: String?
    var attributes: UIMenuElement.Attributes = []
    var state: UIMenuElement.State = .off
    var handler: UIActionHandler = { _ in }
        
    @available(iOS 15, *)
    var subtitle: String? {
        get {
            return self._subtitle
        }
        set {
            self._subtitle = newValue
        }
    }
    
    private var _subtitle: String?
    
    init() {
        //
    }
    
    init(buildable: UIActionBuildable) {
        
        self.title = buildable.title
        self.image = buildable.image
        self.identifier = buildable.identifier
        self.discoverabilityTitle = buildable.discoverabilityTitle
        self.attributes = buildable.attributes
        self.state = buildable.state
        self.handler = buildable.handler
        
        if #available(iOS 15, *) {
            self.subtitle = buildable.subtitle
        }
        
    }
    
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

}

internal extension UIAction {

    convenience init(buildable: UIActionBuildable) {

        self.init(
            title: buildable.title,
            image: buildable.image,
            identifier: (buildable.identifier != nil) ? .init(buildable.identifier!) : nil,
            discoverabilityTitle: buildable.discoverabilityTitle,
            attributes: buildable.attributes,
            state: buildable.state,
            handler: buildable.handler
        )

        if #available(iOS 15, *) {
            self.subtitle = buildable.subtitle
        }

    }

}
