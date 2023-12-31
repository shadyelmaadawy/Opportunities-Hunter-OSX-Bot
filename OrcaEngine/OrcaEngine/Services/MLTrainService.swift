//
//  MLTrainService.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 31/12/2023.
//

import CreateML
import TabularData
import Utilities

internal final class MLTrainService {
    
    // MARK: - Enums
    
    enum ColumnIdentifier: String {
        case valueColumn = "value"
        case suitableColumn = "suitable"
    }
    
    // MARK: - Properties

    private let encoderEngine = JsonEncoderEngine.init()
}

// MARK: - Operations

extension MLTrainService {
    
    /// Train AI Model with new data
    /// - Parameter requiredBuffer: new data that will train model with
    func trainModel(_ requiredBuffer: [OrcaModel]) throws {
        
        let jsonData = try encoderEngine.encode(from: requiredBuffer)

        let tableDataFrame = try DataFrame.init(jsonData: jsonData)
        let textClassifier = try MLTextClassifier.init(
            trainingData: tableDataFrame,
            textColumn: ColumnIdentifier.valueColumn.rawValue,
            labelColumn: ColumnIdentifier.suitableColumn.rawValue
        )
        
        try textClassifier.write(
            to: URL.modelURL
        )
    }


}
