////
////  ContextMenuActionBuilder.swift
////  Espresso
////
////  Created by Mitch Treece on 7/29/22.
////
//
//import UIKit
//
///// A context menu action builder.
//public struct ContextMenuActionBuilder: ContextMenuElementBuilder {
//        
//    /// The action's title.
//    public var title: String = .empty
//    
//    /// The action's subtitle.
//    public var subtitle: String?
//    
//    /// The action's image.
//    public var image: UIImage?
//    
//    /// The action's identifier.
//    public var identifier: String?
//    
//    /// The action's attributes.
//    public var attributes: UIMenuElement.Attributes = []
//    
//    /// The action's state.
//    public var state: UIMenuElement.State = .off
//    
//    /// The action's action handler.
//    public var action: UIActionHandler?
//    
//    internal init() {
//        //
//    }
//        
//    internal func buildElement() -> ContextMenuElement {
//        
//        return UIContextMenuAction(
//            title: self.title,
//            subtitle: self.subtitle,
//            image: self.image,
//            identifier: self.identifier,
//            attributes: self.attributes,
//            state: self.state,
//            action: self.action ?? { _ in }
//        )
//        
//    }
//    
//}
