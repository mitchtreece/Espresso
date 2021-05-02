//
//  UITableView+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 10/28/18.
//

import UIKit

public extension UITableView /* Cell Registration */ {
        
    /// Registers an array of cells in the table view.
    /// - Parameter cells: The cell classes to register in the table view.
    func register(cells: [UITableViewCell.Type]) {
        cells.forEach({ $0.register(in: self) })
    }
    
    /// Registers an array of nib-backed cells in the table view.
    /// - Parameter cellNibs: The cell classes to register in the table view.
    ///
    /// This calls `registerNib(in:)` on the cell classes assuming a nib of the **exact** same name exists.
    /// If a nib exists with a _different_ name, you can manually register it by calling `registerNib(in:)` on the cell class.
    /// - SeeAlso: `UITableViewCell.register(in:)`, `UITableViewCell.registerNib(in:)`
    /// - Requires: The nib filenames must **exactly** match their respective cell classes.
    func register(cellNibs: [UITableViewCell.Type]) {
        cellNibs.forEach({ $0.registerNib(in: self) })
    }
    
}
