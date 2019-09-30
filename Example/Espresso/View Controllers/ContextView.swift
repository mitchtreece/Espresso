//
//  CustomView.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 9/28/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

@available(iOS 13, *)
class ContextView: UIView {
    
    private var label: UILabel!
    
    init(color: UIColor) {
        
        super.init(frame: .zero)
        self.backgroundColor = color
        
        self.label = UILabel()
        self.label.textColor = .darkGray
        self.label.numberOfLines = 0
        self.label.textAlignment = .center
        self.label.font = .systemFont(ofSize: 13)
        self.label.text = "Tap & hold for more context!"
        self.addSubview(self.label)
        self.label.snp.makeConstraints { make in
            make.edges.equalTo(0).inset(8)
        }
        
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
