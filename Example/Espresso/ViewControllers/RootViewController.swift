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

protocol RootViewControllerDelegate: AnyObject {
    
    func rootViewController(_ vc: RootViewController,
                            didSelectSwiftUIRow row: RootViewController.SwiftUIRow)
    
    func rootViewController(_ vc: RootViewController,
                            didSelectTransitionRow row: RootViewController.TransitionRow)
    
    func rootViewController(_ vc: RootViewController,
                            didSelectMenuRow row: RootViewController.MenuRow)
    
    func rootViewControllerWantsToPresentRxViewController(_ vc: RootViewController)
    func rootViewControllerWantsToPresentCombineViewController(_ vc: RootViewController)

}

class RootViewController: UIViewController {
    
    private var tableView: UITableView!
    private weak var delegate: RootViewControllerDelegate?
    
    init(delegate: RootViewControllerDelegate) {
        
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Espresso ☕️"
                
        self.events.viewDidAppear.addObserver {
            print("☕️ RootViewController did appear")
        }
                
        self.tableView = UITableView(frame: .zero, style: .grouped)
        self.tableView.backgroundColor = .systemGroupedBackground
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        self.tableView.register(cells: [
            UITableViewCell.self,
            ContextTableCell.self
        ])

    }
    
}

extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    
    private enum Section: Int, CaseIterable {
        
        case swiftui
        case transition
        case rxMvvm
        case combine
        case taptics
        case helpers
        case menus
        
    }
    
    enum SwiftUIRow: Int, CaseIterable {
        
        case views
        
        var title: String {
            
            switch self {
            case .views: return "Views"
            }
            
        }
        
    }
    
    enum TransitionRow: Int, CaseIterable {
        
        case fade
        case slide
        case cover
        case reveal
        case swap
        case pushBack
        case zoom
        case custom
        
        var transition: UIViewControllerTransition {
            
            switch self {
            case .fade: return UIFadeTransition()
            case .slide: return UISlideTransition()
            case .cover: return UICoverTransition()
            case .reveal: return UIRevealTransition()
            case .swap: return UISwapTransition()
            case .pushBack: return UIPushBackTransition()
            case .zoom: return UIZoomTransition()
            case .custom: return CustomTransition()
            }
            
        }
        
        var title: String {
            
            switch self {
            case .fade: return "UIFadeTransition"
            case .slide: return "UISlideTransition"
            case .cover: return "UICoverTransition"
            case .reveal: return "UIRevealTransition"
            case .swap: return "UISwapTransition"
            case .pushBack: return "UIPushBackTransition"
            case .zoom: return "UIZoomTransition"
            case .custom: return "Custom"
            }
            
        }
        
    }
    
    enum MenuRow: Int, CaseIterable {
        
        case view
        case table
        case collection
        
        var title: String {
            
            switch self {
            case .view: return "UIView"
            case .table: return "UITableViewCell"
            case .collection: return "UICollectionViewCell"
            }
            
        }
        
    }
    
    private enum RxMvvmRow: Int, CaseIterable {
        
        case viewController
        
        var title: String {
            
            switch self {
            case .viewController: return "UIViewController"
            }
            
        }
        
    }
    
    private enum CombineRow: Int, CaseIterable {
        
        case viewController
        
        var title: String {
            
            switch self {
            case .viewController: return "UIViewController"
            }
            
        }
        
    }
    
    private enum TapticRow: Int, CaseIterable {
        
        case selection
        case impactLight
        case impactMedium
        case impactHeavy
        case notificationSuccess
        case notificationWarning
        case notificationError
        
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
        
        var taptic: Taptic {
            
            switch self {
            case .selection: return Taptic(style: .selection)
            case .impactLight: return Taptic(style: .impact(.light))
            case .impactMedium: return Taptic(style: .impact(.medium))
            case .impactHeavy: return Taptic(style: .impact(.heavy))
            case .notificationSuccess: return Taptic(style: .notification(.success))
            case .notificationWarning: return Taptic(style: .notification(.warning))
            case .notificationError: return Taptic(style: .notification(.error))
            }
            
        }
        
    }
    
    private enum HelpersRow: Int, CaseIterable {
        
        case deviceInfo
        case displayFeatureInsets
        case authentication
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        guard let _section = Section(rawValue: section) else { return nil }
        
        switch _section {
        case .swiftui: return "SwiftUI"
        case .transition: return "Transitions"
        case .menus: return "Menus"
        case .rxMvvm: return "Rx / MVVM"
        case .combine: return "Combine"
        case .taptics: return "Taptics"
        case .helpers: return "Helpers"
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let _section = Section(rawValue: section) else { return 0 }
        
        switch _section {
        case .swiftui: return SwiftUIRow.allCases.count
        case .transition: return TransitionRow.allCases.count
        case .menus: return MenuRow.allCases.count
        case .rxMvvm: return RxMvvmRow.allCases.count
        case .combine: return CombineRow.allCases.count
        case .taptics: return TapticRow.allCases.count
        case .helpers: return HelpersRow.allCases.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let _section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
                
        let cell = UITableViewCell.dequeue(for: tableView, at: indexPath)

        switch _section {
        case .swiftui:
            
            guard let row = SwiftUIRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            
        case .transition:
            
            guard let row = TransitionRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            
        case .menus:
            
            guard let row = MenuRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
        
        case .rxMvvm:
            
            guard let row = RxMvvmRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            
        case .combine:
            
            guard let row = CombineRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
        
        case .taptics:
            
            guard let row = TapticRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            
        case .helpers:
            
            guard let row = HelpersRow(rawValue: indexPath.row) else { return UITableViewCell() }
            
            switch row {
            case .deviceInfo: cell.textLabel?.text = "Device Info"
            case .displayFeatureInsets: cell.textLabel?.text = "Display Feature Insets"
            case .authentication: cell.textLabel?.text = "Authentication"
            }
            
        }
        
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let _section = Section(rawValue: indexPath.section) else { return }
        
        switch _section {
        case .swiftui:
            
            guard let row = SwiftUIRow(rawValue: indexPath.row) else { return }
            self.delegate?.rootViewController(self, didSelectSwiftUIRow: row)
            
        case .transition:
            
            guard let row = TransitionRow(rawValue: indexPath.row) else { return }
            self.delegate?.rootViewController(self, didSelectTransitionRow: row)

        case .menus:
            
            guard let row = MenuRow(rawValue: indexPath.row) else { return }
            self.delegate?.rootViewController(self, didSelectMenuRow: row)
            
        case .rxMvvm:
            
            guard let row = RxMvvmRow(rawValue: indexPath.row) else { return }

            switch row {
            case .viewController: self.delegate?.rootViewControllerWantsToPresentRxViewController(self)
            }
            
        case .combine:
            
            guard let row = CombineRow(rawValue: indexPath.row) else { return }

            switch row {
            case .viewController: self.delegate?.rootViewControllerWantsToPresentCombineViewController(self)
            }
            
        case .taptics:
            
            guard let row = TapticRow(rawValue: indexPath.row) else { return }
            row.taptic.trigger()
            
        case .helpers:
            
            guard let row = HelpersRow(rawValue: indexPath.row) else { return }
            
            switch row {
            case .deviceInfo:
                
                let device = AppleDevice.current
                let title = device.isSimulator ? "\(device.generationalName) (Simulator)" : device.generationalName
                let message = "\(device.softwareName): \(device.softwareVersion)\nJailbroken: \(device.isJailbroken)"
                
                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            case .displayFeatureInsets:
                
                let v = UIView()
                v.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                self.navigationController?.view.addSubview(v)
                v.snp.makeConstraints { (make) in
                    
                    let insets = UIScreen.main.featureInsets
                    
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
                This overlay view is constrained to your device's display feature insets.
                
                This takes into account things like: status bars, home grabbers, etc...
                
                Tap to dismiss 😊
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
                
            case .authentication:
                
                UserAuthenticator.authenticate(withReason: "Espresso needs to authenticate you.") { [weak self] (success, error) in
                    
                    let alert = UIAlertController(
                        title: success ? "Success 😎" : "Failure 😢",
                        message: success ? "You've been authenticated!" : "You couldn't be authenticated.",
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    
                    DispatchQueue.main.async {
                        self?.present(alert, animated: true, completion: nil)
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
