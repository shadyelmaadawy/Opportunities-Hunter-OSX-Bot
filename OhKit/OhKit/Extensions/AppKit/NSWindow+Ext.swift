//
//  NSWindow+Ext.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

internal extension NSWindow.StyleMask {
    
    static var defaultStyleMask: NSWindow.StyleMask {
        var baseStyleMask: NSWindow.StyleMask = .titled

        baseStyleMask.formUnion(.fullSizeContentView)
        baseStyleMask.formUnion(.closable)
        baseStyleMask.formUnion(.miniaturizable)
        baseStyleMask.formUnion(.resizable)
        return baseStyleMask
    }
    
}
