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
        
        tableView.backgroundColor = UIColor.groupTableViewBackground
        tableView.tableFooterView = UIView()
        
        UITableViewCell.register(in: tableView)
        
    }
    
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    
    private enum Section: Int {
        
        case appearance
        case transition
        case rxMvvm
        case taptics
        case helpers
        static var count: Int = 4
        
    }
    
    private enum AppearanceRow: Int {
        
        case `default`
        case inferred
        case custom
        case modal
        static var count = 4
        
    }
    
    private enum TransitionRow: Int {
        
        case fade
        case slide
        case cover
        case swap
        case pushBack
        case custom
        static var count = 5
        
        var transition: UITransition {
            
            switch self {
            case .fade: return UIFadeTransition()
            case .slide: return UISlideTransition()
            case .cover: return UICoverTransition()
            case .swap: return UISwapTransition()
            case .pushBack: return UIPushBackTransition()
            case .custom: return CustomTransition()
            }
            
        }
        
        var title: String {
            
            switch self {
            case .fade: return "UIFadeTransition"
            case .slide: return "UISlideTransition"
            case .cover: return "UICoverTransition"
            case .swap: return "UISwapTransition"
            case .pushBack: return "UIPushBackTransition"
            case .custom: return "Custom"
            }
            
        }
        
    }
    
    private enum RxMvvmRow: Int {
        
        case viewController
        case tableView
        case collectionView
        static var count: Int = 3
        
        var title: String {
            
            switch self {
            case .viewController: return "UIViewController"
            case .tableView: return "UITableView"
            case .collectionView: return "UICollectionView"
            }
            
        }
        
    }
    
    private enum TapticRow: Int {
        
        case selection
        case impactLight
        case impactMedium
        case impactHeavy
        case notificationSuccess
        case notificationWarning
        case notificationError
        static var count = 7
        
        var title: String {
            
            switch self {
            case .selection: return "Selection"
            case .impactLight: return "Impact (light)"
            case .impactMedium: return "Impact (medium)"
            case .impactHeavy: return "Impact (heavy)"
            case .notificationSuccess: return "Notification (success)"
            case .notificationWarning: return "Notification (warning)"
            case .notificationError: return "Notification (error)"
            }
            
        }
        
        var taptic: UITaptic {
            
            switch self {
            case .selection: return UITaptic(style: .selection)
            case .impactLight: return UITaptic(style: .impact(.light))
            case .impactMedium: return UITaptic(style: .impact(.medium))
            case .impactHeavy: return UITaptic(style: .impact(.heavy))
            case .notificationSuccess: return UITaptic(style: .notification(.success))
            case .notificationWarning: return UITaptic(style: .notification(.warning))
            case .notificationError: return UITaptic(style: .notification(.error))
            }
            
        }
        
    }
    
    private enum HelpersRow: Int {
        
        case deviceInfo
        case displayFeatureInsets
        static var count: Int = 2
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let _section = Section(rawValue: section) else { return nil }
        
        switch _section {
        case .appearance: return "Appearance"
        case .transition: return "Transitions"
        case .rxMvvm: return "Rx / MVVM"
        case .taptics: return "Taptics"
        case .helpers: return "Helpers"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _section = Section(rawValue: section) else { return 0 }
        
        switch _section {
        case .appearance: return AppearanceRow.count
        case .transition: return TransitionRow.count
        case .rxMvvm: return RxMvvmRow.count
        case .taptics: return TapticRow.count
        case .helpers: return HelpersRow.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let _section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        
        let cell = UITableViewCell.dequeue(for: tableView, at: indexPath)

        switch _section {
        case .appearance:
            
            guard let row = AppearanceRow(rawValue: indexPath.row) else { return UITableViewCell() }
            
            switch row {
            case .default: cell.textLabel?.text = "Default"
            case .inferred: cell.textLabel?.text = "Inferred"
            case .custom: cell.textLabel?.text = "Custom"
            case .modal: cell.textLabel?.text = "Modal"
            }
         
        case .transition:
            
            guard let row = TransitionRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
        
        case .rxMvvm:
            
            guard let row = RxMvvmRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            
        case .taptics:
            
            guard let row = TapticRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            
        case .helpers:
            
            guard let row = HelpersRow(rawValue: indexPath.row) else { return UITableViewCell() }
            
            switch row {
            case .deviceInfo: cell.textLabel?.text = "Device Info"
            case .displayFeatureInsets: cell.textLabel?.text = "Display Feature Insets"
            }
            
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let _section = Section(rawValue: indexPath.section) else { return }
        
        switch _section {
        case .appearance:
            
            guard let row = AppearanceRow(rawValue: indexPath.row) else { return }
            
            let vc = AppearanceViewController()
            
            switch row {
            case .default:
                
                vc.title = "Default"
                vc.statusBarAppearance = UIStatusBarAppearance()
                vc.navBarAppearance = UINavigationBarAppearance()
                
            case .inferred:
                
                vc.title = "Inferred"
                vc.statusBarAppearance = UIStatusBarAppearance.inferred(for: vc)
                vc.navBarAppearance = UINavigationBarAppearance.inferred(for: vc)
            
            case .custom:
                
                let status = UIStatusBarAppearance()
                status.style = .lightContent
                
                let nav = UINavigationBarAppearance()
                nav.barColor = UIColor(white: 0.1, alpha: 1)
                nav.titleColor = UIColor.white
                nav.itemColor = UIColor.white
                
                if #available(iOS 11, *) {
                    nav.largeTitleDisplayMode = .always
                    nav.largeTitleColor = UIColor.white
                    nav.largeTitleFont = UIFont.systemFont(ofSize: 40, weight: .black)
                }
                
                vc.title = "Custom"
                vc.statusBarAppearance = status
                vc.navBarAppearance = nav
            
            case .modal:
                
                let navBar = UINavigationBarAppearance()
                navBar.titleColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
                navBar.titleFont = UIFont.systemFont(ofSize: 16, weight: .black)
                navBar.itemColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
                navBar.transparent = true
                
                vc.title = "Modal"
                vc.showsDismissButton = true
                vc.statusBarAppearance = UIStatusBarAppearance()
                vc.navBarAppearance = navBar
                
                let nav = UIStyledNavigationController(rootViewController: vc)
                self.present(nav, animated: true, completion: nil)
                
                return
                
            }
            
            self.navigationController?.pushViewController(vc, animated: true)
        
        case .transition:
            
            guard let row = TransitionRow(rawValue: indexPath.row) else { return }

            let vc = TransitionViewController()
            vc.title = row.title
            
            let navBar = UINavigationBarAppearance()
            navBar.titleColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
            navBar.titleFont = UIFont.systemFont(ofSize: 16, weight: .medium)
            navBar.itemColor = #colorLiteral(red: 0.851971209, green: 0.6156303287, blue: 0.454634726, alpha: 1)
            navBar.transparent = true
            vc.navBarAppearance = navBar
            
            let nav = UIStyledNavigationController(rootViewController: vc)
            self.present(nav, with: row.transition, completion: nil)
        
        case .rxMvvm:
            
            guard let row = RxMvvmRow(rawValue: indexPath.row) else { return }

            switch row {
            case .viewController:
                
                let vc = RxViewController(viewModel: RxViewModel())
                self.navigationController?.pushViewController(vc, animated: true)
                
            case .tableView: break
            case .collectionView: break
            }
            
        case .taptics:
            
            guard let row = TapticRow(rawValue: indexPath.row) else { return }
            row.taptic.trigger()
            
        case .helpers:
            
            guard let row = HelpersRow(rawValue: indexPath.row) else { return }
            
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
                label.text = """
                This overlay view is constrained to your device's display feature insets.\n\nThis takes into account things like: status bars, home grabbers, etc...\n\nTap to dismiss 😊
                """
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
    
}
