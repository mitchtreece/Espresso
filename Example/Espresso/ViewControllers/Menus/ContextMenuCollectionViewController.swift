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
                                             didSelectColor color: ESColor)
    
}

class ContextMenuCollectionViewController: UIViewController {
    
    private var collectionView: UICollectionView!
    
    weak var delegate: ContextMenuCollectionViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
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
        
        UICollectionViewCell.register(in: self.collectionView)
//        ContextCollectionCell.register(in: self.collectionView)
        
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
        
//        let cell = ContextCollectionCell.dequeue(for: collectionView, at: indexPath)
//        cell.setup(color: ESColor.allCases.randomElement() ?? .red, delegate: self)
//        return cell
        
        return UICollectionViewCell.dequeue(for: collectionView, at: indexPath)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
//
//        guard let cell = collectionView.cellForItem(at: indexPath) as? ContextCollectionCell else { return }
//
//        self.delegate?.contextMenuCollectionViewController(
//            self,
//            didSelectColor: cell.color
//        )
        
    }
    
}

//extension ContextMenuCollectionViewController: ContextCollectionCellDelegate {
//    
//    func contextCollectionCellPreview(_ cell: ContextCollectionCell,
//                                      for color: ESColor) -> UIViewController? {
//        
//        let vc = DetailViewController()
//        vc.title = color.name
//        vc.view.backgroundColor = color.color
//        return vc
//        
//    }
//    
//    func contextCollectionCellDidTapPreview(_ cell: ContextCollectionCell,
//                                            preview: UIViewController?) {
//        
//        self.delegate?.contextMenuCollectionViewController(
//            self,
//            didSelectColor: cell.color
//        )
//        
//    }
//    
//}
