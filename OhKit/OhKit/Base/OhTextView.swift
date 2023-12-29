//
//  OhTextView.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit
import Combine


/// Stream Protocol of events
public protocol TextViewEvents: AnyObject {
    var userEnterEvent: PassthroughSubject<String, Never> { get }
}

public class OhTextView: NSTextView, NSTextViewDelegate {

    // MARK: - Properties
    
    weak var textViewEvents: TextViewEvents?
    
    private let _textStorage: NSTextStorage
    private let _layoutManager: NSLayoutManager
    private let _textContainer: NSTextContainer
    
    /// Edit Location is the string count before enable edit mode
    private var editLocation: Int = -1
    
    // MARK: - View Properties
    
    public override var isEditable: Bool {
        get {
            return super.isEditable
        }
        set {
            DispatchQueue.main.async {
                
                if(newValue == true) {
                    self.editLocation = self.string.count
                } else {
                    self.editLocation = -1
                }
                
                super.isEditable = newValue
            }
        }
    }
    
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
    
}

// MARK: - View Life Cycle

extension OhTextView {
    
    /// Override should change text function to prevent user from remove or change any inputs on text view
    public override func shouldChangeText(in affectedCharRange: NSRange, replacementString: String?) -> Bool {
        if(self.editLocation > 0 && (
            affectedCharRange.location <= self.string.count &&
            affectedCharRange.location >= self.editLocation
        )) {
            
            return true
        }
        
        return false
    }
    
    /// Override do command function to handle enter/delete/backspace events
    public override func doCommand(by selector: Selector) {
        
        if (selector == #selector(insertNewline(_:))) {
            
            guard self.editLocation > 0, self.editLocation < self.string.count else {
                return
            }
            self.isEditable = false
            
            let textBuffer = self.string.buildFromIdxs(self.editLocation, self.string.count)
            self.textViewEvents?.userEnterEvent.send(textBuffer)
            
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
  
        self.font = .getFont(.regular, textStyle: .footnote)
    }
    
}
