//
//  UITextInputView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit

// TODO: Look at Wing TextFieldView & DropdownTextFieldView

public class UITextInputView: UIBaseView {
    
    public enum Style {
        
        case email
        case newPassword
        case password
        case fullName
        case firstName
        case lastName
        case phone
        case age
        case postalCode
        
    }
    
    public private(set) var contentView: UIView!
    public private(set) var leftAccessoryView: UIZeroSizeView!
    public private(set) var rightAccessoryView: UIZeroSizeView!
    
    private var fieldContentView: UIView!
    private var titleLabel: UILabel!
    private var textField: UITextField!
    private var hairlineView: UIHairlineView!
    
    private let smallTitleFont: UIFont = .preferredFont(forTextStyle: .title3)
    private let largeTitleFont: UIFont = .preferredFont(forTextStyle: .title2)
    private let textFont: UIFont = .preferredFont(forTextStyle: .body)
    
    private let smallTitleColor: UIColor = .black
    private let largeTitleColor: UIColor = .black
    private let textColor: UIColor = .black
    private let placeholderColor: UIColor = .systemGray
    
    public var title: String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    public var placeholder: String? {
        get {
            return self.textField.placeholder
        }
        set {
            
            self.textField.placeholder = newValue
            self.textField.attributedPlaceholder = NSAttributedString(
                string: newValue ?? "",
                attributes: [
                    .font: self.textFont,
                    .foregroundColor: self.placeholderColor
                ])
            
        }
    }
    
    public var text: String? {
        get {
            return self.textField.text
        }
        set {
            
            self.textField.text = newValue
            
            layout(
                editing: self.isEditing,
                animated: true
            )
            
//            self._textPublisher.send(newValue)
            
        }
    }
    
    public var contentType: UITextContentType? {
        get {
            return self.textField.textContentType
        }
        set {
            self.textField.textContentType = newValue
        }
    }
    
    public var keyboardType: UIKeyboardType {
        get {
            return self.textField.keyboardType
        }
        set {
            self.textField.keyboardType = newValue
        }
    }
    
    public var keyboardAppearance: UIKeyboardAppearance {
        get {
            return self.textField.keyboardAppearance
        }
        set {
            self.textField.keyboardAppearance = newValue
        }
    }
    
    public var returnKeyType: UIReturnKeyType {
        get {
            return self.textField.returnKeyType
        }
        set {
            self.textField.returnKeyType = newValue
        }
    }
    
    public var autocapitalizationType: UITextAutocapitalizationType {
        get {
            return self.textField.autocapitalizationType
        }
        set {
            self.textField.autocapitalizationType = newValue
        }
    }
    
    public var autocorrectionType: UITextAutocorrectionType {
        get {
            return self.textField.autocorrectionType
        }
        set {
            self.textField.autocorrectionType = newValue
        }
    }
    
    public var isSecureTextEntry: Bool {
        get {
            return self.textField.isSecureTextEntry
        }
        set {
            self.textField.isSecureTextEntry = newValue
        }
    }
        
    public var isEnabled: Bool = true {
        didSet {
            updateEnabledAndEditable()
        }
    }
    
    public var isEditable: Bool = true {
        didSet {
            updateEnabledAndEditable()
        }
    }
    
    public var minHeight: CGFloat {
        return 50
    }
    
//    private var _textPublisher = GuaranteePassthroughSubject<String?>()
//    public var textPublisher: GuaranteePublisher<String?> {
//        return self._textPublisher.eraseToAnyPublisher()
//    }
//
//    private var _didBeginEditingPublisher = TriggerPublisher()
//    public var didBeginEditingPublisher: GuaranteePublisher<Void> {
//        return self._didBeginEditingPublisher.asPublisher()
//    }
//
//    private var _didEndEditingPublisher = TriggerPublisher()
//    public var didEndEditingPublisher: GuaranteePublisher<Void> {
//        return self._didEndEditingPublisher.asPublisher()
//    }
//
//    private var _didReturnPublisher = TriggerPublisher()
//    public var didReturnPublisher: GuaranteePublisher<Void> {
//        return self._didReturnPublisher.asPublisher()
//    }
//
//    public var hasTextPublisher: GuaranteePublisher<Bool> {
//
//        return self.textPublisher
//            .map { !($0 ?? "").isEmpty }
//            .eraseToAnyPublisher()
//
//    }
    
