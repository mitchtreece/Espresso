//
//  UICollectionView+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 10/28/18.
//

import UIKit

public extension UICollectionView {
        
    /// Registers an array of cells in the collection view.
    /// - parameter cells: The cell classes to register in the table view.
    func register(cells: [UICollectionViewCell.Type]) {
        cells.forEach { $0.register(in: self) }
    }
    
    /// Registers an array of nib-backed cells in the collection view.
    /// - parameter cellNibs: The cell classes to register in the collection view.
    ///
    /// This calls `registerNib(in:)` on the cell classes assuming a nib of the **exact** same name exists.
    /// If a nib exists with a _different_ name, you can manually register it by calling `registerNib(in:)` on the cell class.
    /// - seealso: `UICollectionViewCell.register(in:)`, `UICollectionViewCell.registerNib(in:)`
    /// - requires: The nib filenames must **exactly** match their respective cell classes.
    func register(cellNibs: [UICollectionViewCell.Type]) {
        cellNibs.forEach { $0.registerNib(in: self) }
    }
    
}
