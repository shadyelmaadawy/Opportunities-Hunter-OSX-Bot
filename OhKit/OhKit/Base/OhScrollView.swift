//
//  OhScrollView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

public class OhScrollView: NSScrollView {
    
    // MARK: - Initialization
    
    public init() {
        super.init(frame: NSRect.zero)
        self.configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure

private extension OhScrollView {
    
    func configure() {
        
        self.disableAutoResizingMask()

        self.borderType = .noBorder
        
        self.drawsBackground = false
        self.backgroundColor = .clear

        self.hasVerticalScroller = true
        self.hasHorizontalScroller = false
        
        self.autoresizingMask = [.width, .height]

    }
    
}


