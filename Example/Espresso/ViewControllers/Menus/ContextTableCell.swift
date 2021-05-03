//
//  ContextTableCell.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 9/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

@available(iOS 13, *)
protocol ContextTableCellDelegate: class {
    func contextTableCellPreview(_ cell: ContextTableCell, for color: Color) -> UIViewController?
    func contextTableCellDidTapPreview(_ cell: ContextTableCell, preview: UIViewController?)
}

@available(iOS 13, *)
class ContextTableCell: UITableViewCell {
    
    private(set) var color: Color!
    weak var delegate: ContextTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        
        self.contextMenu = UIContextMenu(
            title: "Hello, context menu!",
            previewProvider: { [weak self] in
                
                guard let _self = self else { return nil }
                
                return _self.delegate?.contextTableCellPreview(
                    _self,
                    for: _self.color
                )
                
            },
            commitHandler: { [weak self] preview in
                
                guard let _self = self else { return }
                
                _self.delegate?.contextTableCellDidTapPreview(
                    _self,
                    preview: preview
                )
                
            },
            items: [
                .action(title: "Foo", image: UIImage(systemName: "01.circle"), handler: { _ in self.alert("Foo") }),
                .action(title: "Bar", image: UIImage(systemName: "02.circle"), handler: { _ in self.alert("Bar") }),
                .group(title: "More...", image: nil, children: [
                    .action(title: "DJ Khaled says...", image: UIImage(systemName: "star.filled"), handler: { _ in self.alert("Another one!") })
                ])
            ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(color: Color, delegate: ContextTableCellDelegate) {
        
        self.delegate = delegate
        self.color = color
        self.textLabel?.text = color.name
        
    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
