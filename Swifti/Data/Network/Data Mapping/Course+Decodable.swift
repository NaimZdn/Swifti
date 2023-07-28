//
//  Course+Decodable.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import Foundation

// MARK: - Welcome
struct Course: Codable {
    let courses: [CourseContent]
}

// MARK: - Course
struct CourseContent: Codable, Hashable {
    let title, icon, difficulty, update, techno, content: String
}
