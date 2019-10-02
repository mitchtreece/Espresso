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
                // we need to remove the old one. Assuming there is only one
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
    
    /// Struct representing an element in a `UIContextMenu`.
    public struct Item {
        
        private let title: String
        private let image: UIImage?
        private let identifier: String?
        
        // UIAction
        private let actionAttributes: UIMenuElement.Attributes?
        private let action: UIActionHandler?
        
        // UIMenu
        private let menuOptions: UIMenu.Options?
        private let menuChildren: [Item]?
        
        internal var element: UIMenuElement? {
            
            if let action = self.action {
                
                return UIAction(
                    title: self.title,
                    image: self.image,
                    identifier: (self.identifier != nil) ? UIAction.Identifier(self.identifier!) : nil,
                    attributes: self.actionAttributes ?? [],
                    handler: action
                )
                
            }
            else if let children = self.menuChildren {
                                
                return UIMenu(
                    title: self.title,
                    image: self.image,
                    identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
                    options: self.menuOptions ?? [],
                    children: children.compactMap { $0.element }
                )
                
            }
            
            return nil
            
        }
        
        /// Initializes a context menu action item.
        /// - parameter title: The action's title.
        /// - parameter image: The action's image; _defaults to nil_.
        /// - parameter identifier: The action's identifier; _defaults to nil_.
        /// - parameter attributes: The action's style attributes; _defaults to nil_.
        /// - parameter handler: The action's handler.
        public static func action(title: String,
                                  image: UIImage? = nil,
                                  identifier: String? = nil,
                                  attributes: UIMenuElement.Attributes? = nil,
                                  handler: @escaping UIActionHandler) -> Item {
            
            return Item(
                title: title,
                image: image,
                identifier: identifier,
                actionAttributes: attributes,
                action: handler,
                menuOptions: nil,
                menuChildren: nil
            )
            
        }
        
        /// Initializes a child context menu item.
        /// - parameter title: The menu's title.
        /// - parameter image: The menu's image; _defaults to nil_.
        /// - parameter identifier: The menu's identifier; _defaults to nil_.
        /// - parameter options: The menu's style options; _defaults to nil_.
        /// - parameter children: The menu's child items.
        public static func menu(title: String,
                                image: UIImage? = nil,
                                identifier: String? = nil,
                                options: UIMenu.Options? = nil,
                                children: [Item]) -> Item {
            
            return Item(
                title: title,
                image: image,
                identifier: identifier,
                actionAttributes: nil,
                action: nil,
                menuOptions: options,
                menuChildren: children
            )
            
        }
        
    }

    /// The context menu's title.
    public let title: String
    
    /// The context menu's image.
    public let image: UIImage?
    
    /// The context menu's identifier.
    public let identifier: String?
    
    /// The context menu's preview providing closure.
    ///
    /// If this is `nil`, the system will automatically
    /// generate a preview based on the context menu's parent view.
    public let previewProvider: UIContextMenuContentPreviewProvider?
    
    /// The context menu's preview commit closure.
    ///
    /// This will be called after a user taps on the context menu's preview.
    /// If possible, the currently previewed view controller will be provided
    /// to the closure. Perform navigation or other tasks if needed.
    public let commitHandler: ((UIViewController?)->())?
        
    /// The context menu's preferred preview commit style; _defaults to pop_.
    public var commitStyle: UIContextMenuInteractionCommitStyle = .pop
    
    /// Flag indicating if tapping on a provided preview should
    public let automaticallyPopToPreview: Bool = true
    
    /// The context menu's items.
    public let items: [Item]
    
    /// Flag indicating if system-suggested menu items should be displayed.
    public let includeSuggestedItems: Bool
    
    private var configuration: UIContextMenuConfiguration?
    
    /// Initializes a new `UIContextMenu`.
    /// - parameter title: The context menu's title.
    /// - parameter image: The context menu's image; _defaults to nil_.
    /// - parameter identifier: The context menu's identifier; _defaults to nil_.
    /// - parameter previewProvider: The context menu's preview providing closure; _defaults to nil_.
    /// - parameter commitHandler: The context menu's preview commit closure; _defaults to nil_.
    /// - parameter items: The context menu's items.
    /// - parameter includeSuggestedItems: Flag indicating if system-suggested items should be displayed; _defaults to false_.
    public init(title: String,
                image: UIImage? = nil,
                identifier: String? = nil,
                previewProvider: UIContextMenuContentPreviewProvider? = nil,
                commitHandler: ((UIViewController?)->())? = nil,
                items: [Item],
                includeSuggestedItems: Bool = false) {
        
        self.title = title
        self.image = image
        self.identifier = identifier
        self.previewProvider = previewProvider
        self.commitHandler = commitHandler
        self.items = items
        self.includeSuggestedItems = includeSuggestedItems
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        if let configuration = self.configuration {
            return configuration
        }
        
        self.configuration = UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: self.previewProvider,
            actionProvider: { suggestedElements -> UIMenu? in
                              
                var children = self.items.compactMap { $0.element }
                
                if self.includeSuggestedItems {
                    children.append(contentsOf: suggestedElements)
                }
                
                return UIMenu(
                    title: self.title,
                    image: self.image,
                    identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
                    options: [],
                    children: children
                )
                
            })
        
        return self.configuration!
                
    }
        
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                                       animator: UIContextMenuInteractionCommitAnimating) {
        
        // If this protocol function is implemented,
        // the system always performs some kind of animation.
        // This isn't ideal, but doesn't hurt anything.
        //
        // Need to find a way to conditionally adopt this function
        // Only when needed. responds(toSelector:) fuckery?
        
        guard let handler = self.commitHandler else {
            return
        }
                
        animator.preferredCommitStyle = self.commitStyle
        animator.addCompletion {
            handler(animator.previewViewController)
        }
        
    }
    
}
