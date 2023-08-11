//
//  CourseViewModel.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import Foundation
import CoreData
import SwiftUI

struct Score {
    let title: String
    let score: Int
}

class CourseViewModel: ObservableObject {
    private var dataController: DataController
    private var context: NSManagedObjectContext
    
    @Published var courses: [CourseContent] = []
    
    @Published var coursesScore: [String: Int] = ["" : 0]
    
    private var gradients = GradientCourse.allCases
    
    init() {
        dataController = DataController.shared
        context = dataController.container.viewContext
        loadJSONData()
        getScores()
    }
    
    func getScores() {
        let fetchRequest: NSFetchRequest<CourseEntity> = CourseEntity.fetchRequest()
        
        do {
            let results = try dataController.container.viewContext.fetch(fetchRequest)
            coursesScore = Dictionary(uniqueKeysWithValues: results.map { ($0.title ?? "", Int($0.score)) })
            print("Fonction getScore \(coursesScore)")
        } catch {
            print("Une erreur est survenue lors de la récupération des scores : \(error)")
        }
        
    }
    
    func addScoreToData(courseTitle: String, score: Int) {
        dataController.addScoreToData(courseTitle: courseTitle, score: score)
        coursesScore[courseTitle] = score
        print("Ce que nous renvoie le ViewModel \(coursesScore)")
    }
    
    
    func loadJSONData() {
        if let path = Bundle.main.path(forResource: "Courses", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                let courseData = try decoder.decode(Course.self, from: data)
                courses = courseData.courses
            } catch {
                print("Erreur lors du chargement du fichier JSON : \(error)")
            }
        }
    }
    
    func getLabelColor(subject: String) -> LinearGradient {
        gradients.first { $0.rawValue == subject }?.gradient ?? Color.gradientBlue
    }
}
