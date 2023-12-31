//
//  MLQueryService.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 31/12/2023.
//

import NaturalLanguage

internal final class MLQueryService {
    
    // MARK: - Properties
    
    private let languageModel: NLModel

    // MARK: - Initialization
    
    init(languageModel: NLModel) {
        self.languageModel = languageModel
    }
    
}

// MARK: - Operations

extension MLQueryService {
    
    /// Query about text if it's suitable or not
    /// - Parameter value: Text
    /// - Returns: True or false
    func query(_ value: String) -> Bool {
        return languageModel.predictedLabel(for: value) == "True" ? true : false
    }

}
