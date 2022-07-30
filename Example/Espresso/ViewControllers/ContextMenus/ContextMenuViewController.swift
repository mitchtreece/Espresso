//
//  ContextMenuViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Espresso

class ContextMenuViewController: UIViewController {
    
    private var contextMenuView: ContextMenuView!
    
    private var contextMenu: UIContextMenu!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        self.contextMenuView = ContextMenuView()
        self.view.addSubview(self.contextMenuView)
        self.contextMenuView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        setupContextMenus()
        
    }
    
    private func setupContextMenus() {
        
        self.contextMenu = UIContextMenu { menu in
            
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
            
            menu.willPresent = {
                print("menu present")
            }
            
            menu.willDismiss = {
                print("menu dismiss")
            }
            
        }
        
        self.contextMenuView
            .addContextMenu(self.contextMenu)
        
    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
