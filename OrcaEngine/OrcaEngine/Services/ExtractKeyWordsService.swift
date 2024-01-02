//
//  ExtractKeyWordsService.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 02/01/2024.
//

import Foundation
import NaturalLanguage

final class ExtractKeyWordsService {
    
    /// Extract keywords from a text string
    /// - Parameters:
    ///   - stringBuffer: required string that will be extract keywords from it
    ///   - isSuitable: status of opportunity if it suitable or not
    /// - Returns: Set with keywords
    func extractKeyWords(_ stringBuffer: String, isSuitable: Bool) -> Set<OrcaKeyword> {
        
        var keywordsBuffer: Set<OrcaKeyword> = []
        keywordsBuffer.reserveCapacity(128)
        
        let tagger = NLTagger.init(tagSchemes: [
            .nameTypeOrLexicalClass,
        ])
        let options: NLTagger.Options = [
            .omitPunctuation,
            .omitWhitespace,
            .joinNames
        ]
        
        let acceptedTags: [NLTag] = [
            .noun,
            .adjective,
            .organizationName,
        ]
        let textRange = stringBuffer.startIndex..<stringBuffer.endIndex
        tagger.string = stringBuffer
        
        tagger.enumerateTags(
            in: textRange,
            unit: .word,
            scheme: .nameTypeOrLexicalClass, options: options
        ) { tokenTag, tokenRange in
            
            guard let tokenTag = tokenTag else {
                return true
            }
            if(acceptedTags.contains(tokenTag)) {
                
                let extractedToken = stringBuffer[tokenRange]
                if (extractedToken.count > 1) {

                    keywordsBuffer.insert(
                        OrcaKeyword.init(
                            keywordValue: .init(extractedToken),
                            suitable: isSuitable
                        )
                    )
                    
                }
                
            }
            return true
        }
        return keywordsBuffer
    }

}
