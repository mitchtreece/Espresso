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
class ContextTableCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contextMenu = UIContextMenu(
            title: "Hello, iOS 13!",
            image: nil,
            identifier: nil,
            actions: [
                UIAction(title: "Foo", image: UIImage(systemName: "01.circle"), handler: { _ in print("foo") }),
                UIAction(title: "Bar", image: UIImage(systemName: "02.circle"), handler: { _ in print("bar") })
            ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
