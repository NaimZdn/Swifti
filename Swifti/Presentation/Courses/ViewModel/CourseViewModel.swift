//
//  CourseViewModel.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import Foundation
import CoreData
import SwiftUI

class CourseViewModel: ObservableObject {
    @Published var courses: [CourseContent] = []
    @Published var coursesScore: [String: Int] = ["" : 0]
    
    private var dataController: DataController
    private var context: NSManagedObjectContext
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
            coursesScore = Dictionary(uniqueKeysWithValues: results.map { ($0.title!, Int($0.score)) })
            print("Fonction getScore \(coursesScore)")
        } catch {
            print("Une erreur est survenue lors de la récupération des scores : \(error)")
        }
    }
    
    func addScoreToData(courseTitle: String, score: Int) {
        dataController.addScoreToData(courseTitle: courseTitle, score: score)
        coursesScore[courseTitle] = score
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
        gradients.first { $0.rawValue == subject }!.gradient
    }
    
    func progressBar(score: Int, numberOfQuestions: Int) -> Binding<Float> {
        let progress = Float(score) / Float(numberOfQuestions)
        return Binding(
            get: { progress },
            set: { _ in }
        )
    }
    
    func getScoreText(score: Int, totalQuestions: Int) -> String {
        let percentage = Double(score) / Double(totalQuestions) * 100
        
        if percentage <= 25 {
            return "Votre score est de \(score), essayez de relire attentivement le cours pour être bien sûr de comprendre tous les concepts qui y sont présentés. Vous allez y arriver ! 😁"
        } else if percentage <= 50 {
            return "Bravo ! Votre score est de \(score), continuez à étudier pour améliorer vos résultats. Vous progressez ! 👍"
        } else if percentage <= 75 {
            return "Félicitations ! Votre score est de \(score), vous avez une bonne maîtrise du contenu. Continuez comme ça ! 🎉"
        } else if percentage < 100 {
            return "Excellent travail ! Votre score est de \(score), vous êtes très proche de la perfection. Continuez à vous entraîner ! 🚀"
        }
        return "Félicitations ! C'est un sans faute ! 🎉 Votre score est de \(score). Vous maîtrisez parfaitement le contenu du cours. Bravo ! 🥳"
    }
}
