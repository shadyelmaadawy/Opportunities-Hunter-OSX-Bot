//
//  String+Ext.swift
//  OhKit
//
//  Created by Shady El-Maadawy on 28/12/2023.
//

import Foundation

extension String {
    public subscript(_ idx: Int) -> String {
        String(self[self.index(self.startIndex, offsetBy: idx)])
    }
}
