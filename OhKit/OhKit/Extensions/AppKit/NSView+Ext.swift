//
//  NSView+Ext.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 17/12/2023.
//

import AppKit

internal extension NSView {
    
    /// A generic function to enable auto resizing mask across NSView Instances
    func enableAutoResizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = true
    }
    
    /// A generic function to disable auto resizing mask across NSView Instances
    func disableAutoResizingMask() {
        self.translatesAutoresizingMaskIntoConstraints = false
    }

}
