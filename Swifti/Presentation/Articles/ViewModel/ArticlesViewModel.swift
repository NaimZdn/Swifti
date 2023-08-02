//
//  ArticlesViewModel.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import Foundation
import SwiftUI

class ArticlesViewModel: ObservableObject {
    @Published var articles: [ArticleContent] = []
    @Published var selectedFilters: Set<String> = Set()
    
    private var gradients = GradientArticle.allCases
    
    init() {
        loadJSONData()
    }
    
    func loadJSONData() {
        if let path = Bundle.main.path(forResource: "Articles", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let articleData = try decoder.decode(Article.self, from: data)
                articles = articleData.articles
            } catch {
                print("Erreur lors du chargement du fichier JSON : \(error)")
            }
        }
    }
    
    func getLabelColor(subject: String) -> LinearGradient {
        gradients.first { $0.rawValue == subject }?.gradient ?? Color.gradientBlue
    }
    
    func getFilteredArticles() -> [ArticleContent] {
        if selectedFilters.isEmpty {
            return articles
        } else {
            return articles.filter { article in
                selectedFilters.contains(article.subject)
            }
        }
    }
    
    func bindingForFilters(_ filter: String) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.selectedFilters.contains(filter) },
            set: { newValue in
                if newValue {
                    self.selectedFilters.insert(filter)
                } else {
                    self.selectedFilters.remove(filter)
                }
            }
        )
    }
    
    func toggleFilter(filter: String) {
        if selectedFilters.contains(filter) {
            selectedFilters.remove(filter)
        } else {
            selectedFilters.insert(filter)
        }
    }
}
