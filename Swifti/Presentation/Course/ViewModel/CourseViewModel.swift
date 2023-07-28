//
//  CourseViewModel.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import Foundation
import SwiftUI

class CourseViewModel: ObservableObject {
    @Published var courses: [CourseContent] = []
    
    private var gradients = GradientCourse.allCases
    
    init() {
        loadJSONData()
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
