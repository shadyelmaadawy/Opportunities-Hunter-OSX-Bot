//
//  OhLogTextView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 18/12/2023.
//

import AppKit
import Combine

extension NSObject {
    
    func sleep(for seconds: Double) {
        Thread.sleep(forTimeInterval: seconds)
    }
    
}

public class OhLogTextView: OhScrollableTextView, TextViewDelegates {
    
    // MARK: - Properties
    
    private let queueLock = NSLock()
    private let threadSemaphore = DispatchSemaphore(value: 0)

    
    private var logEventsQueue = Queue<BotEvents>()
    private var userInputsCharacters = Queue<Character>()
    
    public let userEnterEvent = PassthroughSubject<String, Never>()

    // MARK: - Enums
    
    public enum OpportunitiesSources: String {
        case wuzzuf = "Wuzzuf"
        case linkedin = "Linkedin"
    }
    
    public enum BotEvents: Equatable {
        
        case welcomeMessage(firstLaunch: Bool)
        case queryRequired
        case usageExplanation(firstPart: Bool)
        case reinitiateModuleQuestion
        case listeningStarted
        case launchDetectingOperation
        case pushOpportunityNotification(queryDetected: String)
        case anErrorOccurred(error: Error)
        
        var description: String {
            switch(self) {
                
            case .welcomeMessage(let firstLaunch):
                if(firstLaunch) {
                    return "Welcome to Orca Hunter Bot, Briefly, It uses machine learning to give you most out of AI! ; )"
                } else {
                    return "Welcome Back to Orca Hunter Bot, this Bot will help you to catch new opportunities automatically ; )"
                }
            case .queryRequired:
                return "Kindly provide some words that match your dream opportunity with a splitter (,) as an example: IOS, Swift, Objective-C"
            case .usageExplanation(let firstPart):
                if(firstPart) {
                    return "I don't know everything, even the person who developed me doesn't know everything, but you will train me."
                } else {
                    return "I will fetch some opportunities depending on your input, and I will ask you if it's suitable for you or not, Okay?"
                }
            case .reinitiateModuleQuestion:
                return "Do You want to use the previous module you had trained or let's train a new one?!"
            case .listeningStarted:
                return "Listening started, you will be notified of any new opportunity."
            case .launchDetectingOperation:
                return "An Interval of search has come, detection operation will be started shortly, good luck!"
            case .pushOpportunityNotification(let queryDetected):
                return "I found something looks interesting to you, query detected: \(queryDetected)"
            case .anErrorOccurred(let error):
                return "An error occurred, reason: \(error.localizedDescription)"
            }
            
        }
        
        var color: NSColor {
            
            switch(self) {
                case .welcomeMessage:
                    return NSColor.systemGray
                case .queryRequired:
                    return NSColor.systemBrown
                case .usageExplanation(let firstPart):
                     return firstPart ? NSColor.systemIndigo : NSColor.systemBlue
                case .reinitiateModuleQuestion:
                    return NSColor.systemGreen
                case .listeningStarted:
                    return NSColor.systemOrange
                case .launchDetectingOperation:
                    return NSColor.systemPink
                case .pushOpportunityNotification(_):
                    return NSColor.white
                case .anErrorOccurred(_):
                    return NSColor.systemRed
                
            }
        }
        
        public static func == (lhs: OhLogTextView.BotEvents, rhs: OhLogTextView.BotEvents) -> Bool {
            return lhs.description == rhs.description

        }
    }
    
    
    public override init() {
        super.init()
        self.setDelegates(self)
        
        DispatchQueue.global(qos: .userInteractive).asyncAfter(deadline: .now() + 0.5) {
            repeat { self.repeatBlock() } while(true)
        }
    }
}

// MARK: - Operations

public extension OhLogTextView {
    
    
    func repeatBlock() {
        
        threadSemaphore.wait()
        
        self.queueLock.lock()
            let botEvent = self.logEventsQueue.dequeue()
            guard let botEvent = botEvent else {
                self.queueLock.unlock()
                return
        }
        self.queueLock.unlock()
  
        let botLog = NSAttributedString.buildArsenalLog()
        
        for(index, value) in botLog.messages.enumerated() {
            value.forEach { messageValue in
                self.appendChar(botLog.color[index], messageValue)
            }
            self.sleep(for: 0.002)
        }
        self.appendSuffix(newLine: false)
        
        botEvent.description.forEach { value in
            self.appendChar(botEvent.color, value)
            self.sleep(for: 0.002)
        }
        self.appendSuffix(newLine: true)

        
    }
    
    func userInputs(_ input: String) {
        userInputsCharacters.enqueue(Character(input))
    }

    func userPressEnter() {
        
        guard userInputsCharacters.isEmpty() == false else {
            return
        }
        var userInput = String.init()
        
        repeat {
            guard let character = userInputsCharacters.dequeue() else {
                break
            }
            userInput.append(character)
        } while userInputsCharacters.isEmpty() == false
        
        userEnterEvent.send(userInput)
    }
    
    func userPressBackspace() {
        
    }

    func logEvents(event: BotEvents) {
        
        queueLock.lock()
            logEventsQueue.enqueue(event)
        queueLock.unlock()
        threadSemaphore.signal()

    }
    
    func logOpportunitiesDetection(_ data: String, source: OpportunitiesSources) {
      
        queueLock.lock()
        defer { queueLock.unlock() }
        
        let logBuffer = NSMutableAttributedString.buildAttributedBuffer(
            messagesBuffer:
                data,
                ", Source: \(source.rawValue) RESTFul API",
            colors:
                .systemPurple,
                .systemTeal
        )
        
        self.textView.textStorage?.append(logBuffer)
    }

}
