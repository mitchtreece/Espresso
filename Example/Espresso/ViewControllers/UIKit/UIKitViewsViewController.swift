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
        setupSubviews()
        
    }
    
    private func setupSubviews() {
        
        self.stackView = UIScrollingStackView()
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.alwaysBounceVertical = true
        self.stackView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            
            make.top.bottom.equalToSuperview()
            make.left.equalTo(8)
            make.right.equalTo(-8)

        }
        
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
        headerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
        
        let divider = UIHairlineView()
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
