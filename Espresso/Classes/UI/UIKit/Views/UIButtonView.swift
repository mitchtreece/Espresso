//
//  UIButtonView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit

public class UIButtonView: UIBaseView {

    public enum Style {

        case filled
        case outline

    }

    public var style: Style = .filled {
        didSet {
            updateStyle()
        }
    }

    public var color: UIColor = .systemBlue {
        didSet {
            updateStyle()
        }
    }
    
    public var isEnabled: Bool = true {
        didSet {
            updateStyle()
        }
    }
    
    public var title: String? = "Button" {
        didSet {
            updateTitleTextAndFont()
        }
    }
    
    public var titleFont: UIFont = .systemFont(ofSize: 16, weight: .bold) {
        didSet {
            updateTitleTextAndFont()
        }
    }
    
    public var action: (()->())?
    
    public var isAnimated: Bool = true
    
    public static let minimumHeight: CGFloat = 44
    
    private var buttonView: UIView!
    private var titleLabel: UILabel!
    
    public init(title: String?,
                style: Style = .filled,
                action: (()->())?) {
        
        self.title = title
        self.style = style
        self.action = action
        
        super.init(frame: .zero)
                
    }
            
    public convenience init() {
        
        self.init(
            title: nil,
            action: nil
        )
                
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func willSetup() {
        
        super.willSetup()

        self.backgroundColor = .clear
        
        self.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(Self.minimumHeight)
        }
        
        self.buttonView = UIView()
        self.buttonView.roundCorners(radius: 8)
        addSubview(self.buttonView)
        self.buttonView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.titleLabel = UILabel()
        self.titleLabel.text = self.title
        self.titleLabel.font = self.titleFont
        self.titleLabel.textAlignment = .center
        addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }

        addLongPressGesture { recognizer in

            recognizer.minimumPressDuration = 0.01

        } action: { [weak self] recognizer in

            guard let self = self,
                  self.isEnabled else { return }
            
            self.animateForTouchState(recognizer.state)

        }

        updateStyle()
        updateTitleTextAndFont()

    }
    
    // MARK: Private
    
    private func updateTitleTextAndFont() {
        
        self.titleLabel?.text = self.title
        self.titleLabel?.font = self.titleFont

    }
    
    private func updateStyle() {

        if self.isEnabled {

            switch self.style {
            case .filled:

                self.buttonView.backgroundColor = self.color
                self.buttonView.layer.borderWidth = 0
                self.titleLabel.textColor = .white

            case .outline:

                self.buttonView.backgroundColor = .clear
                self.buttonView.layer.borderColor = self.color.cgColor
                self.buttonView.layer.borderWidth = 2

                self.titleLabel.textColor = self.color

            }

        }
        else {

            switch self.style {
            case .filled:

                self.buttonView.backgroundColor = .systemGray5
                self.buttonView.layer.borderWidth = 0
                self.titleLabel.textColor = .systemGray2

            case .outline:

                self.buttonView.backgroundColor = .clear
                self.buttonView.layer.borderColor = UIColor.systemGray5.cgColor
                self.buttonView.layer.borderWidth = 2

                self.titleLabel.textColor = .systemGray2

            }

        }

    }

    private func animateForTouchState(_ state: UIGestureRecognizer.State) {
        
        let actions = { [weak self] in
            
            guard let self = self else { return }
            
            UITaptic(style: .selection)
                .play()

            self.action?()

            if self.isAnimated {
                
                UIAnimation(.spring(damping: 0.5, velocity: 1), duration: 0.5) {
                    self.transform = .identity
                }.start()
                
            }
            
        }
        
        guard self.isAnimated else {
            
            switch state {
            case .ended, .cancelled, .failed:
                
                actions()
                
            default: break
            }
            
            return
            
        }

        switch state {
        case .began:

            UIAnimation(.material(.standard), duration: 0.1) {
                self.transform = .init(scaleX: 0.97, y: 0.97)
            }.start()

        case .ended, .cancelled, .failed:

            actions()

        default: break
        }

    }

}
