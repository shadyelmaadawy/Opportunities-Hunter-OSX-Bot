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
    
    
    // MARK: - print(MemoryLayout<Int32>.size)
    // MARK: - علشان تعرفوا تغلطوا فيا تاني انا وعيان
  override func viewDidLoad() {
      super.viewDidLoad()
      
      let isFirstLaunch = true
      logTextView.userEnterEvent
          .sink { [unowned self] value in
              print("enter pressed: \(value)")
              logTextView.logEvents(event: .usageExplanation(firstPart: true))
              logTextView.logEvents(event: .usageExplanation(firstPart: false))
              logTextView.logEvents(event: .listeningStarted)
              logTextView.logEvents(event: .launchDetectingOperation)

          }.store(in: &self.subscriptions)
      
      logTextView.logEvents(event: .welcomeMessage(firstLaunch: isFirstLaunch))

      if(isFirstLaunch) {
          logTextView.logEvents(event: .queryRequired)
//          logTextView.logEvents(event: .usageExplanation(firstPart: true))
//          logTextView.logEvents(event: .usageExplanation(firstPart: false))
      } else {
          logTextView.logEvents(event: .reinitiateModuleQuestion)
      }
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
