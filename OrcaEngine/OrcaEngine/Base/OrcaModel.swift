//
//  OrcaModel.swift
//  Orca Engine
//
//  Created by Shady El-Maadawy on 31/12/2023.
//

import Foundation

public class OrcaModel: Codable {
    
    // MARK: - Properties
    
    public let value: String
    
    public let suitable: String
    
    // MARK: - Initialization
    
    public init(value: String, suitable: Bool) {

        self.value = value

        if(suitable) {
            self.suitable = "True"
        } else {
            self.suitable = "False"
        }
        
    }
    
}

