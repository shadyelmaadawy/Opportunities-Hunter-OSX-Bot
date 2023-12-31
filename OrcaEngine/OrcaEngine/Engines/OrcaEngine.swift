//
//  OrcaEngine.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 31/12/2023.
//

import Foundation

public class OrcaEngine {
    
    // MARK: - Properties
    
    private let trainService: MLTrainService
    
    private lazy var queryService: MLQueryService = {
       return MLQueryServiceConfigurator.configurator()
    }()
    
    // MARK: - Initialization
    
    public init() {
        self.trainService = MLTrainService.init()
        
    }
}

// MARK: - Operations

extension OrcaEngine {
    
    /// Train AI Model with new data
    /// - Parameter requiredBuffer: new data that will train model with
    public func train(_ requiredBuffer: [OrcaModel]) throws {
        try trainService.trainModel(requiredBuffer)
    }
    
    /// Query about value
    /// - Parameter value: required text
    /// - Returns: True of false
    public func query(_ value: String) throws -> Bool {
        return queryService.query(value)
    }

}
