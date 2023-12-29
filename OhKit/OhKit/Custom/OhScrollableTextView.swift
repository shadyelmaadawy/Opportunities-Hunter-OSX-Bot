//
//  OhScrollableTextView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 18/12/2023.
//

import AppKit

public class OhScrollableTextView: OhScrollView {

    // MARK: - Enums
    
    internal enum SuffixTypes: String {
        case newLine = "\n"
        case whiteSpace = " "
    }
    
    // MARK: - UI Components
    
    private lazy var textView: OhTextView = {
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

// MARK: - Configure

private extension OhScrollableTextView {
    
    func configure() {
        
        self.clipView.documentView = textView
        self.contentView = clipView

        
    }
    
}

// MARK: - Operations

internal extension OhScrollableTextView {
    
    /// Append NSAttributedString to textview in main thread
    /// - Parameter textBuffer: required NSAttributedString
    func appendMessage(_ textBuffer: NSAttributedString) {
        DispatchQueue.main.async {
            
            self.textView.textStorage?.append(textBuffer)
            self.textView.scrollToEndOfDocument(nil)

        }
    }
    
    /// Add a suffix ( New line or Whitespace ) to textView
    /// - Parameter suffix: required suffix
    func appendSuffix(_ suffix: SuffixTypes) {
        
        // Check if the textview have previous value or not, to prevent add first line without needed
        DispatchQueue.main.sync {
            guard self.textView.textStorage?.string.isEmpty == false else {
                return
            }
            let textSuffix = NSAttributedString.buildAttributedBuffer(messagesBuffer: suffix.rawValue, colors: .black)
            self.appendMessage(textSuffix)
        }
    }
    
    /// Set edit enable status to textview to
    /// - Parameter value: required edit status
    func setEditableValue(_ value: Bool) {
        self.textView.isEditable = value
    }
    
    /// Set stream events handler
    /// - Parameter textEventsStream: An instance confirm to TextViewEvents Protocol
    func setEventsStreamDestination(_ textEventsStream: TextViewEvents) {
        self.textView.textViewEvents = textEventsStream
    }
}
