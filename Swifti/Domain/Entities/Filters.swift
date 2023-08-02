//
//  Filters.swift
//  Swifti
//
//  Created by Zidouni on 01/08/2023.
//

import Foundation

enum FiltersArticles: String, CaseIterable, Hashable {
    case code = "Code"
    case tips = "Astuces"
    case tuto = "Tuto"
    case news = "Nouveautés"
}

enum FiltersCourses: String, CaseIterable {
    case swift = "Swift"
    case swiftUI = "SwiftUI"
}
