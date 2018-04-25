//
//  UITableViewCell+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 4/24/18.
//

import UIKit

// MARK: Register

public extension UITableViewCell {
    
    // NOTE: `UITableViewCell` conforms to `Identifiable`
    
    static func registerNib(in tableView: UITableView, nibName: String? = nil) {
        
        let name = nibName ?? self.identifier
        let nib = UINib(nibName: name, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: self.identifier)
        
    }
    
    static func register(in tableView: UITableView) {
        tableView.register(self, forCellReuseIdentifier: self.identifier)
    }
    
    static func dequeue(for tableView: UITableView, at indexPath: IndexPath) -> Self {
        return _cell(dequeuedFor: tableView, indexPath: indexPath)
    }
    
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
