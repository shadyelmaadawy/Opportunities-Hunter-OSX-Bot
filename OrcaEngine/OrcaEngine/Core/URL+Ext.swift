//
//  URL+Ext.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 31/12/2023.
//

import Foundation

internal extension URL {
    
    /// Default Model Path
    static var modelURL: URL {
        let currentDirectoryPath = URL.desktopDirectory
        let orcaModelPath = currentDirectoryPath.appendingPathComponent("Orca.mlmodel")
        return orcaModelPath
    }
}
