//
//  ContextMenuTableViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 10/1/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Espresso

protocol ContextMenuTableViewControllerDelegate: AnyObject {
    
    func contextMenuTableViewController(_ vc: ContextMenuTableViewController,
                                        didSelectColor color: ESColor)
    
}

class ContextMenuTableViewController: UIViewController {
    
    private var tableView: UITableView!
    
    weak var delegate: ContextMenuTableViewControllerDelegate?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.tableView = UITableView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        UITableViewCell.register(in: self.tableView)
//        ContextTableCell.register(in: self.tableView)
        
    }
    
}

extension ContextMenuTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        let cell = ContextTableCell.dequeue(for: tableView, at: indexPath)
//        cell.setup(color: ESColor.allCases.randomElement() ?? .red, delegate: self)
//        return cell
        
        return UITableViewCell.dequeue(for: tableView, at: indexPath)
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
//        tableView.deselectRow(at: indexPath, animated: true)
//
//        guard let cell = tableView.cellForRow(at: indexPath) as? ContextTableCell else { return }
//
//        self.delegate?.contextMenuTableViewController(
//            self,
//            didSelectColor: cell.color
//        )
        
    }
    
}

//extension ContextMenuTableViewController: ContextTableCellDelegate {
//
//    func contextTableCellPreview(_ cell: ContextTableCell,
//                                 for color: ESColor) -> UIViewController? {
//
//        let vc = DetailViewController()
//        vc.title = color.name
//        vc.view.backgroundColor = color.color
//        return vc
//
//    }
//
//    func contextTableCellDidTapPreview(_ cell: ContextTableCell, preview: UIViewController?) {
//
//        self.delegate?.contextMenuTableViewController(
//            self,
//            didSelectColor: cell.color
//        )
//
//    }
//
//}
