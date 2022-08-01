//
//  ContextCollectionCell.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/2/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class ContextCollectionCell: UICollectionViewCell {
    
    private(set) var title: String = ""
    
    private(set) var color: UIColor = .red {
        didSet {
            self.contentView.backgroundColor = color
        }
    }

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupSubviews()
        
    }
    
    private func setupSubviews() {
        
        self.contentView.layer.borderColor = UIColor.white.cgColor
        self.contentView.layer.borderWidth = 4
        
    }
    
    @discardableResult
    func setup(title: String,
               color: UIColor) -> Self {
        
        self.title = title
        self.color = color
        
        return self
        
    }
    
}
