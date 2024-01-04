//
//  OrcaKeyword.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 02/01/2024.
//

import Foundation

public final class OrcaKeyword: Hashable, Codable {
    
    // MARK: - Properties

    public let keywordValue: String
    public let suitable: Bool
    
    // MARK: - Initialization
    
    init(keywordValue: String, suitable: Bool) {
        self.keywordValue = keywordValue
        self.suitable = suitable
    }
}

// MARK: - Operations

public extension OrcaKeyword {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(keywordValue)
    }
    
    static func == (lhs: OrcaKeyword, rhs: OrcaKeyword) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

}
