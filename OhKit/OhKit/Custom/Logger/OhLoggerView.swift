//
//  OhLoggerView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 29/12/2023.
//

import AppKit
import Combine
import Utilities

public class OhLoggerView: OhScrollableTextView, TextViewEvents {
    
    // MARK: - Properties
    
    private lazy var subscriptions: Set<AnyCancellable> = {
        return Set<AnyCancellable>()
    }()
    
    // MARK: - Concurrency Properties
    
    internal let queueLock = NSLock()
    internal let logSemaphore = DispatchSemaphore(value: 0)
    
    // MARK: - Logger Data
    
    internal var logMessagesQueue = Queue<LoggerMessage>()

    // MARK: - Events
    
    public let userEnterEvent = PassthroughSubject<String, Never>()
    public let logMessageEvent = PassthroughSubject<LoggerMessage, Never>()

    // MARK: - Initialization
    
    public override init() {
        super.init()
        self.configure()
    }
    
    deinit {
        subscriptions.forEach({$0.cancel()})
        subscriptions.removeAll()
    }
   
}

// MARK: - Configure

private extension OhLoggerView {
    
    func configure() {
        
        self.startListenForEvents()
        self.setEventsStreamDestination(self)
        
        self.bindSubjects()
    }
}

// MARK: - Data Binding

private extension OhLoggerView {
    
    /// Log Events to logger view, it is thread safe
    func bindSubjects() {
        
        logMessageEvent
            .receive(
                on: DispatchQueue.main
            )
            .sink { [unowned self] eventValue in
                
                self.queueLock.withLock {
                    self.logMessagesQueue.enqueue(eventValue)
                }
                
                self.queueLock.unlock()
                self.logSemaphore.signal()
            }
            .store(in: &subscriptions)
    }
    
}
