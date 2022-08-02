//
//  ContextMenuTableViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Espresso

protocol ContextMenuTableViewControllerDelegate: AnyObject {
    
    func contextMenuTableViewController(_ vc: ContextMenuTableViewController,
                                        didSelectColor color: UIColor,
                                        withTitle title: String)
    
}

class ContextMenuTableViewController: UIViewController {
    
    private var tableView: UITableView!

    private var contextMenu: UIContextMenu!
    
    private let colors: [String: UIColor] = [
        "Red": .red,
        "Green": .green,
        "Blue": .blue
    ]
        
    private weak var delegate: ContextMenuTableViewControllerDelegate?
    
    init(delegate: ContextMenuTableViewControllerDelegate) {
        
        self.delegate = delegate
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        setupTable()
        setupContextMenus()
        
    }
    
    private func didTapCell(_ cell: ContextTableCell) {
        
        self.delegate?.contextMenuTableViewController(
            self,
            didSelectColor: cell.color,
            withTitle: cell.title
        )
        
    }
    
    private func setupTable() {
        
        self.tableView = UITableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        ContextTableCell
            .register(in: self.tableView)
        
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
            
            menu.previewCommitter = { data, _ in
                
                guard let cell = data["cell"] as? ContextTableCell else { return }
                self.didTapCell(cell)
                
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

extension ContextMenuTableViewController: UITableViewDelegate,
                                          UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        return 100
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let color = self.colors
            .randomElement()!
        
        return ContextTableCell
            .dequeue(for: tableView, at: indexPath)
            .setup(
                title: color.key,
                color: color.value
            )
        
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(
            at: indexPath,
            animated: true
        )

        guard let cell = tableView
            .cellForRow(at: indexPath) as? ContextTableCell else { return }

        self.didTapCell(cell)
        
    }
    
    func tableView(_ tableView: UITableView,
                   contextMenuConfigurationForRowAt indexPath: IndexPath,
                   point: CGPoint) -> UIContextMenuConfiguration? {

        return self.contextMenu
            .tableConfiguration
            .tableView(
                tableView,
                contextMenuConfigurationForRowAt: indexPath,
                point: point
            )

    }

    func tableView(_ tableView: UITableView,
                   willDisplayContextMenu configuration: UIContextMenuConfiguration,
                   animator: UIContextMenuInteractionAnimating?) {

        self.contextMenu
            .tableConfiguration
            .tableView(
                tableView,
                willDisplayContextMenu: configuration,
                animator: animator
            )
        
    }

    func tableView(_ tableView: UITableView,
                   willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
                   animator: UIContextMenuInteractionAnimating?) {

        self.contextMenu
            .tableConfiguration
            .tableView(
                tableView,
                willEndContextMenuInteraction: configuration,
                animator: animator
            )

    }

    func tableView(_ tableView: UITableView,
                   previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

        return self.contextMenu
            .tableConfiguration
            .tableView(
                tableView,
                previewForHighlightingContextMenuWithConfiguration: configuration
            )
        
    }

    func tableView(_ tableView: UITableView,
                   previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {

        return self.contextMenu
            .tableConfiguration
            .tableView(
                tableView,
                previewForDismissingContextMenuWithConfiguration: configuration
            )

    }

    func tableView(_ tableView: UITableView,
                   willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                   animator: UIContextMenuInteractionCommitAnimating) {

        self.contextMenu
            .tableConfiguration
            .tableView(
                tableView,
                willPerformPreviewActionForMenuWith: configuration,
                animator: animator
            )

    }
    
}
