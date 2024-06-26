//
//  UIStackView+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 1/10/23.
//

#if canImport(UIKit)

import UIKit

public extension UIStackView /* Subviews */ {
    
    @discardableResult
    func addArrangedInsetSubview(_ view: UIView,
                                 insets: UIEdgeInsets,
                                 backgroundColor: UIColor = .clear) -> UIView {
        
        let container = UIView()
        container.backgroundColor = backgroundColor
        container.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(insets.top)
            make.edges.equalTo(insets)
            make.left.equalTo(insets.left)
            make.bottom.equalTo(-insets.bottom)
            make.right.equalTo(-insets.right)
        }
        
        addArrangedSubview(container)
        
        return container
        
    }
    
    @discardableResult
    func insertArrangedInsetSubview(_ view: UIView,
                                    at index: Int,
                                    insets: UIEdgeInsets,
                                    backgroundColor: UIColor = .clear) -> UIView {
        
        let container = UIView()
        container.addSubview(view)
        view.snp.makeConstraints { make in
            make.top.equalTo(insets.top)
            make.left.equalTo(insets.left)
            make.bottom.equalTo(-insets.bottom)
            make.right.equalTo(-insets.right)
        }
        
        insertArrangedSubview(
            container,
            at: index
        )
        
        return container
        
    }
        
    @discardableResult
    func addArrangedSpaceSubview(size: CGFloat,
                                 backgroundColor: UIColor = .clear) -> UIView {
        
        let vertical = (self.axis == .vertical)
        
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.snp.makeConstraints { make in
            
            if vertical {
                make.height.equalTo(size)
            }
            else {
                make.width.equalTo(size)
            }
            
        }
        
        addArrangedSubview(view)
        
        return view
        
    }
    
    @discardableResult
    func insertArrangedSpaceSubview(size: CGFloat,
                                    at index: Int,
                                    backgroundColor: UIColor = .clear) -> UIView {
        
        let vertical = (self.axis == .vertical)
        
        let view = UIView()
        view.backgroundColor = backgroundColor
        view.snp.makeConstraints { make in
            
            if vertical {
                make.height.equalTo(size)
            }
            else {
                make.width.equalTo(size)
            }
            
        }
        
        insertArrangedSubview(
            view,
            at: index
        )
        
        return view
        
    }
    
}

#endif
