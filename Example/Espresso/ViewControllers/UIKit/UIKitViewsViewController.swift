//
//  UIKitViewsViewController.swift
//  Espresso_Example
//
//  Created by Mitch Treece on 7/27/22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit
import Espresso

class UIKitViewsViewController: DetailViewController {
    
    private var stackView: UIScrollingStackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "UIKit Views"
                
    }
    
    override func viewWillSetup() {
        
        super.viewWillSetup()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Dismiss KB",
            style: .done,
            target: self,
            action: #selector(dismissKB)
        )
        
        self.stackView = UIScrollingStackView()
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 16
        self.stackView.alwaysBounceVertical = true
        self.stackView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            
            make.top.bottom.equalToSuperview()
            make.left.equalTo(8)
            make.right.equalTo(-8)

        }
        
        // UIButtonView
        
        let disabledFillButton = UIButtonView(title: "Filled (Disabled)", action: {})
        disabledFillButton.isEnabled = false
        
        let disabledOutlineButton = UIButtonView(title: "Outline (Disabled)", style: .outline, action: {print("h")})
        disabledOutlineButton.isEnabled = false
                                              
        self.stackView.addArrangedSubview(buildSection(
            title: "UIButtonView",
            subviews: [
                UIButtonView(title: "Filled", action: {}),
                UIButtonView(title: "Outline", style: .outline, action: {}),
                disabledFillButton,
                disabledOutlineButton
            ]))
        
        // UIGradientView
        
        let upGradientView = UIGradientView(colors: [.red, .clear])
        upGradientView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let leftGradientView = UIGradientView(colors: [.green, .clear], direction: .left)
        leftGradientView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let downGradientView = UIGradientView(colors: [.blue, .clear], direction: .down)
        downGradientView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let rightGradientView = UIGradientView(colors: [.black, .clear], direction: .right)
        rightGradientView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        self.stackView.addArrangedSubview(buildSection(
            title: "UIGradientView",
            subviews: [
                upGradientView,
                leftGradientView,
                downGradientView,
                rightGradientView
            ]))
        
    }

    @objc private func dismissKB(_ sender: UIBarButtonItem) {
        self.view.endEditing(true)
    }
    
    private func buildSection(title: String,
                              subviews: [UIView]) -> UIView {
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        
        let headerView = UIView()
        headerView.backgroundColor = .clear
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .preferredFont(forTextStyle: .headline)
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        let divider = UIHairlineView()
        divider.backgroundColor = .black
        headerView.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.left.bottom.right.equalToSuperview()
        }
        
        stackView
            .addArrangedSubview(headerView)
        
        subviews
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
        
    }
    
}
