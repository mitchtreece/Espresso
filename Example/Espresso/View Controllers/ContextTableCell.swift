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
    func contextTableCellDidTapContextMenuPreview(_ cell: ContextTableCell)
}

@available(iOS 13, *)
class ContextTableCell: UITableViewCell {
    
    weak var delegate: ContextTableCellDelegate?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contextMenu = UIContextMenu(
            title: "Hello, iOS 13!",
            image: nil,
            identifier: nil,
            previewProvider: {
                
                let vc = UIViewController()
                vc.view.backgroundColor = .green
                return vc
                
            },
            previewPopHandler: { [weak self] in
                
                guard let _self = self else { return }
                _self.delegate?.contextTableCellDidTapContextMenuPreview(_self)
                
            },
            items: [
                .action(title: "Foo", image: UIImage(systemName: "01.circle"), handler: { _ in print("foo") }),
                .action(title: "Bar", image: UIImage(systemName: "02.circle"), handler: { _ in print("bar") }),
                .menu(title: "More...", children: [
                    .action(title: "DJ Khaled says...", image: UIImage(systemName: "star.filled"), handler: { _ in print("Another one!") }) 
                ])
            ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
