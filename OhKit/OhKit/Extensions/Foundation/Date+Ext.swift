//
//  Date+Ext.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 18/12/2023.
//

import Foundation

internal extension Date {
    
    static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        return "[\(dateFormatter.string(from: Date()))]"

    }
}
