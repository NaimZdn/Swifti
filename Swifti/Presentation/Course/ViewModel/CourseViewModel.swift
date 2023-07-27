//
//  CourseViewModel.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import Foundation

class CourseViewModel: ObservableObject {
    @Published var courses: [CourseContent] = []
    
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
}
