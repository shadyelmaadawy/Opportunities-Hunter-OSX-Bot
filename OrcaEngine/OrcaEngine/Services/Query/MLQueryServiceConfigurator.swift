//
//  MLQueryServiceConfigurator.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 31/12/2023.
//

import CoreML
import NaturalLanguage

internal final class MLQueryServiceConfigurator {
    
    /// Prepare service
    /// - Returns: Query Service
    class func configurator() -> MLQueryService {
        
        do {
            let compiledURL = try MLModel.compileModel(at: URL.modelURL)
            
            let machineModel = try MLModel(
                contentsOf: compiledURL
            )
            let languageModel = try NLModel(
                mlModel: machineModel
            )
            return MLQueryService.init(languageModel: languageModel)

        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

