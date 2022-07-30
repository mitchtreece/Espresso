//
//  ContextMenuRootBuilder.swift
//  Espresso
//
//  Created by Mitch Treece on 7/30/22.
//

import UIKit

public struct ContextMenuRootBuilder: ContextMenuBuildable {
        
    public var title: String?
    public var subtitle: String?
    public var image: UIImage?
    public var identifier: String?
    public var options: UIMenu.Options = []
    public var elements: [ContextMenuElement] = []
    
    public var preview: UIContextMenuContentPreviewProvider?
    public var previewCommit: ((UIViewController?)->())?
    public var previewCommitStyle: UIContextMenuInteractionCommitStyle = .pop
    public var includeSuggestedItems: Bool = false
    
    internal init() {
        //
    }
    
}
