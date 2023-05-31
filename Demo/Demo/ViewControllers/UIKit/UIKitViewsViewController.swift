//
//  UIKitViewsViewController.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit
import EspressoUI

class UIKitViewsViewController: DetailViewController {
    
    private var stackView: UIScrollingStackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "UIKit Views"
                
    }
    
    override func viewWillLoadLayout() {
        
        super.viewWillLoadLayout()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Dismiss KB",
            style: .done,
            target: self,
            action: #selector(dismissKB)
        )
        
        self.stackView = UIScrollingStackView()
        self.stackView.axis = .vertical
        self.stackView.distribution = .equalSpacing
        self.stackView.spacing = 32
        self.stackView.alwaysBounceVertical = true
        self.stackView.showsVerticalScrollIndicator = false
        self.stackView.contentInset = .init(top: 16)
        self.stackView.contentOffset.y = -self.stackView.contentInset.top
        self.view.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(8)
            make.right.equalTo(-8)
        }
        
        // UIBlurView
        
        let blurContentView = UIView()
        blurContentView.snp.makeConstraints { make in
            make.height.equalTo(200)
        }
        
        let blurImageView = UIImageView()
        blurImageView.image = UIImage(named: "Logo")
        blurImageView.contentMode = .scaleAspectFill
        blurImageView.clipsToBounds = true
        blurContentView.addSubview(blurImageView)
        blurImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let blurStackView = UIStackView()
        blurStackView.backgroundColor = .clear
        blurStackView.axis = .vertical
        blurStackView.distribution = .fillEqually
        blurStackView.spacing = 8
        blurContentView.addSubview(blurStackView)
        blurStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let defaultBlurView = UIBlurView()
        blurStackView.addArrangedSubview(defaultBlurView)
        
        let tintedBlurView = UIBlurView(style: .system(.systemUltraThinMaterial))
        tintedBlurView.tintColor = .blue.withAlphaComponent(0.1)
        blurStackView.addArrangedSubview(tintedBlurView)

        let variableBlurView = UIBlurView(style: .variable())
        blurStackView.addArrangedSubview(variableBlurView)
        
        stackView.addArrangedSubview(buildSection(
            title: "UIBlurView",
            subviews: [
                blurContentView
            ]))
        
        // UIButtonView
        
        let disabledFillButton = UIButtonView()
        disabledFillButton.title = "Filled (Disabled)"
        disabledFillButton.isEnabled = false
        
        let disabledOutlineButton = UIButtonView()
        disabledOutlineButton.style = .outline
        disabledOutlineButton.title = "Outline (Disabled)"
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
        
        let leftGradientView = UIGradientView(
            colors: [.green, .clear],
            direction: .left
        )
        
        leftGradientView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let downGradientView = UIGradientView(
            colors: [.blue, .clear],
            direction: .down
        )
        
        downGradientView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let rightGradientView = UIGradientView(
            colors: [.black, .clear],
            direction: .right
        )
        
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
        
        // UIShimmerView
        
        let shimmerView = UIShimmerView()
        shimmerView.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let shimmerView2 = UIShimmerView()
        shimmerView2.backgroundColor = .systemRed
        shimmerView2.shimmerColor = .systemOrange
        shimmerView2.shimmerDirection = .angle(45)
        shimmerView2.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        let shimmerView3 = UIShimmerView()
        shimmerView3.backgroundColor = .systemBlue
        shimmerView3.shimmerColor = .systemTeal
        shimmerView3.shimmerDirection = .angle(225)
        shimmerView3.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        self.stackView.addArrangedSubview(buildSection(
            title: "UIShimmerView",
            subviews: [
                shimmerView,
                shimmerView2,
                shimmerView3
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
            make.top.horizontalEdges.equalToSuperview()
        }
        
        let divider = UIHairlineView()
        divider.backgroundColor = .black
        headerView.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.bottom.horizontalEdges.equalToSuperview()
        }
        
        stackView
            .addArrangedSubview(headerView)
        
        subviews
            .forEach { stackView.addArrangedSubview($0) }
        
        return stackView
        
    }
    
}
