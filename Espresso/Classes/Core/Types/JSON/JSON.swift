//
//  JSON.swift
//  Espresso
//
//  Created by Mitch Treece on 1/11/23.
//

import Foundation

/// A json object type representation.
public typealias JSON = [String: Any]

public extension JSON /* Print */ {
    
    /// Pretty prints the json object to the console.
    func prettyPrint() {
        
        guard let data = asJsonData(options: [.prettyPrinted]),
              let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else {
            
            debugPrint(self)
            return
            
        }
        
        debugPrint(string)
        
    }
    
}
