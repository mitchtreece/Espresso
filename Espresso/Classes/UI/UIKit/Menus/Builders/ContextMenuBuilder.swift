//
//  ContextMenuBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 8/2/22.
//

import Foundation

public protocol ContextMenuBuildable: UIMenuElementContainer {
    
    var title: String? { get set }
    var identifier: UIMenuElementIdentifier? { get set }
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

internal struct ContextMenuBuilder: Builder, ContextMenuBuildable {
    
    public typealias BuildType = ContextMenu
    
    public var title: String?
    public var identifier: UIMenuElementIdentifier?
    public var options: UIMenu.Options = []
    public var children: [UIMenuElement] = []
    public var previewProvider: ContextMenu.PreviewProvider?
    public var previewCommitter: ContextMenu.PreviewCommitter?
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop
    public var targetedHighlightPreviewProvider: ContextMenu.TargetedPreviewProvider?
    public var targetedDismissPreviewProvider: ContextMenu.TargetedPreviewProvider?
    public var includeSuggestedElements: Bool = false
    public var willPresent: (()->())?
    public var willDismiss: (()->())?
    
    @available(iOS 16, *)
    public var elementSize: UIMenu.ElementSize {
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
    
    init(contextMenu: ContextMenu) {
        
        self.title = contextMenu.title
        self.identifier = contextMenu.identifier
        self.options = contextMenu.options
        self.children = contextMenu.children
        self.previewProvider = contextMenu.previewProvider
        self.previewCommitter = contextMenu.previewCommitter
        self.previewCommitStyle = contextMenu.previewCommitStyle
        self.targetedHighlightPreviewProvider = contextMenu.targetedHighlightPreviewProvider
        self.targetedDismissPreviewProvider = contextMenu.targetedDismissPreviewProvider
        self.includeSuggestedElements = contextMenu.includeSuggestedElements
        self.willPresent = contextMenu.willPresent
        self.willDismiss = contextMenu.willDismiss
        
        if #available(iOS 16, *) {
            self.elementSize = contextMenu.elementSize
        }
        
    }
    
    public func build() -> ContextMenu {
        return ContextMenu(buildable: self)
    }
    
}

public extension ContextMenu {
    
    convenience init(builder: (inout ContextMenuBuildable)->()) {
        
        var buildable: ContextMenuBuildable = ContextMenuBuilder()

        builder(&buildable)
                
        self.init(buildable: buildable)
        
    }
    
}

internal extension ContextMenu {
    
    convenience init(buildable: ContextMenuBuildable) {
        
        self.init(
            title: buildable.title,
            identifier: buildable.identifier,
            options: buildable.options,
            children: buildable.children,
            previewProvider: buildable.previewProvider,
            previewCommitter: buildable.previewCommitter,
            previewCommitStyle: buildable.previewCommitStyle,
            targetedHighlightPreviewProvider: buildable.targetedHighlightPreviewProvider,
            targetedDismissPreviewProvider: buildable.targetedDismissPreviewProvider,
            includeSuggestedElements: buildable.includeSuggestedElements,
            willPresent: buildable.willPresent,
            willDismiss: buildable.willDismiss
        )
        
        if #available(iOS 16, *) {
            self.elementSize = buildable.elementSize
        }
        
    }
    
}
