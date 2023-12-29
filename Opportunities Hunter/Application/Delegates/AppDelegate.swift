//
//  AppDelegate.swift
//  Opportunities Hunter
//
//  Created by Shady El-Maadawy on 13/12/2023.
//

import Cocoa
import OhKit

class AppDelegate: NSObject, NSApplicationDelegate {

    private var windowController: OhWindowController?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application

        windowController = OhWindowController.init()
        windowController?.contentViewController = BotLoggerViewController.init()
        windowController?.showWindow(self)

    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }

    func applicationSupportsSecureRestorableState(_ app: NSApplication) -> Bool {
        return true
    }


}
