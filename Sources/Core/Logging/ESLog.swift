//
//  ESLog.swift
//  Espresso
//
//  Created by Mitch Treece on 2/19/24.
//

import Lumberjack
import Pulse

public func ESLog(_ message: String,
                  loggerId: String? = nil,
                  level: LogLevel,
                  symbol: String?,
                  category: String?,
                  metadata: Message.Metadata?,
                  file: String = #fileID,
                  function: String = #function,
                  line: UInt = #line) {
    
    var logger: Logger = .default
        
    if let loggerId {
        
        logger = Logger
            .with(id: loggerId) ?? .default
        
    }

    let msg = logger.log(
        message,
        level: level,
        symbol: symbol,
        category: category,
        metadata: metadata,
        file: file,
        function: function,
        line: line
    )
    
    ESPulse(msg)
    
}

public func ESTrace(_ message: String,
                    loggerId: String? = nil,
                    symbol: String? = nil,
                    category: String? = nil,
                    metadata: Message.Metadata? = nil,
                    file: String = #fileID,
                    function: String = #function,
                    line: UInt = #line) {
    
    ESLog(
        message,
        level: .trace,
        symbol: symbol,
        category: category,
        metadata: metadata,
        file: file,
        function: function,
        line: line
    )
    
}

public func ESDebug(_ message: String,
                    loggerId: String? = nil,
                    symbol: String? = nil,
                    category: String? = nil,
                    metadata: Message.Metadata? = nil,
                    file: String = #fileID,
                    function: String = #function,
                    line: UInt = #line) {
    
    ESLog(
        message,
        level: .debug,
        symbol: symbol,
        category: category,
        metadata: metadata,
        file: file,
        function: function,
        line: line
    )
    
}

public func ESInfo(_ message: String,
                   loggerId: String? = nil,
                   symbol: String? = nil,
                   category: String? = nil,
                   metadata: Message.Metadata? = nil,
                   file: String = #fileID,
                   function: String = #function,
                   line: UInt = #line) {
    
    ESLog(
        message,
        level: .info,
        symbol: symbol,
        category: category,
        metadata: metadata,
        file: file,
        function: function,
        line: line
    )
    
}

public func ESNotice(_ message: String,
                     loggerId: String? = nil,
                    symbol: String? = nil,
                    category: String? = nil,
                    metadata: Message.Metadata? = nil,
                    file: String = #fileID,
                    function: String = #function,
                    line: UInt = #line) {
    
    ESLog(
        message,
        level: .notice,
        symbol: symbol,
        category: category,
        metadata: metadata,
        file: file,
        function: function,
        line: line
    )
    
}

public func ESWarn(_ message: String,
                   loggerId: String? = nil,
                   symbol: String? = nil,
                   category: String? = nil,
                   metadata: Message.Metadata? = nil,
                   file: String = #fileID,
                   function: String = #function,
                   line: UInt = #line) {
    
    ESLog(
        message,
        level: .warning,
        symbol: symbol,
        category: category,
        metadata: metadata,
        file: file,
        function: function,
        line: line
    )
    
}

public func ESError(_ message: String,
                    loggerId: String? = nil,
                    symbol: String? = nil,
                    category: String? = nil,
                    metadata: Message.Metadata? = nil,
                    file: String = #fileID,
                    function: String = #function,
                    line: UInt = #line) {
    
    ESLog(
        message,
        level: .error,
        symbol: symbol,
        category: category,
        metadata: metadata,
        file: file,
        function: function,
        line: line
    )
    
}

public func ESFatal(_ message: String,
                    loggerId: String? = nil,
                    symbol: String? = nil,
                    category: String? = nil,
                    metadata: Message.Metadata? = nil,
                    file: String = #fileID,
                    function: String = #function,
                    line: UInt = #line) -> Never {
    
    ESLog(
        message,
        level: .fatal,
        symbol: symbol,
        category: category,
        metadata: metadata,
        file: file,
        function: function,
        line: line
    )
    
    fatalError(message)
        
}

fileprivate func ESPulse(_ message: Message) {
            
    var level: LoggerStore.Level
    
    switch message.level {
    case .trace: level = .trace
    case .debug: level = .debug
    case .info: level = .info
    case .notice: level = .notice
    case .warning: level = .warning
    case .error: level = .error
    case .fatal: level = .critical
    }
    
    var _metadata: [String: LoggerStore.MetadataValue]?
    
    if let metadata = message.metadata {
        
        _metadata = [String: LoggerStore.MetadataValue]()
        
        metadata.forEach { key, value in
            
            if let str = value as? String {
                _metadata![key] = .string(str)
            }
            else {
                _metadata![key] = .stringConvertible(value)
            }
            
        }
        
    }
    
    let _message = "\(message.symbol) \(message.body(formatted: false))"
    
    LoggerStore.shared.storeMessage(
        createdAt: message.date,
        label: message.category ?? "Uncategorized",
        level: level,
        message: _message,
        metadata: _metadata,
        file: message.file(format: .raw),
        function: message.function(format: .raw),
        line: message.line
    )
    
}
