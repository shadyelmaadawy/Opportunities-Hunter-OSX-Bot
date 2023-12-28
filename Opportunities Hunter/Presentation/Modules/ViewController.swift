//
//  ViewController.swift
//  Opportunities Hunter
//
//  Created by Shady El-Maadawy on 13/12/2023.
//

import OhKit

final class ViewController: OhViewController {

    private lazy var logTextView: OhLogTextView = {
        let baseTextField = OhLogTextView.init()
        return baseTextField
    }()
    
  override func viewDidLoad() {
      super.viewDidLoad()
      
      let isFirstLaunch = false
      logTextView.userEnterEvent
          .sink { [unowned self] value in
              print(value)
              logTextView.logEvents(event: .usageExplanation(firstPart: true))
              logTextView.logEvents(event: .usageExplanation(firstPart: false))
          }.store(in: &self.subscriptions)
      
      logTextView.logEvents(event: .welcomeMessage(firstLaunch: isFirstLaunch))

      if(isFirstLaunch) {
          logTextView.logEvents(event: .queryRequired)
//          logTextView.logEvents(event: .usageExplanation(firstPart: true))
//          logTextView.logEvents(event: .usageExplanation(firstPart: false))
      } else {
          logTextView.logEvents(event: .reinitiateModuleQuestion)
      }
      logTextView.logEvents(event: .listeningStarted)
      logTextView.logEvents(event: .launchDetectingOperation)
//      
//      
//      for _ in 0...20 {
//          logTextView.logOpportunitiesDetection("3 new opportunities detected match your query", source: .wuzzuf)
//          logTextView.logEvents(event: .pushOpportunityNotification(queryDetected: "IOS"))
//          logTextView.logOpportunitiesDetection("60 new opportunities detected match your query", source: .linkedin)
//          logTextView.logEvents(event: .pushOpportunityNotification(queryDetected: "IOS"))
//          logTextView.logEvents(event: .launchDetectingOperation)
//
//      }
      
      self.view.addSubview(logTextView)
        self.activeLayoutConstraints([
            logTextView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            logTextView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            logTextView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            logTextView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
        ])
        
    }

}
