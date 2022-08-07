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
    
    private var contextMenu: ContextMenu!
    
    private let colors: [String: UIColor] = [
        "Red": .red,
        "Green": .green,
        "Blue": .blue
    ]
    
    private var isLoved: Bool = false
    
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
        setupContextMenu()
        
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

    private func setupContextMenu() {
        
        self.contextMenu = ContextMenu { [weak self] menu in
            
            guard let self = self else { return }
            
            menu.addAction { action in
                
                action.title = self.isLoved ? "You love me!" : "Do you love me?"
                action.image = self.isLoved ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")

                action.handler = { _ in

                    self.isLoved.toggle()
                    self.setupContextMenu()

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

            menu.addMenu { moreMenu in
                
                moreMenu.title = "Actually, tap me!"
                moreMenu.image = UIImage(systemName: "star")
                
                moreMenu.addMenu { moreMoreMenu in

                    moreMoreMenu.title = "Just one more tap..."
                    moreMoreMenu.image = UIImage(systemName: "star.fill")
                    
                    moreMoreMenu.addAction { action in

                        action.title = "Tap me, I swear!"
                        action.image = UIImage(systemName: "sparkles")
                        
                        action.handler = { _ in
                            self.alert("Wow! I'm surprised you actually did all that. You're really good at following orders!")
                        }

                    }

                }

            }
            
            menu.previewProvider = { data -> UIViewController? in
                
                guard let cell = data["cell"] as? ContextCollectionCell else { return nil }
                
                let viewController = DetailViewController()
                viewController.title = cell.title
                viewController.view.backgroundColor = cell.color
                viewController.preferredContentSize = .init(width: 300, height: 300)
                return viewController
                
            }
            
            menu.previewCommitter = { data, _ in
                
                guard let cell = data["cell"] as? ContextCollectionCell else { return }
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
        
        return self.contextMenu
            .collectionConfiguration
            .collectionView(
                collectionView,
                contextMenuConfigurationForItemAt: indexPath,
                point: point
            )
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willDisplayContextMenu configuration: UIContextMenuConfiguration,
                        animator: UIContextMenuInteractionAnimating?) {
        
        self.contextMenu
            .collectionConfiguration
            .collectionView(
                collectionView,
                willDisplayContextMenu: configuration,
                animator: animator
            )
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        willEndContextMenuInteraction configuration: UIContextMenuConfiguration,
                        animator: UIContextMenuInteractionAnimating?) {
        
        self.contextMenu
            .collectionConfiguration
            .collectionView(
                collectionView,
                willEndContextMenuInteraction: configuration,
                animator: animator
            )
        
    }

    func collectionView(_ collectionView: UICollectionView,
                        previewForHighlightingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        return self.contextMenu
            .collectionConfiguration
            .collectionView(
                collectionView,
                previewForHighlightingContextMenuWithConfiguration: configuration
            )
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        previewForDismissingContextMenuWithConfiguration configuration: UIContextMenuConfiguration) -> UITargetedPreview? {
        
        return self.contextMenu
            .collectionConfiguration
            .collectionView(
                collectionView,
                previewForDismissingContextMenuWithConfiguration: configuration
            )
        
    }

    func collectionView(_ collectionView: UICollectionView,
                        willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration,
                        animator: UIContextMenuInteractionCommitAnimating) {
        
        self.contextMenu
            .collectionConfiguration
            .collectionView(
                collectionView,
                willPerformPreviewActionForMenuWith: configuration,
                animator: animator
            )
        
    }
    
}
