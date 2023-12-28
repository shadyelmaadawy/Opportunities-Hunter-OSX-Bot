//
//  String+Ext.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 28/12/2023.
//

import Foundation

internal extension String {
    
    subscript(_ idx: Int) -> String {
        String(self[self.index(self.startIndex, offsetBy: idx)])
    }
    
    @discardableResult
    func buildFromIdxs(_ startIdx: Int, _ endIdx: Int, _ replaceString: String?) -> String {
        var textBuffer = String.init()

        for i in (startIdx...(endIdx - 1)) {
            textBuffer.append(self[i])
        }
        
        guard let replaceString = replaceString else {
            return textBuffer
        }
        textBuffer.append(replaceString)
        return textBuffer
    }
    
}
