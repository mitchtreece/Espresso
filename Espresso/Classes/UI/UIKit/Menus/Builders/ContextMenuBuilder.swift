//
//  ContextMenuBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import UIKit

public protocol ContextMenuBuildable: MenuElementContainer {
    
    var title: String? { get set }
    var identifier: MenuElementIdentifier? { get set }
    var configurationIdentifier: NSCopying? { get set }
    var options: UIMenu.Options { get set }
    var previewProvider: ContextMenu.PreviewProvider? { get set }
    var previewCommitter: ContextMenu.PreviewCommitter? { get set }
    var previewCommitStyle: UIContextMenuInteractionCommitStyle { get set }
    var targetedHighlightPreviewProvider: ContextMenu.TargetedPreviewProvider? { get set }
    var targetedDismissPreviewProvider: ContextMenu.TargetedPreviewProvider? { get set }
    var includeSuggestedElements: Bool { get set }
    var willPresent: (()->())? { get set }
    var willDismiss: (()->())? { get set }

    @available(iOS 16, *)
    var elementSize: UIMenu.ElementSize { get set }
        
}

internal struct ContextMenuBuilder: ContextMenuBuildable {
        
    var title: String?
    var identifier: MenuElementIdentifier?
    var configurationIdentifier: NSCopying?
    var options: UIMenu.Options = []
    var children: [UIMenuElement] = []
    var previewProvider: ContextMenu.PreviewProvider?
    var previewCommitter: ContextMenu.PreviewCommitter?
    var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop
    var targetedHighlightPreviewProvider: ContextMenu.TargetedPreviewProvider?
    var targetedDismissPreviewProvider: ContextMenu.TargetedPreviewProvider?
    var includeSuggestedElements: Bool = false
    var willPresent: (()->())?
    var willDismiss: (()->())?
    
    @available(iOS 16, *)
    var elementSize: UIMenu.ElementSize {
        get {
            return (self._elementSize as? UIMenu.ElementSize) ?? .large
        }
        set {
            self._elementSize = newValue
        }
    }
    
    private var _elementSize: Any?
    
    init() {
        //
    }
    
    init(buildable: ContextMenuBuildable) {
        
        self.title = buildable.title
        self.identifier = buildable.identifier
        self.configurationIdentifier = buildable.configurationIdentifier
        self.options = buildable.options
        self.children = buildable.children
        self.previewProvider = buildable.previewProvider
        self.previewCommitter = buildable.previewCommitter
        self.previewCommitStyle = buildable.previewCommitStyle
        self.targetedHighlightPreviewProvider = buildable.targetedHighlightPreviewProvider
        self.targetedDismissPreviewProvider = buildable.targetedDismissPreviewProvider
        self.includeSuggestedElements = buildable.includeSuggestedElements
        self.willPresent = buildable.willPresent
        self.willDismiss = buildable.willDismiss
        
        if #available(iOS 16, *) {
            self.elementSize = buildable.elementSize
        }
        
    }

}
