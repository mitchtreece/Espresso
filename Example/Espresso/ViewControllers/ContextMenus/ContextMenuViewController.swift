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
        
        setupContextMenus()
        
        self.contextMenuView = ContextMenuView()
        self.view.addSubview(self.contextMenuView)
        self.contextMenuView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        self.contextMenuView
            .addContextMenu(self.contextMenu)
        
        if #available(iOS 14, *) {
            
            // Button
            
            let button = UIButton()
            button.backgroundColor = .systemBlue
            button.setTitle("Tap me", for: .normal)
            button.showsMenuAsPrimaryAction = true
            button.roundCorners(radius: 12)
            self.view.addSubview(button)
            button.snp.makeConstraints { make in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.bottom.equalTo(-30)
                make.height.equalTo(50)
            }
            
            button
                .addContextMenu(self.contextMenu)
            
            
            // Bar Button
            
            let barButtonItem = UIBarButtonItem(systemItem: .action)
            self.navigationItem.rightBarButtonItem = barButtonItem
            
            barButtonItem
                .addContextMenu(self.contextMenu)

        }
        
    }
    
    private func setupContextMenus() {

        self.contextMenu = UIContextMenu { menu in
                        
            menu.title = "Make a choice"
            
            menu.addAction { action in
                
                action.title = "Tap me!"
                action.image = UIImage(systemName: "hand.tap")
                
                action.action = { _ in
                    self.alert("Wow! You're pretty good at following orders")
                }

            }

            menu.addAction { action in

                action.title = "No, tap me!"
                action.image = UIImage(systemName: "hand.tap.fill")
                
                action.action = { _ in
                    self.alert("You're not that good at following orders, are you?")
                }

            }

            menu.addMenu { moreMenu in
                
                moreMenu.title = "Actually, tap me!"
                moreMenu.image = UIImage(systemName: "star")
                
                moreMenu.addMenu { moreMoreMenu in

                    moreMoreMenu.title = "Just one more tap..."
                    moreMoreMenu.image = UIImage(systemName: "star.fill")
                    
                    moreMoreMenu.addAction { action in

                        action.title = "Tap me, I swear!"
                        action.image = UIImage(systemName: "sparkles")
                        
                        action.action = { _ in
                            self.alert("Wow! I'm surprised you actually did all that. You're really good at following orders!")
                        }

                    }

                }

            }

            menu.willPresent = {
                print("Context menu is being presented")
            }

            menu.willDismiss = {
                print("Context menu is being dismissed")
            }
            
        }
        
    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
