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

    private var cellContextMenu: UIContextMenu!
    
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
        
        self.cellContextMenu = UIContextMenu { menu in
            
            menu.title = "Hello, world!"
            
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
            
            menu.previewProvider = { data -> UIViewController? in
                
                guard let cell = data["cell"] as? ContextTableCell else { return nil }
                
                let viewController = DetailViewController()
                viewController.title = cell.title
                viewController.view.backgroundColor = cell.color
                return viewController
                
            }
            
            menu.previewCommitter = { data, viewController in
                
                guard let cell = data["cell"] as? ContextTableCell else { return }
                self.didTapCell(cell)
                
            }
            
            menu.willPresent = {
                print("menu present")
            }
            
            menu.willDismiss = {
                print("menu dismiss")
            }
            
        }
        
    }
    
    private func alert(_ message: String) {
        (UIApplication.shared.delegate as! AppDelegate).alert(message)
    }
    
}

extension ContextMenuTableViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        
        guard let cell = tableView
            .cellForRow(at: indexPath) as? ContextTableCell else { return nil }
                
        return self.cellContextMenu
            .addData(
                cell,
                forKey: "cell"
            )
            .buildConfiguration()
        
    }
    
    func tableView(_ tableView: UITableView,
                   willDisplayContextMenu configuration: UIContextMenuConfiguration,
                   animator: UIContextMenuInteractionAnimating?) {
        
        self.cellContextMenu.willPresent?()
        
    }
    
    func tableView(_ tableView: UITableView,
                   willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
                   animator: UIContextMenuInteractionAnimating?) {
        
        self.cellContextMenu.willDismiss?()
        
    }
    
    func tableView(_ tableView: UITableView,
                   previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        return self.cellContextMenu
            .targetedHighlightPreviewProvider?(self.cellContextMenu.data)
        
    }
    
    func tableView(_ tableView: UITableView,
                   previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        self.cellContextMenu
            .targetedDismissPreviewProvider?(self.cellContextMenu.data)
        
    }
    
    func tableView(_ tableView: UITableView,
                   willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                   animator: UIContextMenuInteractionCommitAnimating) {
        
        guard let committer = self.cellContextMenu.previewCommitter else { return }
        
        animator.preferredCommitStyle = self.cellContextMenu.previewCommitStyle

        animator.addCompletion {
                        
            committer(
                self.cellContextMenu.data,
                animator.previewViewController
            )
            
        }
        
    }
    
}
