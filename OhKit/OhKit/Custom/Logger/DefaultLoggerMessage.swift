//
//  DefaultLoggerMessage.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 29/12/2023.
//

import AppKit

internal final class DefaultLoggerMessage: LoggerMessage {
    
    // MARK: - Properties
    
    let messages: [String]
    
    var messageType: LoggerMessageTypes {
        return .notify
    }
    var messageLevel: LoggerMessageLevels {
        return .logBuffer
    }
    

    // MARK: - Initialization
    
    init() {
        
        self.messages =  [
            Date.getCurrentDate(),
            " shadudiix arsenal > ",
        ]
    }
}
