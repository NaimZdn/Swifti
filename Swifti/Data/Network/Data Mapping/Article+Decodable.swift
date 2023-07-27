//
//  Article+Decodable.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import Foundation

// MARK: - Welcome
struct Article: Codable {
    let articles: [ArticleContent]
}

// MARK: - Article
struct ArticleContent: Codable, Hashable {
    let title, cover, subject, content: String
    
}