    private var isEditing: Bool = false
//    private var cancellableBag: CancellableBag!
    
    public override var isFirstResponder: Bool {
        return self.textField.isFirstResponder
    }
    
    @discardableResult
    public override func becomeFirstResponder() -> Bool {
        return self.textField.becomeFirstResponder()
    }
    
    @discardableResult
    public override func resignFirstResponder() -> Bool {
        return self.textField.resignFirstResponder()
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupBindings()
        
    }
    
    required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupBindings()
        
    }
    
    open override func setupView() {
        
        super.setupView()
        
        self.backgroundColor = .clear
        self.clipsToBounds = false
        
        self.contentView = UIView()
        self.contentView.backgroundColor = .clear
        self.contentView.clipsToBounds = false
        addSubview(self.contentView)
        self.contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.greaterThanOrEqualTo(self.minHeight)
        }
        
        self.leftAccessoryView = UIZeroSizeView()
        self.leftAccessoryView.backgroundColor = .clear
        self.leftAccessoryView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.leftAccessoryView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.contentView.addSubview(self.leftAccessoryView)
        self.leftAccessoryView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview()
        }

        self.rightAccessoryView = UIZeroSizeView()
        self.rightAccessoryView.backgroundColor = .clear
        self.rightAccessoryView.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        self.rightAccessoryView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        self.contentView.addSubview(self.rightAccessoryView)
        self.rightAccessoryView.snp.makeConstraints { make in
            make.top.right.bottom.equalToSuperview()
        }

        self.fieldContentView = UIView()
        self.fieldContentView.backgroundColor = .clear
        self.fieldContentView.clipsToBounds = false
        self.contentView.addSubview(self.fieldContentView)
        self.fieldContentView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalTo(self.leftAccessoryView.snp.right)
            make.right.equalTo(self.rightAccessoryView.snp.left)
        }
        
        self.titleLabel = UILabel()
        self.titleLabel.backgroundColor = .clear
        self.titleLabel.font = self.largeTitleFont
        self.titleLabel.textColor = self.largeTitleColor
        self.titleLabel.text = self.title
        self.fieldContentView.addSubview(self.titleLabel)
        
        self.textField = UITextField()
        self.textField.backgroundColor = .clear
        self.textField.font = self.textFont
        self.textField.textColor = self.textColor
        self.textField.tintColor = self.textColor
        self.fieldContentView.insertSubview(
            self.textField,
            belowSubview: self.titleLabel
        )
        
        self.hairlineView = UIHairlineView()
        self.contentView.addSubview(self.hairlineView)
        self.hairlineView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
        }
        
        addTapGesture { [weak self] _ in
            
            guard let self = self else { return }
                
            if !self.textField.isFirstResponder {
                self.textField.becomeFirstResponder()
            }
            
        }
        
        layout(
            editing: false,
            animated: false
        )
        
    }
    
    private func setupBindings() {
        
//        self.cancellableBag = CancellableBag()
//
//        self.textField
//            .eventPublisher(for: .editingChanged)
//            .sink { [weak self] in
//                self?._textPublisher.send(self?.textField.text)
//            }
//            .store(in: &self.cancellableBag)
//
//        self.textField
//            .eventPublisher(for: .editingDidBegin)
//            .sink { [weak self] in
//
//                self?.isEditing = true
//
//                self?.layout(
//                    editing: true,
//                    animated: true
//                )
//
//                self?._didBeginEditingPublisher.fire()
//
//            }
//            .store(in: &self.cancellableBag)
//
//        self.textField
//            .eventPublisher(for: .editingDidEnd)
//            .sink { [weak self] in
//
//                self?.isEditing = false
//
//                self?.layout(
//                    editing: false,
//                    animated: true
//                )
//
//                self?._didEndEditingPublisher.fire()
//
//            }
//            .store(in: &self.cancellableBag)
//
//        self.textField
//            .eventPublisher(for: .editingDidEndOnExit)
//            .sink { [weak self] in
//
//                self?.isEditing = false
//                self?._didReturnPublisher.fire()
//
//            }
//            .store(in: &self.cancellableBag)
        
    }
        
    public func style(_ style: Style) {
        
        var contentType: UITextContentType? = nil
        var autocorrectType: UITextAutocorrectionType = .default
        var autocapitalizationType: UITextAutocapitalizationType = .sentences
        var spellcheckType: UITextSpellCheckingType = .default
        var keyboardType: UIKeyboardType = .default
        var isSecureEntry: Bool = false
        
        switch style {
        case .email:
            
            contentType = .emailAddress
            autocorrectType = .no
            autocapitalizationType = .none
            spellcheckType = .no
            keyboardType = .emailAddress
            
        case .newPassword:
            
            contentType = .newPassword
            autocorrectType = .no
            autocapitalizationType = .none
            spellcheckType = .no
            isSecureEntry = true
            
        case .password:
            
            contentType = .password
            autocorrectType = .no
            autocapitalizationType = .none
            spellcheckType = .no
            isSecureEntry = true
            
        case .fullName:
            
            contentType = .name
            autocorrectType = .no
            autocapitalizationType = .words
            spellcheckType = .no
            
        case .firstName:
            
            contentType = .givenName
            autocorrectType = .no
            autocapitalizationType = .words
            spellcheckType = .no
            
        case .lastName:
            
            contentType = .familyName
            autocorrectType = .no
            autocapitalizationType = .words
            spellcheckType = .no
        
        case .phone:
            
            contentType = .telephoneNumber
            autocorrectType = .no
            autocapitalizationType = .none
            spellcheckType = .no
            keyboardType = .phonePad
                        
        case .age:
            
            autocorrectType = .no
            autocapitalizationType = .none
            spellcheckType = .no
            keyboardType = .numberPad
            
        case .postalCode:
            
            contentType = .postalCode
            autocorrectType = .no
            autocapitalizationType = .allCharacters
            spellcheckType = .no
            keyboardType = .numberPad
            
        }
        
        self.textField.textContentType = contentType
        self.textField.autocorrectionType = autocorrectType
        self.textField.autocapitalizationType = autocapitalizationType
        self.textField.spellCheckingType = spellcheckType
        self.textField.keyboardType = keyboardType
        self.textField.isSecureTextEntry = isSecureEntry
        
    }
    
    private func layout(editing: Bool,
                        animated: Bool) {
        
        let hasText = !(self.text?.isEmpty ?? true)
        let isExpandedLayout = (editing || hasText)
        
        let styleChanges = {

            self.titleLabel.font = isExpandedLayout ? self.smallTitleFont : self.largeTitleFont
            self.titleLabel.textColor = isExpandedLayout ? self.smallTitleColor: self.largeTitleColor
            
        }
        
        let constraintChanges = {
            
            self.titleLabel.snp.remakeConstraints { make in

                if isExpandedLayout {
                    make.left.top.right.equalToSuperview()
                }
                else {
                    make.edges.equalToSuperview()
                }

            }

            self.textField.snp.remakeConstraints { make in

                if isExpandedLayout {

                    make.top.equalTo(self.titleLabel.snp.bottom)
                    make.left.bottom.right.equalToSuperview()

                }
                else {
                    make.edges.equalToSuperview()
                }

            }
            
        }
        
        guard animated else {

            styleChanges()
            constraintChanges()
            return

        }

        constraintChanges()
        
        UIAnimation(.defaultSpring, duration: 0.2) {
            
            styleChanges()
            self.fieldContentView.layoutIfNeeded()
            
        }.start()

    }

    private func updateEnabledAndEditable() {
        
        if self.isEnabled {
            
            self.textField.textColor = self.textColor
            self.textField.isUserInteractionEnabled = self.isEditable

        }
        else {
            
            self.textField.textColor = .systemGray
            self.textField.isUserInteractionEnabled = false
                        
            if self.isFirstResponder {
                resignFirstResponder()
            }

        }
        
    }
    
}
