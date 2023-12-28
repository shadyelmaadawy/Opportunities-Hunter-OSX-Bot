//
//  OhTextField.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

public class OhTextField: NSTextField {
    
    // MARK: - Properties
    
    private var padding: CGFloat {
        return 8.00
    }
    
    public override var intrinsicContentSize: NSSize {
        var contentSize = super.intrinsicContentSize
        contentSize.width += padding
        contentSize.height += padding
        return contentSize
    }
    
    
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

private extension OhTextField {
    
    func configure() {
        
        self.disableAutoResizingMask()

        self.font = .getFont(.regular, textStyle: .footnote)
        
        self.bezelStyle = .squareBezel
        self.autoresizingMask = [.width, .height]
        
        self.focusRingType = .none
        self.isBordered = false
        self.drawsBackground = true
        self.usesSingleLineMode = false
        self.backgroundColor = .black.withAlphaComponent(0.25)
    }
}
