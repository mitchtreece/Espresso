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
        
        let contextView = ContextView(color: .systemGroupedBackground)
        self.view.addSubview(contextView)
        contextView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        contextView.addContextMenu(UIContextMenu { menu in
            
            menu.title = "Hello, context menu!"
            
            menu.addAction { action in
                
                action.title = "Foo"
                action.image = UIImage(systemName: "01.circle")
                action.action = { _ in
                    self.alert("Foo")
                }
                
            }
            
            menu.addAction { action in
                
                action.title = "Bar"
                action.image = UIImage(systemName: "02.circle")
                action.action = { _ in
                    self.alert("Bar")
                }
                
            }
            
            menu.addMenu { moreMenu in
                
                moreMenu.title = "More..."
                
                moreMenu.addMenu { moreMoreMenu in
                    
                    moreMoreMenu.title = "DJ Khaled says..."
                    moreMoreMenu.image = UIImage(systemName: "star.filled")
                    moreMoreMenu.addAction { action in
                        
                        action.title = "Another one?"
                        action.image = UIImage(systemName: "star.filled")
                        action.action = { _ in
                            self.alert("Another one!")
                        }
                        
                    }
                    
                }
                                
            }
            
        })

    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
