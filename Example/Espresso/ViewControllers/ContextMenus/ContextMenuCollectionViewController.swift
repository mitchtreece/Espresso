//
//  ContextMenuCollectionViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/2/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Espresso

protocol ContextMenuCollectionViewControllerDelegate: AnyObject {
    
    func contextMenuCollectionViewController(_ vc: ContextMenuCollectionViewController,
                                             didSelectColor color: UIColor,
                                             withTitle title: String)
    
}

class ContextMenuCollectionViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    private var cellContextMenu: UIContextMenu!
    
    private let colors: [String: UIColor] = [
        "Red": .red,
        "Green": .green,
        "Blue": .blue
    ]
    
    private weak var delegate: ContextMenuCollectionViewControllerDelegate?
    
    init(delegate: ContextMenuCollectionViewControllerDelegate) {
        
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
        
        setupCollection()
        setupContextMenus()
        
    }
    
    private func didTapCell(_ cell: ContextCollectionCell) {

        self.delegate?.contextMenuCollectionViewController(
            self,
            didSelectColor: cell.color,
            withTitle: cell.title
        )
        
    }
    
    private func setupCollection() {
        
        let screen = UIScreen.main.bounds
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(
            width: floor(screen.width / 3),
            height: floor(screen.width / 3)
        )
        
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.view.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        ContextCollectionCell
            .register(in: self.collectionView)
        
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
                
                guard let cell = data["cell"] as? ContextCollectionCell else { return nil }
                
                let viewController = DetailViewController()
                viewController.title = cell.title
                viewController.view.backgroundColor = cell.color
                return viewController
                
            }
            
            menu.previewCommitter = { data, viewController in
                
                guard let cell = data["cell"] as? ContextCollectionCell else { return }
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

extension ContextMenuCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        
        return 100
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let color = self.colors.randomElement()!
        
        return ContextCollectionCell
            .dequeue(for: collectionView, at: indexPath)
            .setup(
                title: color.key,
                color: color.value
            )
                
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ContextCollectionCell else { return }
        didTapCell(cell)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        contextMenuConfigurationForItemAt indexPath: IndexPath,
                        point: CGPoint) -> UIContextMenuConfiguration? {
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? ContextCollectionCell else { return nil }

        return self.cellContextMenu
            .setData(cell, forKey: "cell")
            .buildConfiguration()
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplayContextMenu configuration: UIContextMenuConfiguration,
                        animator: UIContextMenuInteractionAnimating?) {
        
        self.cellContextMenu?
            .willPresent?()
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
                        animator: UIContextMenuInteractionAnimating?) {
        
        self.cellContextMenu
            .willDismiss?()
        
    }

    func collectionView(_ collectionView: UICollectionView,
                        previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        return self.cellContextMenu
            .targetedHighlightPreviewProvider?(self.cellContextMenu.data)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        self.cellContextMenu
            .targetedDismissPreviewProvider?(self.cellContextMenu.data)
        
    }

    func collectionView(_ collectionView: UICollectionView,
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
