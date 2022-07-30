//
//  ContextMenuView.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 9/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class ContextMenuView: UIView {
    
    private var label: UILabel!
    
    init() {
        
        super.init(frame: .zero)
        
        self.backgroundColor = .systemGroupedBackground
        
        self.label = UILabel()
        self.label.textColor = .darkGray
        self.label.numberOfLines = 0
        self.label.textAlignment = .center
        self.label.font = .systemFont(ofSize: 13)
        self.label.text = "Press on me!"
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
