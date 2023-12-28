//
//  OhClipView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 18/12/2023.
//

import AppKit

public class OhClipView: NSClipView {

    // MARK: - Initialization

    public init() {
        super.init(frame: NSRect.zero)
        self.configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure

private extension OhClipView {
    
    func configure() {
        
        self.disableAutoResizingMask()

        self.drawsBackground = false
        self.backgroundColor = .clear

        self.autoresizingMask = [.width, .height]

    }
    
}
