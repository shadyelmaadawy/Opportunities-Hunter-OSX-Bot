//
//  BotMessageModel.swift
//  Opportunities Hunter
//
//  Created by Shady El-Maadawy on 29/12/2023.
//

import OhKit

// Default logger model for Orca-Bot Module
final class BotMessageModel: LoggerMessage {
    
    // MARK: - Properties
    
    let messages: [String]
    let messageLevel: OhKit.LoggerMessageLevels
    let messageType: OhKit.LoggerMessageTypes
    
    // MARK: - Initialization
    
    init(
        messages: [String],
        messageLevel: OhKit.LoggerMessageLevels,
        messageType: OhKit.LoggerMessageTypes = .notify) {
            self.messages = messages
            self.messageLevel = messageLevel
            self.messageType = messageType
    }
    
    convenience init(message: String, messageLevel: OhKit.LoggerMessageLevels, messageType: OhKit.LoggerMessageTypes = .notify) {
        self.init(messages: [message], messageLevel: messageLevel, messageType: messageType)
    }
}

