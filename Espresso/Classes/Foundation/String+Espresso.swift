//
//  String+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 12/15/17.
//

import Foundation

// MARK: Height

public extension String {
    
    func height(forWidth width: CGFloat, attributes: [NSAttributedStringKey: Any]?) -> CGFloat {
        
        let size = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        return (self as NSString).boundingRect(with: size,
                                                    options: [.usesLineFragmentOrigin],
                                                    attributes: attributes,
                                                    context: nil).size.height
        
    }
    
    func height(forWidth width: CGFloat, font: UIFont) -> CGFloat {
        return height(forWidth: width, attributes: [.font: font])
    }
    
}
