//
//  ContextMenuRootBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/30/22.
//

import UIKit

public struct ContextMenuRootBuilder: Builder, ContextMenuBuildable {
        
    public typealias BuildType = UIContextMenu
    
    public var title: String?
    public var subtitle: String?
    public var identifier: String?
    public var options: UIMenu.Options = []
    public var elements: [ContextMenuElement] = []
    
    public var previewProvider: UIContextMenu.PreviewProvider?
    public var previewCommitter: UIContextMenu.PreviewCommitter?
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop
    public var targetedHighlightPreviewProvider: UIContextMenu.TargetedPreviewProvider?
    public var targetedDismissPreviewProvider: UIContextMenu.TargetedPreviewProvider?
    
    public var includeSuggestedItems: Bool = false
    
    public var willPresent: (()->())?
    public var willDismiss: (()->())?
    
    internal init() {
        //
    }
    
    public func build() -> UIContextMenu {
        
        return UIContextMenu { menu in
            
            menu.title = self.title
            menu.subtitle = self.subtitle
            menu.identifier = self.identifier
            menu.options = self.options
            menu.elements = self.elements
            
            menu.previewProvider = self.previewProvider
            menu.previewCommitter = self.previewCommitter
            menu.previewCommitStyle = self.previewCommitStyle
            menu.targetedHighlightPreviewProvider = self.targetedHighlightPreviewProvider
            menu.targetedDismissPreviewProvider = self.targetedDismissPreviewProvider
            
            menu.includeSuggestedItems = self.includeSuggestedItems
            
            menu.willPresent = self.willPresent
            menu.willDismiss = self.willDismiss
            
        }
        
    }
    
}
