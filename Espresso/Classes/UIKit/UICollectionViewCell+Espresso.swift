//
//  UICollectionViewCell+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/24/18.
//

import UIKit

// MARK: Register

public extension UICollectionViewCell {
    
    // NOTE: `UICollectionViewCell` conforms to `Identifiable`
    
    static func registerNib(in collectionView: UICollectionView, nibName: String? = nil) {
        
        let name = nibName ?? self.identifier
        let nib = UINib(nibName: name, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: self.identifier)
        
    }
    
    static func register(in collectionView: UICollectionView) {
        collectionView.register(self, forCellWithReuseIdentifier: self.identifier)
    }
    
    static func dequeue(for collectionView: UICollectionView, at indexPath: IndexPath) -> Self {
        return _cell(dequeuedFor: collectionView, at: indexPath)
    }
    
    private class func _cell<T: UICollectionViewCell>(dequeuedFor collectionView: UICollectionView, at indexPath: IndexPath) -> T {
        return collectionView.dequeueReusableCell(withReuseIdentifier: T.identifier, for: indexPath) as! T
    }
    
}
