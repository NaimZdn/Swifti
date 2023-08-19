//
//  ArticlesTests.swift
//  SwiftiTests
//
//  Created by Zidouni on 19/08/2023.
//

import XCTest
@testable import Swifti

final class ArticlesTests: XCTestCase {
    
    var articles: ArticlesViewModel!
    
    override func setUp() {
        articles = ArticlesViewModel()
    }
    
    func testGivenLoadJSONData_WhenTryingToParseData_ThenReceiveArticles() throws {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "ArticlesData", ofType: "json") else {
            XCTFail("JSON file not found.")
            return
        }
        
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
        
        do {
            let decoder = JSONDecoder()
            let article = try decoder.decode(Article.self, from: jsonData)
            
            XCTAssertEqual(article.articles[0].title, "5 points à retenir de la WWDC23")
            XCTAssertEqual(article.articles[0].subject, "Nouveautés")
            XCTAssertEqual(article.articles[0].sections[0].title, "1. Apple Vision Pro")
            
        } catch {
            XCTFail("Error parsing JSON: \(error)")
        }
    }
    
    func testGivenGetLabelColor_WhenValidSubject_ThenReturnGradient() {
        let subject = "Tuto"
        
        let gradient = articles.getLabelColor(subject: subject)
        
        XCTAssertNotNil(gradient)
    }
}
