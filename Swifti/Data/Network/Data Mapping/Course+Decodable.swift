//
//  Course+Decodable.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import Foundation

// MARK: - Course
struct Course: Codable {
    let courses: [CourseContent]
}

// MARK: - CourseContent
struct CourseContent: Codable, Hashable {
    let title : String
    let icon : String
    let techno : String
    let difficulty : String
    let update : String
    let intro : String
    let sections: [CourseSection]
    let outro: String?
}

// MARK: - CourseSection
struct CourseSection : Codable, Hashable {
    let title : String
    let firstText: String?
    let firstCode: String?
    let subsections : [CourseSubsection]?
    let secondText : String?
    let secondCode : String?
    let firstTextBox : String?
}

struct CourseSubsection: Codable, Hashable {
    let subtitle: String
    let firstText: String
    let firstCode: String?
    let secondText: String?
    let secondCode: String?
    let thirdText : String?
}
