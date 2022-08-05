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
    
    private var viewMenu: ContextMenu!
    private var buttonMenu: ContextMenu!
    private var barItemMenu: ContextMenu!
    
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
            .addContextMenu(self.viewMenu)
        
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
                .addContextMenu(self.buttonMenu)
            
            
            // Bar Button
            
            let barButtonItem = UIBarButtonItem(systemItem: .action)
            self.navigationItem.rightBarButtonItem = barButtonItem
                        
            barButtonItem
                .addContextMenu(self.barItemMenu)

        }

    }
    
    private func setupContextMenus() {
        
        self.viewMenu = ContextMenu { menu in
            
            menu.title = "View Menu"
                                                
            menu.addAction { action in
                                
                action.title = "Tap me!"
                action.image = UIImage(systemName: "hand.tap")
                                
                action.handler = { _ in
                    self.alert("Wow! You're pretty good at following orders")
                }

            }
            
            menu.addAction { action in

                action.title = "No, tap me!"
                action.image = UIImage(systemName: "hand.tap.fill")
                
                action.handler = { _ in
                    self.alert("You're not that good at following orders, are you?")
                }

            }
            
            if #available(iOS 15, *) {
                
                menu.addUncachedDeferredElements { completion in
                    
                    let action = UIAction { action in
                        
                        action.title = "Thanks for waiting, tap me instead!"
                        action.handler = { _ in
                            self.alert("Wow! You're so patient, and pretty good at following orders!")
                        }
                        
                    }
                    
                    Task {
                        
                        try! await Task.sleep(duration: .seconds(2))
                        completion([action])

                    }
                    
                }
                
            }
            
            menu.addMenu { moreMenu in
                
                moreMenu.identifier = "menu_more"
                moreMenu.title = "Actually, tap me!"
                moreMenu.image = UIImage(systemName: "star")
                
                moreMenu.addMenu { moreMoreMenu in

                    moreMoreMenu.title = "Just one more tap..."
                    moreMoreMenu.image = UIImage(systemName: "star.fill")
                    
                    moreMoreMenu.addAction { action in

                        action.identifier = "action_i_swear"
                        action.title = "Tap me, I swear!"
                        action.image = UIImage(systemName: "sparkles")
                        
                        action.handler = { _ in
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
        
        self.buttonMenu = ContextMenu { menu in
                        
            menu.addAction { action in
                
                action.title = "Tap me!"
                action.image = UIImage(systemName: "hand.tap")
                action.handler = { _ in
                    self.alert("You tapped the button menu's action!")
                }
                
            }
            
        }
        
        self.barItemMenu = ContextMenu { menu in
                        
            menu.addAction { action in
                
                action.title = "Tap me!"
                action.image = UIImage(systemName: "hand.tap")
                action.handler = { _ in
                    self.alert("You tapped the bar item menu's action!")
                }
                
            }
            
        }
        
    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
