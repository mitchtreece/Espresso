//
//  UICollectionViewCell+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/24/18.
//

#if canImport(UIKit)

import UIKit
import Espresso

public extension UICollectionViewCell /* Register */ {
        
    /// Registers a cell's nib in a collection view with a specified name.
    ///
    /// If no name is provided, the cell's class name will be used.
    ///
    /// - parameter collectionView: The collection view to register the cell in.
    /// - parameter nibName: The cell's nib name.
    static func registerNib(in collectionView: UICollectionView,
                            nibName: String? = nil,
                            bundle: Bundle = Bundle.main) {
        
        let name = nibName ?? self.staticIdentifier
        
        collectionView.register(
            UINib(
                nibName: name,
                bundle: bundle
            ),
            forCellWithReuseIdentifier: self.staticIdentifier
        )
        
    }
    
    /// Registers a cell in a specified collection view.
    ///
    /// - parameter collectionView: The collection view to register the cell in.
    static func register(in collectionView: UICollectionView) {
        
        collectionView.register(
            self,
            forCellWithReuseIdentifier: self.staticIdentifier
        )
        
    }
    
    /// Dequeue's a cell for a specified collection view & index path.
    ///
    /// - parameter collectionView: The collection view.
    /// - parameter indexPath: The index path.
    /// - returns: A typed cell.
    static func dequeue(for collectionView: UICollectionView,
                        at indexPath: IndexPath) -> Self {
        
        return _cell(
            dequeuedFor: collectionView,
            at: indexPath
        )
        
    }
    
    private class func _cell<T: UICollectionViewCell>(dequeuedFor collectionView: UICollectionView,
                                                      at indexPath: IndexPath) -> T {
        
        return collectionView.dequeueReusableCell(
            withReuseIdentifier: T.staticIdentifier,
            for: indexPath
        ) as! T
        
    }
    
}

#endif
