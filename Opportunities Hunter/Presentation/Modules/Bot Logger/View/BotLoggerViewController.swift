//
//  BotLoggerViewController.swift
//  Opportunities Hunter
//
//  Created by Shady El-Maadawy on 29/12/2023.
//

import OhKit

final class BotLoggerViewController: OhViewController {
    
    // MARK: - Enums
    
    enum OpportunitiesSources: String {
        case wuzzuf = "Wuzzuf"
        case linkedin = "Linkedin"
    }
    
    enum BotEvents {

        case welcomeMessage(initializationMessage: Bool)
        case usageExplanation
        case reinitiateModuleQuestion
        case queryRequired
        case listeningStarted
        case launchDetectingOperation
        case pushOpportunityNotification(detectedOpportunity: String, opportunitySource: OpportunitiesSources)
        case anErrorOccurred(botError: Error)
        case incorrectInputs

    }

    // MARK: - UI Components
    
    private lazy var loggerView: OhLoggerView = {
        let baseLogView = OhLoggerView.init()
        return baseLogView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutSubViews()
        
        self.loggerView.userEnterEvent
            .sink { [unowned self] value in
                print(value)
                if(value.count >= 10) {
                    self.printMessage(.listeningStarted)
                    self.printMessage(.launchDetectingOperation)
                    for i in 0...99 {
                        self.printMessage(.pushOpportunityNotification(
                            detectedOpportunity: "Senior Software-Engineer @ APPLE \(i)",
                            opportunitySource: Bool.random() ? .linkedin : .wuzzuf
                        ))
                    }
                }
                else {
                    self.printMessage(.incorrectInputs)
                }
            }
        .store(in: &self.subscriptions)
        self.printMessage(.welcomeMessage(initializationMessage: true))
        self.printMessage(.welcomeMessage(initializationMessage: false))
        self.printMessage(.usageExplanation)
        self.printMessage(.queryRequired)
    }

    
    // MARK: - This part will be refactored later
    func printMessage(_ botEvent: BotEvents) {
        
        var botMessage: BotMessageModel
        
        switch(botEvent) {
            
            case .welcomeMessage(let initializationMessage):
            
                botMessage = BotMessageModel(
                    message:
                        initializationMessage == true ?
                        "Welcome to Orca Hunter Bot, Briefly, It uses machine learning to give you most out of AI! ; )" :
                        "Welcome Back to Orca Hunter Bot, this Bot will help you to catch new opportunities automatically ; )",
                    messageLevel: .normal
                )
            case .usageExplanation:

                botMessage = BotMessageModel(
                    messages: [
                        "I don't know everything, even the person who developed me doesn't know everything, but you will train me.",
                        "I will fetch some opportunities depending on your input, and I will ask you if it's suitable for you or not, Okay?"
                    ],
                    messageLevel: .multipleInformation
                )
            
            case .reinitiateModuleQuestion:
        
                botMessage = BotMessageModel(
                    message: "Do You want to use the previous module you had trained or let's train a new one?, answer with (y)es or (n)o",
                    messageLevel: .question,
                    messageType: .query
                )

            case .queryRequired:
            
                botMessage = BotMessageModel(
                    message: "Kindly provide some words that match your dream opportunity with a splitter (,) as an example: IOS, Swift, Objective-C",
                    messageLevel: .question,
                    messageType: .query
                )
            
            case .listeningStarted:
            
                botMessage = BotMessageModel(
                    message: "Listening started, you will be notified of any new opportunity.",
                    messageLevel: .alert
                )
            
            case .launchDetectingOperation:
            
                botMessage = BotMessageModel(
                    message: "An Interval of search has come, detection operation will be started shortly, good luck!",
                    messageLevel: .information
                )
            
            case .pushOpportunityNotification(let detectedOpportunity, let opportunitySource):
            
                botMessage = BotMessageModel(
                    message: "I found something looks interesting to you, opportunity detected: \(detectedOpportunity), source: \(opportunitySource.rawValue)",
                    messageLevel: .warning
                )
            
            case .anErrorOccurred(let botError):
            
                botMessage = BotMessageModel(
                    message: "An error occurred, reason: \(botError.localizedDescription)",
                    messageLevel: .error
                )
            
            case .incorrectInputs:
            
                botMessage = BotMessageModel(
                    message: "Required inputs is incorrect, kindly answer with (y)es or (n)o",
                    messageLevel: .error,
                    messageType: .query
                )
        }
        
        self.loggerView.logMessageEvent.send(botMessage)
        
    }
}

// MARK: - Layout SubViews

private extension BotLoggerViewController {
    
    func layoutSubViews() {
        layoutLoggerView()
    }
    
    func layoutLoggerView() {
        
        self.view.addSubview(loggerView)
        
        let loggerViewConstraints = [
            loggerView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            loggerView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            loggerView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            loggerView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),

        ]
        self.activeLayoutConstraints(loggerViewConstraints)

    }
    
}
