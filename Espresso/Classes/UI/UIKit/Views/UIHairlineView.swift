//
//  UIHairlineView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit
import SnapKit

public class UIHairlineView: UIBaseView {
    
    public enum Height {
        
        case constant
        case native
        
        var value: CGFloat {
            
            switch self {
            case .constant: return 1
            case .native: return (1 / UIScreen.main.nativeScale)
            }
            
        }
        
    }
    
    public var height: Height = .constant {
        didSet {
            updateHeight()
        }
    }
    
    private var heightConstraint: Constraint!
    
    public init(height: Height = .constant) {
        
        self.height = height
        super.init(frame: .zero)
        
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    open override func willSetup() {
        
        super.willSetup()

        self.backgroundColor = .lightGray

        self.snp.makeConstraints { make in
            self.heightConstraint = make.height.greaterThanOrEqualTo(self.height.value).constraint
        }

    }
    
    // MARK: Private
    
    private func updateHeight() {

        self.heightConstraint
            .update(offset: self.height.value)
        
    }
    
}
