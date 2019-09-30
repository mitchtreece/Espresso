//
//  UIContextMenu.swift
//  Director
//
//  Created by Mitch Treece on 9/28/19.
//

import UIKit

@available(iOS 13, *)
public extension UIView {
    
    private struct AssociatedKeys {
        static var contextMenu: UInt8 = 0
    }
    
    /// The view's associated context menu.
    var contextMenu: UIContextMenu? {
        set {
            
            if let _ = self.contextMenu {
                
                // If we already have a context menu, and we're setting a new one
                // we need to remove the old one. Assuming there is only onw
                // `UIContextMenuInteraction` registered to a view at a time.
                
                let interaction = self.interactions
                    .compactMap { $0 as? UIContextMenuInteraction }
                    .first
                
                if let currentCurrentMenuInteraction = interaction {
                    self.removeInteraction(currentCurrentMenuInteraction)
                }
                
            }
            
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.contextMenu,
                newValue,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
            
            if let menu = newValue {
                self.addInteraction(UIContextMenuInteraction(delegate: menu))
            }
                        
        }
        get {
            return objc_getAssociatedObject(self, &AssociatedKeys.contextMenu) as? UIContextMenu
        }
    }
    
}

/// `UIContextMenu` is a wrapper class over `UIContextMenuInteraction` & `UIContextMenuInteractionDelegate`.
@available(iOS 13, *)
public class UIContextMenu: NSObject, UIContextMenuInteractionDelegate {

    /// The context menu's title.
    public let title: String
    
    /// The context menu's image.
    public let image: UIImage?
    
    /// The context menu's identifier.
    public let identifier: String?
    
    /// The context menu's actions.
    public let actions: [UIAction]
    
    private var configuration: UIContextMenuConfiguration?
    
    /// Initializes a new `UIContextMenu`.
    /// - parameter title: The context menu's title.
    /// - parameter image: The context menu's image.
    /// - parameter identifier: The context menu's identifier.
    /// - parameter actions: The context menu's actions.
    public init(title: String,
                image: UIImage?,
                identifier: String?,
                actions: [UIAction]) {
        
        self.title = title
        self.image = image
        self.identifier = identifier
        self.actions = actions
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        if let configuration = self.configuration {
            return configuration
        }
        
        self.configuration = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: nil,
            actionProvider: { suggestedElements -> UIMenu? in
                                
                return UIMenu(
                    title: self.title,
                    image: self.image,
                    identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
                    options: [],
                    children: self.actions
                )
                
            })
        
        return self.configuration!
                
    }
    
}
