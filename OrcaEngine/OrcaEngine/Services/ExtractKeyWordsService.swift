//
//  ExtractKeyWordsService.swift
//  OrcaEngine
//
//  Created by Shady El-Maadawy on 02/01/2024.
//

import Foundation
import NaturalLanguage

final class ExtractKeyWordsService {

    /// Extract keywords from a text string, extracted words will be based on Natural Language Analysis, As Example: IOS, Core Animation.. etc, there is no extract from web-sources.
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
            .joinNames,
        ]
        
        let acceptedTags: [NLTag] = [
            .noun,
            .adjective,
            .placeName,
            .organizationName,
        ]
        let textRange = stringBuffer.startIndex..<stringBuffer.endIndex
        tagger.string = stringBuffer
        let nlEmbedding = NLEmbedding.wordEmbedding(for: .english)!
        
        tagger.enumerateTags(
            in: textRange,
            unit: .word,
            scheme: .nameTypeOrLexicalClass, options: options
        ) { tokenTag, tokenRange in
            
            guard let tokenTag = tokenTag,
                  acceptedTags.contains(tokenTag) else {
                return true
            }
            
            let extractedToken = String.init(stringBuffer[tokenRange]).lowercased()
            guard extractedToken.count > 1 else {
                return true
            }

            // MARK: - I Think it's will not support opportunities outside tech
            let isTechConcept =
            nlEmbedding.neighbors(
                    for: extractedToken, maximumCount: 1
            ).isEmpty == true
            
            guard isTechConcept == true else {
                return true
            }

            keywordsBuffer.insert(
                OrcaKeyword.init(
                    keywordValue: extractedToken,
                    suitable: isSuitable
                )
            )
            return true
        }
        return keywordsBuffer
    }

}
