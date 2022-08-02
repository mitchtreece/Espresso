//
//  UIContextMenu.swift
//  Espresso
//
//  Created by Mitch Treece on 7/29/22.
//

import UIKit

/// Provides a previewing `UIViewController` used while a context menu preview is being committed.
public typealias UIContextMenuContentPreviewCommitter = (UIViewController?)->()

/// Context menu class that manages the layout, presentation, & interaction of view menus & previews.
public class UIContextMenu: NSObject, ContextMenu {
    
    /// Provides context menu data, and returns a view controller for previewing.
    public typealias PreviewProvider = ([String: Any])->UIViewController?
    
    /// Provides context menu data and a previewing view controller used while a context menu preview is being committed.
    public typealias PreviewCommitter = ([String: Any], UIViewController?)->()
    
    /// Provides context menu data, and returns a targeted preview for the context menu.
    public typealias TargetedPreviewProvider = ([String: Any])->UITargetedPreview?
    
    /// The context menu's title.
    public var title: String?

    /// The context menu's subtitle.
    ///
    /// This is ignored, and only relevant for child menu elements.
    /// It's exposed here _only_ for protocol conformance.
    public var subtitle: String?
    
    /// The context menu's image.
    ///
    /// This is ignored, and only relevant for child menu elements.
    /// It's exposed here _only_ for protocol conformance.
    public var image: UIImage?

    /// The context menu's identifier.
    public var identifier: String?
    
    /// The contet menu's options.
    public var options: UIMenu.Options = []

    /// The context menu's elements.
    public var elements: [ContextMenuElement]
    
    /// The context menu's preview providing closure.
    ///
    /// If this is `nil`, the system will automatically
    /// generate a preview based on the context menu's parent view.
    public var previewProvider: PreviewProvider?
    
    /// The context menu's preview commit closure.
    ///
    /// This will be called after a user taps on the context menu's preview.
    /// If possible, the currently previewed view controller will be provided
    /// to the closure. Perform navigation or other tasks if needed.
    public var previewCommitter: PreviewCommitter?

    /// The context menu's preferred preview commit style; _defaults to pop_.
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop

    /// The context menu's targeted highlight preview provider.
    public var targetedHighlightPreviewProvider: TargetedPreviewProvider?
    
    /// The context menu's targeted dismiss preview provider.
    public var targetedDismissPreviewProvider: TargetedPreviewProvider?
    
    /// Flag indicating if suggested system menu elements should be displayed.
    public var includeSuggestedElements: Bool = false
    
    /// Closure called when the context menu is about to be presented.
    ///
    /// Depending on what kind of target the context menu is added to,
    /// this closure _may_ or _may not_ be called. Under certain circumstances,
    /// `UIKit` "hijacks" the underlying interaction delegate, causing
    /// presentation & dismissal delegate functions to not be called.
    ///
    /// When added to a `UIView`, this closure is called as expected.
    ///
    /// When added to a `UIButton`, this closure will **not** be called.
    ///
    /// When added to a `UIBarButtonItem` this closure will **not** be called.
    ///
    /// When part of an interaction on `UITableView` or `UICollectionView`,
    /// this closure will be called as expected **if** the required delegate
    /// functions are implemented.
    public var willPresent: (()->())?
    
    /// Closure called when the context menu is about to be dismissed.
    ///
    /// Depending on what kind of target the context menu is added to,
    /// this closure _may_ or _may not_ be called. Under certain circumstances,
    /// `UIKit` "hijacks" the underlying interaction delegate, causing
    /// presentation & dismissal delegate functions to not be called.
    ///
    /// When added to a `UIView`, this closure is called as expected.
    ///
    /// When added to a `UIButton`, this closure will **not** be called.
    ///
    /// When added to a `UIBarButtonItem` this closure will **not** be called.
    ///
    /// When part of an interaction on `UITableView` or `UICollectionView`,
    /// this closure will be called as expected **if** the required delegate
    /// functions are implemented.
    public var willDismiss: (()->())?

    /// The context menu's associated data dictionary.
    public private(set) var data = [String: Any]()
    
    /// The context menu's table view configuration.
    ///
    /// Use this to forward handling of relevant table view delegate calls to the context menu.
    public private(set) var tableConfiguration: TableConfiguration!
    
    /// The context menu's collection view configuration.
    ///
    /// Use this to forward handling of relevant collection view delegate calls to the context menu.
    public private(set) var collectionConfiguration: CollectionConfiguration!

    /// Initializes an empty context menu.
    public override init() {
        
        self.elements = []
        
        super.init()
        
        setup()
        
    }
    
    /// Initializes a context menu with elements.
    ///
    /// - parameter elements: The context menu's elements.
    public init(elements: [ContextMenuElement]) {
        
        self.elements = elements
        
        super.init()
        
        setup()
        
    }

    /// Initializes a context menu using a building closure.
    ///
    /// - parameter block: The building closure.
    public convenience init(_ block: (inout ContextMenuRootBuilder)->()) {

        var builder = ContextMenuRootBuilder()
        
        block(&builder)
                
        self.init(builder: builder)
        
    }
    
