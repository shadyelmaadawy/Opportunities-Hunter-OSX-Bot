//
//  Date+Ext.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 18/12/2023.
//

import Foundation

internal extension Date {
    
    /// Get formatted current date
    /// - Returns: current date as string
    static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        return "[\(dateFormatter.string(from: Date()))]"

    }
}
