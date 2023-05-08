//
//  ProcessInfo+Espresso.swift
//  Espresso
//
//  Created by Mitch Treece on 5/7/23.
//

import Foundation

public extension ProcessInfo /* Debug */ {
    
    /// Flag indicating if the process is currently attached to a debug session.
    ///
    /// This will likely (but not always) be an Xcode debug session.
    var isDebugSessionAttached: Bool {
                    
        var isAttached: Bool = false
        
        var name: [Int32] = [CTL_KERN, KERN_PROC, KERN_PROC_PID, getpid()]
        var info: kinfo_proc = kinfo_proc()
        var infoSize = MemoryLayout<kinfo_proc>.size
        
        let success = name.withUnsafeMutableBytes { ptr -> Bool in
            
            guard let address = ptr
                .bindMemory(to: Int32.self)
                .baseAddress else { return false }
            
            return (sysctl(address, 4, &info, &infoSize, nil, 0) != -1)
            
        }
        
        if !success {
            isAttached = false
        }
        
        if !isAttached && (info.kp_proc.p_flag & P_TRACED) != 0 {
            isAttached = true
        }

        return isAttached
        
    }
    
}
