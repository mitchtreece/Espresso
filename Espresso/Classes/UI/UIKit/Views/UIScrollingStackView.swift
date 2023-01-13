//
//  UIScrollingStackView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit
import SnapKit

public class UIScrollingStackView: UIScrollView {
    
    private var stackView = UIStackView()
    private var axisConstraint: NSLayoutConstraint?
    
    public class var spacingUseDefault: CGFloat {
        return UIStackView.spacingUseDefault        
    }

    public class var spacingUseSystem: CGFloat {
        return UIStackView.spacingUseSystem
    }
    
    public var alignment: UIStackView.Alignment {
        get { return self.stackView.alignment }
        set { self.stackView.alignment = newValue }
    }

    public var axis: NSLayoutConstraint.Axis {
        get { return self.stackView.axis }
        set {
            updateStackViewAxis(
                newValue,
                edgeInsets: self.contentEdgeInsets
            )
        }
    }

    public var isBaselineRelativeArrangement: Bool {
        get { return self.stackView.isBaselineRelativeArrangement }
        set { self.stackView.isBaselineRelativeArrangement = newValue }
    }

    public var distribution: UIStackView.Distribution {
        get { return self.stackView.distribution }
        set { self.stackView.distribution = newValue }
    }

    public var isLayoutMarginsRelativeArrangement: Bool {
        get { return self.stackView.isLayoutMarginsRelativeArrangement }
        set { self.stackView.isLayoutMarginsRelativeArrangement = newValue }
    }

    public var spacing: CGFloat {
        get { return self.stackView.spacing }
        set { self.stackView.spacing = newValue }
    }
    
    public var arrangedSubviews: [UIView] {
        return self.stackView.arrangedSubviews
    }
    
    public var contentEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            updateStackViewAxis(
                self.axis,
                edgeInsets: contentEdgeInsets
            )
        }
    }
    
    public override var layoutMargins: UIEdgeInsets {
        get { return self.stackView.layoutMargins }
        set { self.stackView.layoutMargins = newValue }
    }
    
    public override var directionalLayoutMargins: NSDirectionalEdgeInsets {
        get { return self.stackView.directionalLayoutMargins }
        set { self.stackView.directionalLayoutMargins = newValue }
    }
    
    private var stackViewLeftConstraint: Constraint!
    private var stackViewRightConstraint: Constraint!
    private var stackViewTopConstraint: Constraint!
    private var stackViewBottomConstraint: Constraint!

    public required init?(coder decoder: NSCoder) {

        super.init(coder: decoder)
        setup(axis: .vertical)

    }

    public override init(frame: CGRect) {

        super.init(frame: frame)
        setup(axis: .vertical)

    }

    public init(axis: NSLayoutConstraint.Axis = .vertical,
                arrangedSubviews: [UIView] = []) {

        super.init(frame: .zero)

        setup(axis: axis)

        for subview in arrangedSubviews {
            self.addArrangedSubview(subview)
        }

    }

    public convenience init() {
        self.init(axis: .vertical)
    }

    public func addArrangedSubview(_ view: UIView) {
        
        self.stackView
            .addArrangedSubview(view)
        
    }
    
    @discardableResult
    public func addArrangedInsetSubview(_ view: UIView,
                                 insets: UIEdgeInsets) -> UIView {
        
        return self.stackView.addArrangedInsetSubview(
            view,
            insets: insets
        )
                
    }
    
    @discardableResult
    public func addArrangedSpaceSubview(size: CGFloat) -> UIView {
        
        return self.stackView
            .addArrangedSpaceSubview(size: size)
        
    }

    public func insertArrangedSubview(_ view: UIView,
                                      at index: Int) {
        
        self.stackView.insertArrangedSubview(
            view,
            at: index
        )
        
    }
    
    @discardableResult
    public func insertArrangedWrappedSubview(_ view: UIView,
                                             at index: Int,
                                             insets: UIEdgeInsets) -> UIView {
        
        return self.stackView.insertArrangedInsetSubview(
            view,
            at: index,
            insets: insets
        )
        
    }
    
    @discardableResult
    public func insertArrangedSpaceSubview(size: CGFloat,
                                           at index: Int) -> UIView {
        
        return self.stackView.insertArrangedSpaceSubview(
            size: size,
            at: index
        )
        
    }

    public func removeArrangedSubview(_ view: UIView) {
        
        self.stackView
            .removeArrangedSubview(view)
        
    }
    
    public func customSpacing(after arrangedSubview: UIView) -> CGFloat {
        
        return self.stackView
            .customSpacing(after: arrangedSubview)
        
    }

    public func setCustomSpacing(_ spacing: CGFloat,
                                 after arrangedSubview: UIView) {
        
        self.stackView.setCustomSpacing(
            spacing,
            after: arrangedSubview
        )
        
    }
    
    // MARK: Private
    
    private func setup(axis: NSLayoutConstraint.Axis) {
                
        self.clipsToBounds = true
        
        self.stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints { make in
            self.stackViewTopConstraint = make.top.equalTo(0).constraint
            self.stackViewLeftConstraint = make.left.equalTo(0).constraint
            self.stackViewBottomConstraint = make.bottom.equalTo(0).constraint
            self.stackViewRightConstraint = make.right.equalTo(0).constraint

        }
        
        self.axis = axis
        
    }
    
    private func updateStackViewAxis(_ axis: NSLayoutConstraint.Axis, edgeInsets: UIEdgeInsets) {
        
        self.axisConstraint?.isActive = false
        
        switch axis {
        case .vertical:
            
            self.axisConstraint = self.stackView.widthAnchor.constraint(
                equalTo: self.widthAnchor,
                constant: -(edgeInsets.left + edgeInsets.right)
            )
            
        case .horizontal:
            
            self.axisConstraint = self.stackView.heightAnchor.constraint(
                equalTo: self.heightAnchor,
                constant: -(edgeInsets.top + edgeInsets.bottom)
            )
        
        default: break
        }
        
        self.stackViewTopConstraint.update(offset: edgeInsets.top)
        self.stackViewLeftConstraint.update(offset: edgeInsets.left)
        self.stackViewBottomConstraint.update(offset: -edgeInsets.bottom)
        self.stackViewRightConstraint.update(offset: -edgeInsets.right)
        
        self.axisConstraint?.isActive = true
        self.stackView.axis = axis

    }
    
}
