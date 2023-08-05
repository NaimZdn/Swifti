//
//  Article+Decodable.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import Foundation

// MARK: - Article
struct Article: Codable {
    let articles: [ArticleContent]
}

// MARK: - ArticleElement
struct ArticleContent: Codable, Hashable {
    let title: String
    let cover: String
    let subject, published: String
    let intro: String
    let image: String?
    let sections: [ArticleSection]
    let outro: String
}

// MARK: - Section
struct ArticleSection: Codable, Hashable {
    let title, text: String
    let image: String?
    let isCode: Bool?
    let code: String?
    let isSecondText: Bool?
    let secondText: String?
    let isSecondCode: Bool?
    let secondCode: String?
    let isThirdText: Bool?
    let thirdText: String?
}
