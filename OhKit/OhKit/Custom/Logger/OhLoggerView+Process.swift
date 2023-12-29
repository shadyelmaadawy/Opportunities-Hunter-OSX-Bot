//
//  OhLoggerView+Process.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 29/12/2023.
//

import Foundation
import AppKit

internal extension OhLoggerView {
    
    /// Process log message from the queue
    /// - Parameter logMessage: logger message that will be printed
    func processMessage(_ logMessage: LoggerMessage) {
        
        self.logMessage(logMessage)

        // If message type is query, let's enable textView to accept user inputs
        if(logMessage.messageType == .query) {

            self.logDefaultMessage()
            self.setEditableValue(true)

        }
    }
    
    /// Function will take the message and print it
    /// - Parameter logMessage: logger message that will be printed
    private func logMessage(_ message: LoggerMessage) {
        
        for(index, value) in message.messages.enumerated() {
            logDefaultMessage()
            
            let messageColorIdx = (
                message.messageLevel == .logBuffer ||
                message.messageLevel == .multipleInformation
                && index == 1 )
            ? index : 0
            self.logValue(value, message.messageLevel.messageColor[messageColorIdx])
        }

    }
    
    /// Log arsenal message to bot
    private func logDefaultMessage() {
        
        self.appendSuffix(.newLine)
        let defaultMessage = DefaultLoggerMessage.init()
        logLoggerMessage(defaultMessage)

    }
    
    /// Loop through logger messages and print it
    /// - Parameter loggerMessage: message that will be printed
    private func logLoggerMessage(_ loggerMessage: LoggerMessage) {
        
        for(index, value) in loggerMessage.messages.enumerated() {
            self.logValue(value, loggerMessage.messageLevel.messageColor[index])
        }

    }
    
    /// loop through message value and print it char by char with delay
    /// - Parameters:
    ///   - valueBuffer: message
    ///   - valueColor: message color
    private func logValue(_ valueBuffer: String, _ valueColor: NSColor) {
        
        valueBuffer.forEach { valueChar in
            
            let coloredMessage = NSAttributedString.buildAttributedBuffer(
                messagesBuffer: String(valueChar),
                colors: valueColor
            )
            self.appendMessage(coloredMessage)
            self.sleep(for: 0.05)
            
        }

    }
    
}
