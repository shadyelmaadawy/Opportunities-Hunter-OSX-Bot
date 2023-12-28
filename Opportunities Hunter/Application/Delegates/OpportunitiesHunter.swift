//
//  OpportunitiesHunter.swift
//  Opportunities Hunter
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

@main
struct OpportunitiesHunter {
    
    // MARK: - Properties

    private static let appDelegates: AppDelegate = {
        return AppDelegate.init()
    }()
    
    private static let ohApp: NSApplication = {
        let baseApp = NSApplication.shared
        baseApp.setActivationPolicy(.regular)
       return baseApp
    }()
    
    // MARK: - Entry-Point

    static func main() {
        
        ohApp.delegate = self.appDelegates
        
        if #available(macOS 14.0, *) {
            ohApp.activate()
        } else {
            ohApp.activate(ignoringOtherApps: true)
        }
        ohApp.run()
        
    }

}
