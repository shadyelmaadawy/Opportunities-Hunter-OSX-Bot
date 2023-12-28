//
//  OhView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

open class OhView: NSView {
    
    // MARK: - Properties
        
    var userInteractionEnabled: Bool = true
    
    // MARK: - View Life Cycle
    
    open override func hitTest(_ point: NSPoint) -> NSView? {
        return userInteractionEnabled ? super.hitTest(point) : nil
    }
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        self.configure()
    }
    
    @available(*, unavailable)
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - Configure

private extension OhView {
    
    func configure() {
        self.disableAutoResizingMask()
    }
}
