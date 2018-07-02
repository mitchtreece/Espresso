//
//  UITableViewCell+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/24/18.
//

import UIKit

public extension UITableViewCell /* Register */ {
    
    // NOTE: `UITableViewCell` conforms to `Identifiable`
    
    /**
     Registers a cell's nib in a table view with a specified name. If no name is provided, the cell's class name will be used.
     
     - Parameter tableView: The table view to register the cell in.
     - Parameter nibName: The cell's nib name.
     */
    static func registerNib(in tableView: UITableView, nibName: String? = nil) {
        
        let name = nibName ?? self.identifier
        let nib = UINib(nibName: name, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.identifier)
        
    }
    
    /**
     Registers a cell in a specified table view.
     
     - Parameter tableView: The table view to register the cell in.
     */
    static func register(in tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: self.identifier)
    }
    
    /**
     Dequeue's a cell for a specified table view & index path.
     
     - Parameter tableView: The table view.
     - Parameter indexPath: The index path.
     - Returns: A typed cell.
     */
    static func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> Self {
        return _cell(dequeuedFor: tableView, indexPath: indexPath)
    }
    
    /**
     Dequeue's _or_ creates a cell for a specified table view & nib name. If no name is provided, the cell's class name will be used.
     
     - Parameter tableView: The table view.
     - Parameter nibName: The cell's nib name.
     - Returns: A typed cell.
     */
    static func cell(for tableView: UITableView, nibName: String? = nil) -> Self {
        return _cell(for: tableView, nibName: nibName)
    }
    
    private class func _cell<T: UITableViewCell>(for tableView: UITableView, nibName: String? = nil) -> T {
        
        let name = nibName ?? T.identifier
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: T.identifier) as? T {
            return cell
        }
        else {
            return Bundle.main.loadNibNamed(name, owner: nil, options: nil)?.first as! T
        }
        
    }
    
    private class func _cell<T: UITableViewCell>(dequeuedFor tableView: UITableView, indexPath: IndexPath) -> T {
        return tableView.dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
    
}
