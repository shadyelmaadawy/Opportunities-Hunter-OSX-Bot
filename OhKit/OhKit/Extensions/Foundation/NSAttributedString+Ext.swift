//
//  NSAttributedString+Ext.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 18/12/2023.
//

import AppKit


internal extension NSAttributedString {
    
    static func buildAttributedBuffer(
        messagesBuffer: String...,
        colors: NSColor...) -> NSAttributedString {

            guard messagesBuffer.count == colors.count else {
                fatalError("Messages buffer length is not equal to colors buffer length")
            }
            
            let baseMutableString = NSMutableAttributedString()
        
            for (index, value) in messagesBuffer.enumerated() {
                let color = colors[index]

                baseMutableString.append(
                    NSAttributedString(
                        string: value ,
                        attributes: [
                            NSAttributedString.Key.font: NSFont.getFont(.regular, textStyle: .footnote),
                            NSAttributedString.Key.foregroundColor: color]
                    )
                )
            }
            return baseMutableString
    }

}
