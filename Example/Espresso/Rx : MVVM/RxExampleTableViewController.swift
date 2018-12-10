//
//  RxExampleTableViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 12/7/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class RxExampleTableViewController: RxViewModelViewController<RxExampleViewModel> {
    
    private var tableView: UITableView!
    
    override init(viewModel: RxExampleViewModel) {
        
        super.init(viewModel: viewModel)
        self.title = viewModel.tableTitle
        // self.tabBarItem.image = UIImage(named: "...")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white

        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTapDone(_:)))
        self.navigationItem.rightBarButtonItem = doneItem
        
    }
    
    @objc private func didTapDone(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
