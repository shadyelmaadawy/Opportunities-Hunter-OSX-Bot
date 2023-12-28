//
//  OhTextView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

public protocol TextViewDelegates: AnyObject {
    func userInputs(_ input: String)
    func userPressEnter()
    func userPressBackspace()
}

public class OhTextView: NSTextView, NSTextViewDelegate {

    // MARK: - Properties
    
    private let _textStorage: NSTextStorage
    private let _layoutManager: NSLayoutManager
    private let _textContainer: NSTextContainer
    
    private var editLocation: Int = -1
    public override var isEditable: Bool {
        get {
            return super.isEditable
        }
        set {
            if(newValue == true) {
                self.editLocation = self.string.count
            } else {
                self.editLocation = -1
            }
            super.isEditable = newValue
        }
    }
    weak var textDelegates: TextViewDelegates?
    
    // MARK: - Initialization
    
    public init() {
       
        _textStorage = NSTextStorage.init()
        _layoutManager = NSLayoutManager.init()
        _textContainer = NSTextContainer.init()

        _textStorage.addLayoutManager(_layoutManager)
        
        _textContainer.widthTracksTextView = true
        _textContainer.heightTracksTextView = false
        _textContainer.lineBreakMode = .byWordWrapping
        
        _layoutManager.addTextContainer(_textContainer)

        super.init(
            frame: CGRect.init(
                x: 0, y: 0,
                width: 0,
                height: CGFloat.greatestFiniteMagnitude
            ),
            textContainer: _textContainer
        )
        self.configure()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public override func shouldChangeText(in affectedCharRange: NSRange, replacementString: String?) -> Bool {
        if(self.editLocation > 0 && self.string.count > self.editLocation && replacementString?.count == 0 ) {
            self.textDelegates?.userPressBackspace()
            return true
        }
        else if (affectedCharRange.length == 1 || affectedCharRange.location < self.string.count) {
            return false
        }
        else {
            guard let replacementString = replacementString else {
                return true
            }
            self.textDelegates?.userInputs(replacementString)
            return true
        }

    }
    
    public override func doCommand(by selector: Selector) {
        if (selector == #selector(insertNewline(_:))) {
            super.doCommand(by: selector)
            textDelegates?.userPressEnter()
        } else if(selector == #selector(deleteBackward(_:)) || selector == #selector(deleteForward(_:))) {
            super.doCommand(by: #selector(deleteBackward(_:)))
        } else {
            super.doCommand(by: selector)
        }
    }
}

// MARK: - Configure

private extension OhTextView {
    
    func configure() {
        
        self.disableAutoResizingMask()
        
        self.delegate = self
        self.isRichText = false

        self.isEditable = false
        self.isSelectable = true

        self.drawsBackground = false
        self.backgroundColor = .clear
        self.autoresizingMask = [.width]
        
        self.isVerticallyResizable = true
        self.isHorizontallyResizable = false

        self.textContainerInset = NSSize.init(width: 4.0, height: 8.0)
    }
    
}
