//
//  RootViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 12/18/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit
import Espresso
import SnapKit

class RootViewController: UIStyledViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override var preferredStatusBarAppearance: UIStatusBarAppearance {

        let appearance = UIStatusBarAppearance()
        appearance.style = .lightContent
        return appearance

    }
    
    override var preferredNavigationBarAppearance: UINavigationBarAppearance {

        let appearance = UINavigationBarAppearance()
        appearance.barColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
        appearance.titleColor = UIColor.white
        appearance.itemColor = UIColor.white

        if #available(iOS 11, *) {
            appearance.largeTitleDisplayMode = .always
            appearance.largeTitleColor = UIColor.white
        }

        return appearance

    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Espresso ☕️"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = UIView()
        
    }
    
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    
    private enum Row: Int {
        
        case deviceInfo
        case displayFeatureInsets
        static var count: Int = 2
        
    }
    
    private func title(for row: Row) -> String {
        
        switch row {
        case .deviceInfo: return "Device Info"
        case .displayFeatureInsets: return "Display Feature Insets"
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier)
        cell?.textLabel?.text = title(for: row)
        cell?.accessoryType = .disclosureIndicator
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let row = Row(rawValue: indexPath.row) else { return }
        
        switch row {
        case .deviceInfo:
            
            let info = UIDevice.current.info()
            let isSimulator = UIDevice.current.isSimulator
            
            let title = isSimulator ? "\(info.displayName) (Simulator)" : info.displayName
            let message = "System Version: \(info.systemVersion)\nJailbroken: \(info.isJailbroken)"
            
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        
        case .displayFeatureInsets:
            
            let v = UIView()
            v.backgroundColor = UIColor.black.withAlphaComponent(0.6)
            self.navigationController?.view.addSubview(v)
            v.snp.makeConstraints { (make) in
                
                let insets = UIScreen.main.displayFeatureInsets
                
                make.top.equalTo(0).offset(insets.top)
                make.left.equalTo(0).offset(insets.left)
                make.right.equalTo(0).offset(-insets.right)
                make.bottom.equalTo(0).offset(-insets.bottom)
                
            }
            
            let label = UILabel()
            label.backgroundColor = UIColor.clear
            label.textColor = UIColor.white
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.text = "This overlay view is constrained to your device's display feature insets.\n\nThis takes into account things like: status bars, home grabbers, etc...\n\nTap to dismiss 😊"
            label.textAlignment = .center
            label.numberOfLines = 0
            label.isUserInteractionEnabled = true
            v.addSubview(label)
            label.snp.makeConstraints { (make) in
                make.top.equalTo(14)
                make.bottom.equalTo(-14)
                make.left.equalTo(44)
                make.right.equalTo(-44)
            }
            
            let tap = UITapGestureRecognizer(action: { (recognizer) in
                v.removeFromSuperview()
            })
            
            label.addGestureRecognizer(tap)
            
        }
        
    }
    
}
