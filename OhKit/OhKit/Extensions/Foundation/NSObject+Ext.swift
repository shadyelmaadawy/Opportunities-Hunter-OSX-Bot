//
//  NSObject+Ext.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 28/12/2023.
//

import Foundation

internal extension NSObject {
    
    func sleep(for seconds: Double) {
        Thread.sleep(forTimeInterval: seconds)
    }
    
}
