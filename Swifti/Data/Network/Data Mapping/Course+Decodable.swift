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
    let questions: [CourseQuestion]
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

// MARK: - Question
struct CourseQuestion: Codable, Hashable {
    let question: String
    let choices: [CourseQuestionChoice]
    let code: String?
    let answer: Int
}

// MARK: - Choice
struct CourseQuestionChoice: Codable, Hashable {
    let id: Int
    let choice, quote: String
}
