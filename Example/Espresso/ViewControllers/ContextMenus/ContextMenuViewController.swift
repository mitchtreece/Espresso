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
    private var buttonView: UIButton!
    private var barButtonItem: UIBarButtonItem!
    
    private var viewMenu: ContextMenu!
    private var buttonMenu: UIMenu?
    private var barItemMenu: UIMenu?
    
    private var isLoved: Bool = false
     
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        // Views
        
        self.contextMenuView = ContextMenuView()
        self.view.addSubview(self.contextMenuView)
        self.contextMenuView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.center.equalToSuperview()
        }
        
        self.buttonView = UIButton()
        self.buttonView.backgroundColor = .systemBlue
        self.buttonView.setTitle("Tap me", for: .normal)
        self.buttonView.roundCorners(radius: 12)
        self.view.addSubview(self.buttonView)
        self.buttonView.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.bottom.equalTo(-30)
            make.height.equalTo(50)
        }
        
        self.barButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: nil,
            action: nil
        )
        
        self.navigationItem.rightBarButtonItem = self.barButtonItem
        
        // Context Menus
        
        setupContextMenus()
        
    }
    
    private func toggleLoved() {
        
        self.isLoved.toggle()

        self.viewMenu = buildContextMenu(loved: self.isLoved)
            .add(to: self.contextMenuView)
        
    }
    
    private func setupContextMenus() {
        
        // View
        
        self.viewMenu = buildContextMenu(loved: self.isLoved)
            .add(to: self.contextMenuView)

        if #available(iOS 14, *) {
            
            // Button
            
            self.buttonMenu = UIMenu { menu in
                            
                menu.addAction { action in
                    
                    action.title = "This is a button action"
                    action.image = UIImage(systemName: "hand.tap")
                    
                    action.handler = { _ in
                        self.alert("You tapped the button action!")
                    }
                    
                }
                
            }
            
            self.buttonView.menu = self.buttonMenu
            self.buttonView.showsMenuAsPrimaryAction = true

            // Bar
            
            self.barItemMenu = UIMenu { menu in
                            
                menu.addAction { action in
                    
                    action.title = "This is bar item action"
                    action.image = UIImage(systemName: "hand.tap")
                    
                    action.handler = { _ in
                        self.alert("You tapped the bar item action!")
                    }
                    
                }
                
            }
            
            self.barButtonItem.menu = self.barItemMenu
            
        }
        
    }
    
    private func buildContextMenu(loved: Bool) -> ContextMenu {
        
        return ContextMenu { menu in
            
            menu.addAction { action in
                
                action.title = loved ? "You love me!" : "Do you love me?"
                action.image = loved ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
                
                action.handler = { [weak self] _ in
                    self?.toggleLoved()
                }
                
            }
            
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
                        
                        action.title = "Thanks for waiting"
                        action.image = UIImage(systemName: "clock")
                        
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
                
                moreMenu.title = "Actually, tap me!"
                moreMenu.image = UIImage(systemName: "star")
                
                moreMenu.addMenu { moreMoreMenu in

                    moreMoreMenu.title = "Just one more tap"
                    moreMoreMenu.image = UIImage(systemName: "star.fill")
                    
                    moreMoreMenu.addAction { action in
                        
                        action.title = "You did it!"
                        action.image = UIImage(systemName: "sparkles")
                        
                        action.handler = { _ in
                            self.alert("Wow! I'm surprised you actually did all that. You're really good at following orders!")
                        }

                    }

                }

            }

            menu.willPresent = {
                print("🟢 Context menu is being presented")
            }

            menu.willDismiss = {
                print("🔴 Context menu is being dismissed")
            }
            
        }
        
    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}
