//
//  ContextCollectionCell.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/2/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

@available(iOS 13, *)
protocol ContextCollectionCellDelegate: class {
    func contextCollectionCellPreview(_ cell: ContextCollectionCell, for color: Color) -> UIViewController?
    func contextCollectionCellDidTapPreview(_ cell: ContextCollectionCell, preview: UIViewController?)
}

@available(iOS 13, *)
class ContextCollectionCell: UICollectionViewCell {
    
    private(set) var color: Color!
    weak var delegate: ContextCollectionCellDelegate?

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.contextMenu = UIContextMenu(
            title: "Hello, world!",
            previewProvider: nil,
            commitHandler: { [weak self] preview in
                
                guard let _self = self else { return }
                
                _self.delegate?.contextCollectionCellDidTapPreview(
                    _self,
                    preview: preview
                )
                
            },
            items: [
                .action(title: "Foo", image: UIImage(systemName: "01.circle"), handler: { _ in self.alert("Foo") }),
                .action(title: "Bar", image: UIImage(systemName: "02.circle"), handler: { _ in self.alert("Bar") }),
                .menu(title: "More...", children: [
                    .action(title: "DJ Khaled says...", image: UIImage(systemName: "star.filled"), handler: { _ in self.alert("Another one!") })
                ])
            ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(color: Color, delegate: ContextCollectionCellDelegate) {
        
        self.delegate = delegate
        self.color = color
        self.contentView.backgroundColor = color.color
        
    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
