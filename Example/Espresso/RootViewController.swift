//
//  RootViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 12/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class RootViewController: UIStyledViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarAppearance: UIStatusBarAppearance? {
        return UIStatusBarAppearance.default.style(.lightContent)
    }
    
    override var preferredNavigationBarAppearance: UINavigationBarAppearance? {
        
        var appearance = UINavigationBarAppearance()
        appearance.color = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
        appearance.titleColor = UIColor.white
        appearance.itemColor = UIColor.white
        
        if #available(iOS 11, *) {
            appearance.largeTitleDisplayMode = .always
        }
        
        return appearance
        
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RootCell")
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = UIView()
        
    }
    
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    
    private enum Row: Int {
        
        case keyboard
        
        static var count: Int = 1
        
    }
    
    private func title(for row: Row) -> String {
        
        switch row {
        case .keyboard: return "UIKeyboard"
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Row.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = Row(rawValue: indexPath.row) else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RootCell")
        cell?.textLabel?.text = title(for: row)
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let row = Row(rawValue: indexPath.row) else { return }
        
        switch row {
        case .keyboard:
            
            let vc = KeyboardViewController()
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
}
