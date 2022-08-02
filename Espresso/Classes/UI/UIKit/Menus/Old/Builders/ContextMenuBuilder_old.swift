////
////  ContextMenuBuilder.swift
////  Espresso
////
////  Created by Mitch Treece on 7/29/22.
////
//
//import UIKit
//
///// A context menu sub-menu builder.
//public struct ContextMenuBuilder: ContextMenuElementBuilder, ContextMenuElementContainer {
//            
//    /// The menu's title.
//    public var title: String = .empty
//    
//    /// The menu's subtitle.
//    public var subtitle: String?
//    
//    /// The menu's image.
//    public var image: UIImage?
//    
//    /// The menu's identifier.
//    public var identifier: String?
//    
//    /// The menu's options.
//    public var options: UIMenu.Options = []
//    
//    /// The menu's element size.
//    ///
//    /// This is supported on iOS 16 and higher. This will be completely
//    /// ignored if running on a device on iOS 15 or lower.
//    public var elementSize: UIMenuElementSize = .large
//    
//    /// The menu's elements.
//    public var elements: [ContextMenuElement] = []
//    
//    internal init() {
//        //
//    }
//    
//    internal func buildElement() -> ContextMenuElement {
//        
//        return UIContextMenuSubMenu(
//            title: self.title,
//            subtitle: self.subtitle,
//            image: self.image,
//            identifier: self.identifier,
//            options: self.options,
//            elementSize: self.elementSize,
//            elements: self.elements
//        )
//        
//    }
//    
//}
