//
//  UIContextMenuTableViewDelegateProxy.swift
//  Espresso
//
//  Created by Mitch Treece on 7/31/22.
//

//import UIKit
//
//public class UIContextMenuTableViewDelegateProxy: NSObject, UITableViewDelegate {
//    
//    internal weak var delegate: UITableViewDelegate?
//    internal weak var menuDelegate: UITableViewContextMenuDelegate?
//    
//    internal override init() {
//        super.init()
//    }
//    
//    public func tableView(_ tableView: UITableView,
//                          contextMenuConfigurationForRowAt indexPath: IndexPath,
//                          point: CGPoint) -> UIContextMenuConfiguration? {
//        
//        let contextMenu = self.menuDelegate?.tableView(
//            tableView,
//            contextMenuForCellAt: indexPath,
//            point: point
//        )
//
//        let configuration = self.delegate?.tableView?(
//            tableView,
//            contextMenuConfigurationForRowAt: indexPath,
//            point: point
//        )
//        
//        return contextMenu?.buildConfiguration() ?? configuration
//        
//    }
//
//    public func tableView(_ tableView: UITableView,
//                          didSelectRowAt indexPath: IndexPath) {
//
//        self.delegate?.tableView?(
//            tableView,
//            didSelectRowAt: indexPath
//        )
//
//    }
//    
//}
