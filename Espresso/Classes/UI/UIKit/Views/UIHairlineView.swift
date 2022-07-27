//
//  UIHairlineView.swift
//  Espresso
//
//  Created by Mitch Treece on 7/27/22.
//

import UIKit
import SnapKit

public class UIHairlineView: UIBaseView {
    
    public enum HeightMode {
        
        case constant
        case native
        
        var value: CGFloat {
            
            switch self {
            case .constant: return 1
            case .native: return (1 / UIScreen.main.nativeScale)
            }
            
        }
        
    }
    
    public var height: HeightMode = .constant {
        didSet {
            updateHeight()
        }
    }
    
    private var heightConstraint: Constraint!
    
    public convenience init(height: HeightMode = .constant) {
        
        self.init(frame: .zero)
        self.height = height
        
    }
    
    public override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupSubviews()
        
    }
    
    public required init?(coder: NSCoder) {
        
        super.init(coder: coder)
        setupSubviews()
        
    }
    
    // MARK: Private
    
    private func setupSubviews() {

        self.backgroundColor = .lightGray

        self.snp.makeConstraints { make in
            self.heightConstraint = make.height.greaterThanOrEqualTo(self.height.value).constraint
        }

    }
    
    private func updateHeight() {

        self.heightConstraint
            .update(offset: self.height.value)
        
    }
    
}
