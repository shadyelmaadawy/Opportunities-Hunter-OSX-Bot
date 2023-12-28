//
//  OhVisualEffectView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

internal final class OhVisualEffectView: NSVisualEffectView {
    
    // MARK: - Initialization
        
    init() {
        super.init(frame: NSRect.zero)
        self.configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Configure

private extension OhVisualEffectView {
    
    private func configure() {
        
        self.blendingMode = .behindWindow
        self.state = .active
        self.appearance = NSAppearance.init(named: NSAppearance.Name.vibrantDark)
        self.material = .popover
    }
}
