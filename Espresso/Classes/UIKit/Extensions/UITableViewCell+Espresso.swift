//
//  UITableViewCell+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/24/18.
//

import UIKit

public extension UITableViewCell /* Register */ {
        
    /// Registers a cell's nib in a table view with a specified name.
    /// If no name is provided, the cell's class name will be used.
    ///
    /// - Parameter tableView: The table view to register the cell in.
    /// - Parameter nibName: The cell's nib name.
    /// - Parameter bundle: The bundle to load the nib from; _defaults to Bundle.main_.
    static func registerNib(in tableView: UITableView,
                            nibName: String? = nil,
                            bundle: Bundle = Bundle.main) {
        
        let name = nibName ?? self.staticIdentifier
        
        tableView.register(
            UINib(
                nibName: name,
                bundle: bundle
            ),
            forCellReuseIdentifier: self.staticIdentifier
        )
        
    }
    
    
    /// Registers a cell in a specified table view.
    ///
    /// - Parameter tableView: The table view to register the cell in.
    static func register(in tableView: UITableView) {
        
        tableView.register(
            self,
            forCellReuseIdentifier: self.staticIdentifier
        )
        
    }
    
    /// Dequeue's a cell for a specified table view & index path.
    ///
    /// - Parameter tableView: The table view.
    /// - Parameter indexPath: The index path.
    /// - Returns: A typed cell.
    static func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> Self {
        
        return _cell(
            dequeuedFor: tableView,
            at: indexPath
        )
        
    }
    
    /// Dequeue's _or_ creates a cell for a specified table view & nib name.
    /// If no name is provided, the cell's class name will be used.
    ///
    /// - Parameter tableView: The table view.
    /// - Parameter nibName: The cell's nib name.
    /// - Parameter bundle: The bundle to load the nib from; _defaults to Bundle.main_.
    /// - Returns: A typed cell.
    static func cell(for tableView: UITableView,
                     nibName: String? = nil,
                     bundle: Bundle = Bundle.main) -> Self {
        
        return _cell(
            for: tableView,
            nibName: nibName,
            bundle: bundle
        )
        
    }
    
    private class func _cell<T: UITableViewCell>(for tableView: UITableView,
                                                 nibName: String? = nil,
                                                 bundle: Bundle = Bundle.main) -> T {
        
        let name = nibName ?? T.staticIdentifier
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: T.staticIdentifier) as? T {
            return cell
        }
        else {
            
            return bundle.loadNibNamed(
                name,
                owner: nil,
                options: nil
            )?.first as! T
            
        }
        
    }
    
    private class func _cell<T: UITableViewCell>(dequeuedFor tableView: UITableView, at indexPath: IndexPath) -> T {
        
        return tableView.dequeueReusableCell(
            withIdentifier: T.staticIdentifier,
            for: indexPath
        ) as! T
        
    }
    
}
