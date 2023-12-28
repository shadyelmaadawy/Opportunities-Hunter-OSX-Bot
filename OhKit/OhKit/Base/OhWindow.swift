//
//  OhWindow.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

public class OhWindow: NSWindow {

    // MARK: - Initialization
    
    init() {
        
        super.init(
            contentRect: .defaultRect,
            styleMask: .defaultStyleMask,
            backing: .buffered,
            defer: false
        )
        self.configure()
    }
}

// MARK: - Configure

private extension OhWindow {
    
    private func configure() {
        
        self.title = "Opportunities Hunter OSX-Bot;"
        self.minSize = .minimumRect

        self.titlebarSeparatorStyle = .line
        self.titlebarAppearsTransparent = true
        
        self.appearance = NSAppearance.init(named: NSAppearance.Name.vibrantDark)


    }
    
}
