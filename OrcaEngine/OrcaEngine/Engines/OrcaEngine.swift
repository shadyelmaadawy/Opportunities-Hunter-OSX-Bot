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
    
    private let extractService: ExtractKeyWordsService
    
    private lazy var queryService: MLQueryService = {
       return MLQueryServiceConfigurator.configurator()
    }()
    
    // MARK: - Initialization
    
    public init() {
        self.trainService = MLTrainService.init()
        self.extractService = ExtractKeyWordsService.init()
        
    }
}

// MARK: - Operations

public extension OrcaEngine {
    
    /// Train AI Model with new data
    /// - Parameter requiredBuffer: new data that will train model with
    func train(_ requiredBuffer: [OrcaModel]) throws {
        try trainService.trainModel(requiredBuffer)
    }
    
    /// Query about value
    /// - Parameter value: required text
    /// - Returns: True of false
    func query(_ value: String) throws -> Bool {
        return queryService.query(value)
    }

    /// Extract keywords from a text string
    /// - Parameters:
    ///   - stringBuffer: required string that will be extract keywords from it
    ///   - isSuitable: status of opportunity if it suitable or not
    /// - Returns: Set with keywords
    
    func extractKeywords(_ stringBuffer: String, isSuitable: Bool) -> Set<OrcaKeyword> {
        return extractService.extractKeyWords(stringBuffer, isSuitable: isSuitable)
    }
}
