//
//  RootViewController.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit
import Espresso
import EspressoUI
import SFSafeSymbols
import SnapKit

protocol RootViewControllerDelegate: AnyObject {
    
    func rootViewController(_ vc: RootViewController,
                            didSelectUIKitRow row: RootViewController.UIKitRow)
    
    func rootViewController(_ vc: RootViewController,
                            didSelectSwiftUIRow row: RootViewController.SwiftUIRow)
    
    func rootViewController(_ vc: RootViewController,
                            didSelectTransitionRow row: RootViewController.VCTransitionRow)
    
    func rootViewControllerWantsToPresentCombineViewController(_ vc: RootViewController)

}

class RootViewController: UIBaseViewController {
    
    private var tableView: UITableView!
    private weak var delegate: RootViewControllerDelegate?
        
    init(delegate: RootViewControllerDelegate) {
        
        super.init(
            nibName: nil,
            bundle: nil
        )
        
        self.delegate = delegate
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "Espresso ☕️"
        
    }
    
    override func viewWillLoadLayout() {
        
        super.viewWillLoadLayout()
        
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.backgroundColor = .systemGroupedBackground
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(0)
        }
        
        self.tableView.register(cells: [
            UITableViewCell.self
        ])
        
    }
    
}

extension RootViewController: UITableViewDelegate,
                              UITableViewDataSource {
    
    private enum Section: Int, CaseIterable {
        
        case uikit
        case swiftui
        case vcTransitions
        case combine
        case taptics
        case helpers
        
    }
    
    enum UIKitRow: Int, CaseIterable {
        
        case views
        
        var title: String {
            
            switch self {
            case .views: return "Views"
            }
            
        }
        
        var image: UIImage {
            
            switch self {
            case .views: return UIImage(systemSymbol: .viewfinder)
            }
            
        }
        
    }
    
    enum SwiftUIRow: Int, CaseIterable {
        
        // case views
        case hostingView
        
        var title: String {
            
            switch self {
            // case .views: return "Views"
            case .hostingView: return "UIHostingView"
            }
            
        }
        
        var image: UIImage {
            
            switch self {
            // case .views: return UIImage(systemSymbol: .viewfinder)
            case .hostingView: return UIImage(systemSymbol: .squareStack3dDownRight)
            }
            
        }
        
    }
    
    enum VCTransitionRow: Int, CaseIterable {
        
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
            case .fade: return "Fade"
            case .slide: return "Slide"
            case .cover: return "Cover"
            case .reveal: return "Reveal"
            case .swap: return "Swap"
            case .pushBack: return "Push Back"
            case .zoom: return "Zoom"
            case .custom: return "Custom"
            }
            
        }
        
        var image: UIImage {
            
            switch self {
            case .fade: return UIImage(systemSymbol: .squareStack3dDownDottedline)
            case .slide: return UIImage(systemSymbol: .arrowLeft)
            case .cover: return UIImage(systemSymbol: .arrowLeftCircle)
            case .reveal: return UIImage(systemSymbol: .squareRighthalfFill)
            case .swap: return UIImage(systemSymbol: .arrowRightArrowLeft)
            case .pushBack: return UIImage(systemSymbol: .handRaised)
            case .zoom: return UIImage(systemSymbol: .arrowLeftAndRight)
            case .custom: return UIImage(systemSymbol: .person)
            }
            
        }
        
    }

    private enum CombineRow: Int, CaseIterable {
        
        case viewController
        
        var title: String {
            
            switch self {
            case .viewController: return "UICombineViewModelViewController"
            }
            
        }
        
        var image: UIImage {
            
            switch self {
            case .viewController: return UIImage(systemSymbol: .docPlaintext)
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
        
        var image: UIImage {
            return UIImage(systemSymbol: .waveform)
        }
        
        var taptic: UITaptic {
            
            switch self {
            case .selection: return .init(style: .selection)
            case .impactLight: return .init(style: .impact(.light))
            case .impactMedium: return .init(style: .impact(.medium))
            case .impactHeavy: return .init(style: .impact(.heavy))
            case .notificationSuccess: return .init(style: .notification(.success))
            case .notificationWarning: return .init(style: .notification(.warning))
            case .notificationError: return .init(style: .notification(.error))
            }
            
        }
        
    }
    
    private enum HelpersRow: Int, CaseIterable {
        
        case appleDevice
        case userAuthentication
        
        var title: String {
            
            switch self {
            case .appleDevice: return "AppleDevice Info"
            case .userAuthentication: return "User Authentication"
            }
            
        }
        
        var image: UIImage {
            
            switch self {
            case .appleDevice: return UIImage(systemSymbol: .infoCircle)
            case .userAuthentication: return UIImage(systemSymbol: .lock)
            }
            
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView,
                   titleForHeaderInSection section: Int) -> String? {
        
        guard let _section = Section(rawValue: section) else { return nil }
        
        switch _section {
        case .uikit: return "UIKit"
        case .swiftui: return "SwiftUI"
        case .vcTransitions: return "VC Transitions"
        case .combine: return "Combine"
        case .taptics: return "Taptics"
        case .helpers: return "Helpers"
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        guard let _section = Section(rawValue: section) else { return 0 }
        
        switch _section {
        case .uikit: return UIKitRow.allCases.count
        case .swiftui: return SwiftUIRow.allCases.count
        case .vcTransitions: return VCTransitionRow.allCases.count
        case .combine: return CombineRow.allCases.count
        case .taptics: return TapticRow.allCases.count
        case .helpers: return HelpersRow.allCases.count
        }
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let _section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
                
        let cell = UITableViewCell
            .dequeue(for: tableView, at: indexPath)

        switch _section {
        case .uikit:
            
            guard let row = UIKitRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            cell.imageView?.image = row.image
            
        case .swiftui:
            
            guard let row = SwiftUIRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            cell.imageView?.image = row.image

        case .vcTransitions:
            
            guard let row = VCTransitionRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            cell.imageView?.image = row.image

        case .combine:
            
            guard let row = CombineRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            cell.imageView?.image = row.image

        case .taptics:
            
            guard let row = TapticRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            cell.imageView?.image = row.image

        case .helpers:
            
            guard let row = HelpersRow(rawValue: indexPath.row) else { return UITableViewCell() }
            cell.textLabel?.text = row.title
            cell.imageView?.image = row.image

        }
        
        cell.imageView?.tintColor = UIColor(hex: "#8E5F45")
        cell.accessoryType = .disclosureIndicator
        return cell
        
    }
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView
            .deselectRow(at: indexPath, animated: true)
        
        guard let _section = Section(rawValue: indexPath.section) else { return }
        
        switch _section {
        case .uikit:
            
            guard let row = UIKitRow(rawValue: indexPath.row) else { return }
            
            self.delegate?
                .rootViewController(self, didSelectUIKitRow: row)
            
        case .swiftui:
            
            guard let row = SwiftUIRow(rawValue: indexPath.row) else { return }
            
            self.delegate?
                .rootViewController(self, didSelectSwiftUIRow: row)
            
        case .vcTransitions:
            
            guard let row = VCTransitionRow(rawValue: indexPath.row) else { return }
            
            self.delegate?
                .rootViewController(self, didSelectTransitionRow: row)

        case .combine:
            
            guard let row = CombineRow(rawValue: indexPath.row) else { return }

            switch row {
            case .viewController:
                
                self.delegate?
                    .rootViewControllerWantsToPresentCombineViewController(self)
                
            }
            
        case .taptics:
            
            guard let row = TapticRow(rawValue: indexPath.row) else { return }
            row.taptic.play()
            
        case .helpers:
            
            guard let row = HelpersRow(rawValue: indexPath.row) else { return }
            
            switch row {
            case .appleDevice:
                
                let device = AppleDevice.current
                let title = device.isSimulator ? "\(device.generationalName) (Simulator)" : device.generationalName
                let message = "\(device.softwareName): \(device.softwareVersion)\nJailbroken: \(device.isJailbroken)"
                
                let alert = UIAlertController(
                    title: title,
                    message: message,
                    preferredStyle: .alert
                )
                
                alert.addAction(UIAlertAction(
                    title: "Okay",
                    style: .cancel,
                    handler: nil
                ))
                
                present(
                    alert,
                    animated: true,
                    completion: nil
                )

            case .userAuthentication:
                
                let reason = "Espresso needs to authenticate you."
                
                UserAuthenticator.authenticate(withReason: reason) { [weak self] (success, error) in
                    
                    let alert = UIAlertController(
                        title: success ? "Success 😎" : "Failure 😢",
                        message: success ? "You've been authenticated!" : "You couldn't be authenticated.",
                        preferredStyle: .alert
                    )
                    
                    alert.addAction(UIAlertAction(
                        title: "Okay",
                        style: .default,
                        handler: nil
                    ))
                    
                    DispatchQueue.main.async {
                        
                        self?.present(
                            alert,
                            animated: true,
                            completion: nil
                        )
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}
