//
//  UIContextMenuCollectionViewDelegateProxy.swift
//  Espresso
//
//  Created by Mitch Treece on 7/31/22.
//

//import UIKit
//
//public class UIContextMenuCollectionViewDelegateProxy: NSObject, UICollectionViewDelegate {
//    
//    internal weak var delegate: UICollectionViewDelegate?
//    internal weak var menuDelegate: UICollectionViewContextMenuDelegate?
//    
//    internal override init() {
//        super.init()
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView,
//                               contextMenuConfigurationForItemAt indexPath: IndexPath,
//                               point: CGPoint) -> UIContextMenuConfiguration? {
//        
//        let contextMenu = self.menuDelegate?.collectionView(
//            collectionView,
//            contextMenuForItemAt: indexPath,
//            point: point
//        )
//
//        let configuration = self.delegate?.collectionView?(
//            collectionView,
//            contextMenuConfigurationForItemAt: indexPath,
//            point: point
//        )
//
//        return contextMenu?.buildConfiguration() ?? configuration
//        
//    }
//    
//    public func collectionView(_ collectionView: UICollectionView,
//                               didSelectItemAt indexPath: IndexPath) {
//        
//        self.delegate?.collectionView?(
//            collectionView,
//            didSelectItemAt: indexPath
//        )
//        
//    }
//    
//}
