//
//  ContextTableCell.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 9/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class ContextTableCell: UITableViewCell {
    
    private(set) var title: String = "" {
        didSet {
            self.textLabel?.text = title
        }
    }
    
    private(set) var color: UIColor = .red
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        
        super.init(
            style: style,
            reuseIdentifier: reuseIdentifier
        )
        
        self.accessoryType = .disclosureIndicator
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @discardableResult
    func setup(title: String,
               color: UIColor) -> Self {
        
        self.title = title
        self.color = color
        
        return self
        
    }
    
}
