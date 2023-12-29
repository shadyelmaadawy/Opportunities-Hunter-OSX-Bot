//
//  LoggerMessageProtocol.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 29/12/2023.
//

import AppKit

/// An enum to know message type, query will enable edit mode in logger
public enum LoggerMessageTypes {
    case query
    case notify
}

public enum LoggerMessageLevels {

    case normal
    case information
    case multipleInformation
    case alert
    case warning
    case question
    case error
    case logBuffer
    
    var messageColor: [NSColor] {
        
        switch(self) {
            case .normal:
                return [
                    NSColor.init(
                        red: 0.83,
                        green: 0.83,
                        blue: 0.83,
                        alpha: 1.00
                    )
                ]
            case .information:
                return [.systemBlue]
            case .multipleInformation:
                return [.systemBlue, .systemIndigo]
            case .alert:
                return [.systemOrange]
            case .warning:
                return [.systemPink]
            case .question:
                return [
                    NSColor.init(
                        red: 0.76,
                        green: 0.58,
                        blue: 0.05,
                        alpha: 1.00
                    )
                ]
            case .error:
                return [.systemRed]
            case .logBuffer:
                return [.systemGreen, .systemYellow]
        }
    }
}

/// Default Logger message protocol
public protocol LoggerMessage: AnyObject {
    var messages: [String] { get }
    var messageLevel: LoggerMessageLevels { get }
    var messageType: LoggerMessageTypes { get }
}
