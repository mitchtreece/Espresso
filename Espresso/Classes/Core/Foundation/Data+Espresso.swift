//
//  Data+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 3/11/20.
//

import Foundation

public extension Data /* Random */ {
    
    /// Initializes data with random bytes of a given length.
    /// - Parameter length: The random data length.
    init?(randomWithLength length: Int) {
        
        guard length > 0 else { return nil }
        
        var bytes = [UInt8](
            repeating: 0,
            count: length
        )
        
        let result = SecRandomCopyBytes(
            kSecRandomDefault,
            bytes.count,
            &bytes
        )
        
        guard result == errSecSuccess else { return nil }
        self = Data(bytes)
        
    }
    
}
