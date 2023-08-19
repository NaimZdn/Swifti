//
//  FiltersTests.swift
//  SwiftiTests
//
//  Created by Zidouni on 18/08/2023.
//

import XCTest
import CoreData
@testable import Swifti

final class FiltersTests: XCTestCase {
    var filters: FiltersViewModel!
    
    override func setUp() {
        filters = FiltersViewModel()
    }
    
    func testGivenGetFilteredArticles_WhenNoFiltersSelected_ThenReturnAllArticles() {
        let articles: [ArticleContent] = [
            ArticleContent(title: "", cover: "", subject: "Code", published: "", intro: "", image: "", sections: [], outro: ""),
            ArticleContent(title: "", cover: "", subject: "Tuto", published: "", intro: "", image: "", sections: [], outro: "")
        ]
        
        let result = filters.getFilteredArticles(articles: articles)
        
        XCTAssertEqual(result, articles)
    }
    
    func testGivenGetFilteredArticles_WhenFiltersSelected_ThenReturnFilteredArticles() {
        let articles: [ArticleContent] = [
            ArticleContent(title: "", cover: "", subject: "Code", published: "", intro: "", image: "", sections: [], outro: ""),
            ArticleContent(title: "", cover: "", subject: "Tuto", published: "", intro: "", image: "", sections: [], outro: ""),
            ArticleContent(title: "", cover: "", subject: "Nouveautés", published: "", intro: "", image: "", sections: [], outro: "")
        ]
        filters.selectedFilters = ["Code", "Tuto"]
        
        let result = filters.getFilteredArticles(articles: articles)
        
        XCTAssertEqual(result.count, 2)
        XCTAssertTrue(result.contains { $0.subject == "Code" })
        XCTAssertTrue(result.contains { $0.subject == "Tuto" })
        XCTAssertFalse(result.contains { $0.subject == "Nouveautés" })
    }
    
    func testGivenGetFilteredCourses_WhenNoFiltersSelected_ThenReturnAllCourses() {
        let courses: [CourseContent] = [
            CourseContent(title: "", icon: "", techno: "Swift", difficulty: "", update: "", intro: "", sections: [], outro: "", questions: []),
            CourseContent(title: "", icon: "", techno: "SwiftUI", difficulty: "", update: "", intro: "", sections: [], outro: "", questions: []),
            CourseContent(title: "", icon: "", techno: "Swift", difficulty: "", update: "", intro: "", sections: [], outro: "", questions: [])
            
        ]
        let result = filters.getFilteredCourses(courses: courses)
        
        XCTAssertEqual(result, courses)
    }
    
    func testGivenGetFilteredCourses_WhenFiltersSelected_ThenReturnFilteredCourses() {
        let courses: [CourseContent] = [
            CourseContent(title: "", icon: "", techno: "Swift", difficulty: "", update: "", intro: "", sections: [], outro: "", questions: []),
            CourseContent(title: "", icon: "", techno: "SwiftUI", difficulty: "", update: "", intro: "", sections: [], outro: "", questions: [])
        ]
        
        filters.selectedFilters = ["Swift"]
        
        let result = filters.getFilteredCourses(courses: courses)
        
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(result.contains { $0.techno == "Swift" })
        XCTAssertFalse(result.contains { $0.techno == "SwiftUI" })
    }
    
    func testGivenToggleFilter_WhenFilterIsSelected_ThenFilterIsDeselected() {
        let filter = "Swift"
        filters.selectedFilters = ["Swift"]
        
        filters.toggleFilter(filter: filter)
        
        XCTAssertFalse(filters.selectedFilters.contains(filter))
    }
    
    func testGivenToggleFilter_WhenFilterIsNotSelected_ThenFilterIsSelected() {
        let filter = "Swift"
        filters.selectedFilters = []
        
        filters.toggleFilter(filter: filter)
        
        XCTAssertTrue(filters.selectedFilters.contains(filter))
    }
    
    func testGivenBindingForFiltersAndToggleFilter_WhenBindingIsToggled_ThenSelectedFiltersUpdated() {
        let filter = "Swift"
        let binding = filters.bindingForFilters(filter)
        
        binding.wrappedValue.toggle()
        
        XCTAssertTrue(filters.selectedFilters.contains(filter))
        
        binding.wrappedValue.toggle()
        
        XCTAssertFalse(filters.selectedFilters.contains(filter))
    }
}
