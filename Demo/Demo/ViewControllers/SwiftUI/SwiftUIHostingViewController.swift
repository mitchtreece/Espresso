//
//  SwiftUIHostingViewController.swift
//  Demo
//
//  Created by Mitch Treece on 4/14/23.
//

import UIKit
import SwiftUI
import EspressoUI

class SwiftUIHostingViewController: DetailViewController {
        
    private var contentView: UIView!
    private var centerContentView: UIView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.title = "UIHostingView"
        
        setupSubviews()
                
    }
    
    private func setupSubviews() {
        
        self.edgesForExtendedLayout = []
        
        self.contentView = UIView()
        self.view.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        let topLeft = ColorView(color: randomColor()).asHostingView()
        self.contentView.addSubview(topLeft)
        topLeft.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.size.equalTo(100)
        }
        
        let topRight = ColorView(color: randomColor()).asHostingView()
        self.contentView.addSubview(topRight)
        topRight.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.size.equalTo(100)
        }
        
        let bottomLeft = ColorView(color: randomColor()).asHostingView()
        self.contentView.addSubview(bottomLeft)
        bottomLeft.snp.makeConstraints { make in
            make.bottom.left.equalToSuperview()
            make.size.equalTo(100)
        }
        
        let bottomRight = ColorView(color: randomColor()).asHostingView()
        self.contentView.addSubview(bottomRight)
        bottomRight.snp.makeConstraints { make in
            make.bottom.right.equalToSuperview()
            make.size.equalTo(100)
        }
        
        setupCenterViews()
        
    }

    private func setupCenterViews() {
        
        self.centerContentView = UIView()
        self.contentView.addSubview(self.centerContentView)
        self.centerContentView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(300)
        }
        
        var inset: CGFloat = 0
        
        for _ in 0..<6 {
            
            let view = ColorView(color: randomColor()).asHostingView()
            self.centerContentView.addSubview(view)
            view.snp.makeConstraints { make in
                
                make.edges
                    .equalToSuperview()
                    .inset(inset)
                
            }
            
            inset += 20
            
        }
        
    }
    
    private func randomColor() -> Color {
        return Color(UIColor.random())
    }
    
}
