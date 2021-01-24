//
//  ContextMenuViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Espresso

@available(iOS 13, *)
class ContextMenuViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let contextView = ContextView(color: .groupTableViewBackground)
        self.view.addSubview(contextView)
        contextView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        contextView.contextMenu = UIContextMenu(
            title: "Hello, context menu!",
            items: [
                .action(title: "Foo", image: UIImage(systemName: "01.circle"), handler: { _ in self.alert("Foo") }),
                .action(title: "Bar", image: UIImage(systemName: "02.circle"), handler: { _ in self.alert("Bar") }),
                .menu(title: "More...", children: [
                    .action(title: "DJ Khaled says...", image: UIImage(systemName: "star.filled"), handler: { _ in self.alert("Another one!") })
                ])
            ])
        
    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
