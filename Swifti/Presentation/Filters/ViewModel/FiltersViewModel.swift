//
//  FiltersViewModel.swift
//  Swifti
//
//  Created by Zidouni on 04/08/2023.
//

import Foundation
import SwiftUI

class FiltersViewModel: ObservableObject {
    @Published var selectedFilters: Set<String> = []
    
    func getFilteredArticles(articles: [ArticleContent]) -> [ArticleContent] {
        if selectedFilters.isEmpty {
            return articles
        } else {
            return articles.filter { article in
                selectedFilters.contains(article.subject)
            }
        }
    }
    
    func getFilteredCourses(courses: [CourseContent]) -> [CourseContent] {
        if selectedFilters.isEmpty {
            return courses
        } else {
            return courses.filter { course in
                selectedFilters.contains(course.techno)
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
