//
//  ParserResult.swift
//  Swifti
//
//  Created by Zidouni on 01/08/2023.
//

import Foundation

struct ParserResult: Identifiable {
    let id = UUID()
    let attributedString: AttributedString
    let isCodeBlock: Bool
    let codeBlockLanguage: String?
    
}
