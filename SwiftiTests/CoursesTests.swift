//
//  CoursesTests.swift
//  SwiftiTests
//
//  Created by Zidouni on 18/08/2023.
//

import XCTest
import CoreData
@testable import Swifti

final class CoursesTests: XCTestCase {

    var courses: CourseViewModel!
    var dataController: DataController!
    
    override func setUp() {
        courses = CourseViewModel()
        dataController = DataController.shared
    }
    
    override func tearDown() {
        super.tearDown()
        let context = dataController.container.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = CourseEntity.fetchRequest()
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try? context.execute(deleteRequest)
    }
    
    func testGivenLoadJSONData_WhenTryingToParseData_ThenReceiveCourses() throws {
        guard let filePath = Bundle(for: type(of: self)).path(forResource: "CoursesData", ofType: "json") else {
            XCTFail("JSON file not found.")
            return
        }
        
        let jsonData = try Data(contentsOf: URL(fileURLWithPath: filePath))
        
        do {
            let decoder = JSONDecoder()
            let course = try decoder.decode(Course.self, from: jsonData)
            
            XCTAssertEqual(course.courses[0].title, "Introduction au langage")
            XCTAssertEqual(course.courses[0].sections[0].title, "Pourquoi apprendre Swift ?")
            XCTAssertEqual(course.courses[0].questions[0].question, "\n1. En quelle année la première version de Swift a vu le jour ?")
            XCTAssertEqual(course.courses[0].questions[0].choices[0].choice, "2012")
            
        } catch {
            XCTFail("Error parsing JSON: \(error)")
        }
    }
    
    func testGivenGetScores_WhenCoursesExist_ThenScoresAreFetchedAndMapped() {  
        let context = dataController.container.viewContext
        
        let course1 = CourseEntity(context: context)
        course1.title = "Swift"
        course1.score = 90
        
        let course2 = CourseEntity(context: context)
        course2.title = "SwiftUI"
        course2.score = 85
        
        try? context.save()

        courses.getScores()
       
        XCTAssertEqual(courses.coursesScore.count, 2)
        XCTAssertEqual(courses.coursesScore["Swift"], 90)
        XCTAssertEqual(courses.coursesScore["SwiftUI"], 85)
    }
    
    func testGivenGetScores_WhenNoCourses_ThenScoresDictionaryIsEmpty() {
        courses.getScores()

        XCTAssertTrue(courses.coursesScore.isEmpty)
    }
    
    func testGivenAddScoreToData_WhenCourseExists_ThenScoreIsAddedToDataAndCoursesScore() {
        let context = dataController.container.viewContext
        
        let course = CourseEntity(context: context)
        course.title = "Swift Course"
        course.score = 90
        
        try? context.save()

        courses.addScoreToData(courseTitle: "Swift Course", score: 95)
        
        XCTAssertEqual(courses.coursesScore["Swift Course"], 95)
    }
    
    func testGivenAddScoreToData_WhenCourseDoesNotExist_ThenScoreIsAddedToCoursesScore() {
        courses.addScoreToData(courseTitle: "SwiftUI Course", score: 85)
  
        XCTAssertEqual(courses.coursesScore["SwiftUI Course"], 85)
    }
    
    func testGivenGetLabelColor_WhenValidSubject_ThenReturnGradient() {
        let subject = "Facile"
        
        let gradient = courses.getLabelColor(subject: subject)
        
        XCTAssertNotNil(gradient)
    }
    
    func testGivenProgressBar_WhenValidScoreAndQuestions_ThenReturnValidProgressBinding() {
        let score = 10
        let numberOfQuestions = 20
        
        let progressBinding = courses.progressBar(score: score, numberOfQuestions: numberOfQuestions)

        XCTAssertEqual(progressBinding.wrappedValue, Float(score) / Float(numberOfQuestions))
    }
    
    func testGivenGetScoreText_WhenPercentageIsLessThanOrEqualTo25_ThenReturnCorrectText() {
        let score = 20
        let totalQuestions = 100
        
        let scoreText = courses.getScoreText(score: score, totalQuestions: totalQuestions)
        
        XCTAssertEqual(scoreText, "Votre score est de \(score), essayez de relire attentivement le cours pour être bien sûr de comprendre tous les concepts qui y sont présentés. Vous allez y arriver ! 😁")
    }
    
    func testGivenGetScoreText_WhenPercentageIsLessThanOrEqualTo50_ThenReturnCorrectText() {
        let score = 45
        let totalQuestions = 100
        
        let scoreText = courses.getScoreText(score: score, totalQuestions: totalQuestions)
        
        XCTAssertEqual(scoreText, "Bravo ! Votre score est de \(score), continuez à étudier pour améliorer vos résultats. Vous progressez ! 👍")
    }
    
    func testGivenGetScoreText_WhenPercentageIsLessThanOrEqualTo75_ThenReturnCorrectText() {
        let score = 70
        let totalQuestions = 100
        
        let scoreText = courses.getScoreText(score: score, totalQuestions: totalQuestions)
        
        XCTAssertEqual(scoreText, "Félicitations ! Votre score est de \(score), vous avez une bonne maîtrise du contenu. Continuez comme ça ! 🎉")
    }
    
    func testGivenGetScoreText_WhenPercentageIsLessThan100_ThenReturnCorrectText() {
        let score = 90
        let totalQuestions = 100
        
        let scoreText = courses.getScoreText(score: score, totalQuestions: totalQuestions)
        
        XCTAssertEqual(scoreText, "Excellent travail ! Votre score est de \(score), vous êtes très proche de la perfection. Continuez à vous entraîner ! 🚀")
    }
    
    func testGivenGetScoreText_WhenPercentageIs100_ThenReturnCorrectText() {
        let score = 100
        let totalQuestions = 100
        
        let scoreText = courses.getScoreText(score: score, totalQuestions: totalQuestions)

        XCTAssertEqual(scoreText, "Félicitations ! C'est un sans faute ! 🎉 Votre score est de \(score). Vous maîtrisez parfaitement le contenu du cours. Bravo ! 🥳")
    }
}
