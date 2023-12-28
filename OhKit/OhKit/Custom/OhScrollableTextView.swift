//
//  OhScrollableTextView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 18/12/2023.
//

import AppKit

public class OhScrollableTextView: OhScrollView {

    // MARK: - UI Components
    
    internal lazy var textView: OhTextView = {
        let baseTextView = OhTextView.init()
        baseTextView.enableAutoResizingMask()
        return baseTextView
    }()

    private lazy var clipView: OhClipView = {
        let baseView = OhClipView.init()
        return baseView
    }()
    
    // MARK: - Initialization
    
    public override init() {
        super.init()
        self.configure()
    }
    
}

// MARK: - Operations

public extension OhScrollableTextView {
    
    func appendText(_ textBuffer: NSAttributedString?) {
        
        guard let textBuffer = textBuffer else {
            return
        }
        self.textView.textStorage?.append(textBuffer)

    }
    
    
    func appendChar(_ charColor: NSColor, _ char: Character) {

        let logBuffer = NSMutableAttributedString.buildAttributedBuffer(
            messagesBuffer: String(char),
            colors: charColor,
            withNewLine: false
        )
        DispatchQueue.main.sync { self.appendText(logBuffer) }

    }
    func appendSuffix(newLine: Bool = false) {
        DispatchQueue.main.async { self.textView.textStorage?.append(NSAttributedString.buildAttributedBuffer(messagesBuffer: newLine ? "" : " ", colors: .black, withNewLine: newLine))
        }
    }
    
    internal func setDelegates(_ delegates: TextViewDelegates) {
        self.textView.textDelegates = delegates
    }
    
}

// MARK: - Configure

private extension OhScrollableTextView {
    
    func configure() {
        
        self.clipView.documentView = textView
        self.contentView = clipView

    }
    
}
