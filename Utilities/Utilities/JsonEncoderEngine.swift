//
//  JsonEncoderEngine.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 31/12/2023.
//

import Foundation

public struct JsonEncoderEngine {

    // MARK: - Properties
    
    private let encoder: JSONEncoder

    // MARK: - Initialization
    
    public init(_ encoder: JSONEncoder = JSONEncoder.init()) {
        self.encoder = encoder
    }
}

// MARK: - Operations

extension JsonEncoderEngine {
    
    public func encode<T:Codable>(from requiredBuffer: T) throws -> Data {
        return try encoder.encode(requiredBuffer)
    }

}