    internal init(builder: ContextMenuRootBuilder) {
        
        self.title = builder.title ?? ""
        self.identifier = builder.identifier
        self.options = builder.options
        self.elements = builder.elements
        
        self.previewProvider = builder.previewProvider
        self.previewCommitter = builder.previewCommitter
        self.previewCommitStyle = builder.previewCommitStyle
        self.targetedHighlightPreviewProvider = builder.targetedHighlightPreviewProvider
        self.targetedDismissPreviewProvider = builder.targetedDismissPreviewProvider
        
        self.includeSuggestedElements = builder.includeSuggestedElements
        
        self.willPresent = builder.willPresent
        self.willDismiss = builder.willDismiss
        
        super.init()
        
        setup()
        
    }
    
    private func setup() {
        
        self.tableConfiguration = TableConfiguration(contextMenu: self)
        self.collectionConfiguration = CollectionConfiguration(contextMenu: self)
        
    }
    
    /// Adds the context menu to a target.
    ///
    /// - parameter target: The target to add the context menu to.
    /// - returns: This context menu.
    ///
    /// This function acts differently depending on the type of the target.
    ///
    /// For a `UIView`, this calls `addInteraction(interaction:)`
    /// and does **not** hold a strong reference to the context menu.
    ///
    /// For a `UIButton` on iOS 14 or higher, this sets the button's `menu` property.
    /// On iOS 13 and lower, this treats the button like a `UIView` and does **not**
    /// hold a strong reference to the context menu.
    ///
    /// For a `UIBarButtonItem` on iOS 14 or higher, this sets the item's `menu` property.
    /// On iOS 13 or lower, this is ignored.
    @discardableResult
    public func addTo(_ target: ContextMenuTarget) -> Self {
        
        target.addContextMenu(self)
        return self
        
    }
            
    /// Sets associated data using a given key.
    ///
    /// - parameter data: The data.
    /// - parameter key: The key to store the data under.
    /// - returns: This context menu.
    @discardableResult
    public func setData(_ data: Any,
                        forKey key: String) -> Self {
        
        self.data[key] = data
        return self
        
    }
    
    /// Gets associated data using a given key.
    ///
    /// - parameter key: The key the data is stored under.
    /// - returns: The stored data.
    public func getData(_ key: String) -> Any? {
        return self.data[key]
    }
    
    // MARK: Builders
    
    public func buildMenuElement() -> UIMenuElement {
                
        return UIMenu(
            title: self.title ?? "",
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: self.elements.map { $0.buildMenuElement() }
        )
        
    }
    
    /// Builds a `UIMenu` from this context menu.
    ///
    /// - parameter additionalElements: Additional elements to append to this context menu's
    /// existing elements while building; _defaults to none_.
    /// - returns: A new `UIMenu`.
    public func buildMenu(additionalElements: [UIMenuElement] = []) -> UIMenu {
                
        guard !additionalElements.isEmpty else {
            return buildMenuElement() as! UIMenu
        }
        
        let childElements = self.elements
            .map { $0.buildMenuElement() }
            .appending(contentsOf: additionalElements)

        return UIMenu(
            title: self.title ?? "",
            image: self.image,
            identifier: (self.identifier != nil) ? UIMenu.Identifier(self.identifier!) : nil,
            options: self.options,
            children: childElements
        )
        
    }
    
    /// Builds a context menu configuration.
    public func buildConfiguration() -> UIContextMenuConfiguration {
        
        var previewProvider: UIContextMenuContentPreviewProvider?
        var actionProvider: UIContextMenuActionProvider?
        
        if let preview = self.previewProvider {
            
            previewProvider = {
                return preview(self.data)
            }
            
        }
        
        if !self.elements.isEmpty {
            
            // Only assign an action provider if we have elements.
            // If we don't have elements, we only want to show
            // a preview (if provided).
            
            actionProvider = { suggestedElements in
                
                var additionalElements = [UIMenuElement]()

                if self.includeSuggestedElements {
                    additionalElements.append(contentsOf: suggestedElements)
                }
                
                return self.buildMenu(additionalElements: additionalElements)
                
            }
            
        }
      
        return UIContextMenuConfiguration(
            identifier: nil,
            previewProvider: previewProvider,
            actionProvider: actionProvider
        )
        
    }
    
}

// MARK: UIContextMenuInteractionDelegate

extension UIContextMenu: UIContextMenuInteractionDelegate {
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        
        return buildConfiguration()
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       willDisplayMenuFor configuration: UIContextMenuConfiguration,
                                       animator: UIContextMenuInteractionAnimating?) {
        
        willPresent?()
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       willEndFor configuration: UIContextMenuConfiguration,
                                       animator: UIContextMenuInteractionAnimating?) {
        
        willDismiss?()
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       previewForHighlightingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        return targetedHighlightPreviewProvider?(self.data)
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       previewForDismissingMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        return targetedDismissPreviewProvider?(self.data)
        
    }
    
    public func contextMenuInteraction(_ interaction: UIContextMenuInteraction,
                                       willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                                       animator: UIContextMenuInteractionCommitAnimating) {

        // If this protocol function is implemented,
        // the system always performs some kind of animation.
        // This isn't ideal, but doesn't hurt anything.
        //
        // Need to find a way to conditionally adopt this function
        // Only when needed.
        //
        // responds(toSelector:) fuckery?
        
        guard let committer = self.previewCommitter else { return }
        
        animator.preferredCommitStyle = self.previewCommitStyle

        animator.addCompletion {
                        
            committer(
                self.data,
                animator.previewViewController
            )
            
        }
        
    }
    
}
