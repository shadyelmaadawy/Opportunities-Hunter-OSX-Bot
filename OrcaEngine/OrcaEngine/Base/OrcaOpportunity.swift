//
//  OrcaOpportunity.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 03/01/2024.
//

import Foundation

public final class OrcaOpportunity: Codable {
    
    // MARK: - Properties

    public let fullText: String
    public let isSuitable: Bool
    
    // MARK: - Initialization
    
    init(title: String, fullText: String, isSuitable: Bool) {
        self.fullText = fullText
        self.isSuitable = isSuitable
    }
}
