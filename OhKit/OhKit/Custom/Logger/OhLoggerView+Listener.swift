//
//  OhLoggerView+Listener.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 29/12/2023.
//

import Foundation

internal extension OhLoggerView {
    
    func startListenForEvents() {
        DispatchQueue.global(qos: .userInteractive).async {
            repeat { self.logListener() } while(true)
        }
    }
    
    /// Function will listen to new events and log it
    func logListener() {
        
        self.logSemaphore.wait()
        defer { queueLock.unlock() }
        
        var loggerMessage: LoggerMessage? = nil
        queueLock.withLock {
            loggerMessage = self.logMessagesQueue.dequeue()
        }
        
        guard let loggerMessage = loggerMessage else {
            return
        }
        
        self.processMessage(loggerMessage)
    }
    

}
