//
//  ContextMenuBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import Foundation

public protocol ContextMenuBuildable: UIMenuElementContainer {
    
    var title: String? { get set }
    var identifier: String? { get set }
    var options: UIMenu.Options { get set }
    var elementSize: UIMenuElementSize { get set }
    var previewProvider: ContextMenu.PreviewProvider? { get set }
    var previewCommitter: ContextMenu.PreviewCommitter? { get set }
    var previewCommitStyle: UIContextMenuInteractionCommitStyle { get set }
    var targetedHighlightPreviewProvider: ContextMenu.TargetedPreviewProvider? { get set }
    var targetedDismissPreviewProvider: ContextMenu.TargetedPreviewProvider? { get set }
    var includeSuggestedElements: Bool { get set }
    var willPresent: (()->())? { get set }
    var willDismiss: (()->())? { get set }
    
}

internal struct ContextMenuBuilder: Builder, ContextMenuBuildable {
    
    public typealias BuildType = ContextMenu
    
    public var title: String?
    public var identifier: String?
    public var options: UIMenu.Options = []
    public var elementSize: UIMenuElementSize = .large
    public var elements: [UIMenuElement] = []
    
    public var previewProvider: ContextMenu.PreviewProvider?
    public var previewCommitter: ContextMenu.PreviewCommitter?
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop
    public var targetedHighlightPreviewProvider: ContextMenu.TargetedPreviewProvider?
    public var targetedDismissPreviewProvider: ContextMenu.TargetedPreviewProvider?
    public var includeSuggestedElements: Bool = false
    public var willPresent: (()->())?
    public var willDismiss: (()->())?

    public func build() -> ContextMenu {
        return ContextMenu(buildable: self)
    }
    
}
