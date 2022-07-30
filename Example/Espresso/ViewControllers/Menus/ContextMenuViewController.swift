//
//  ContextMenuViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Espresso

class ContextMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let x = UIButton()
        x.backgroundColor = .red
        self.view.addSubview(x)
        x.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.top.equalTo(200)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
        
        let contextView = ContextView(color: .systemGroupedBackground)
        self.view.addSubview(contextView)
        contextView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
                
        x.addContextMenu(UIContextMenu(
            title: "Hello, context menu!",
            items: [
            
                .action(title: "Foo", image: UIImage(systemName: "01.circle"), action: { _ in
                    self.alert("Foo")
                }),
                
                .action(title: "Bar", image: UIImage(systemName: "02.circle"), action: { _ in
                    self.alert("Bar")
                }),
                
                .group(title: "More...", children: [
                
                    .action(title: "DJ Khaled says...", image: UIImage(systemName: "star.filled"), action: { _ in
                        self.alert("Another one!")
                    })
                
                ])
                
            ]))

    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
