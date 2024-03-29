//
//  Gradient.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import Foundation
import SwiftUI

enum GradientArticle: String, CaseIterable  {
    case tips = "Astuces"
    case news = "News"
    case newest = "Nouveautés"
    case tutorial = "Tuto"
    case code = "Code"
    
    var gradient: LinearGradient {
        switch self {
        case .tips:
            return Color.gradientYellow
        case .news:
            return Color.gradientGreen
        case .newest:
            return Color.gradientOrange
        case .tutorial:
            return Color.gradientPink
        case .code:
            return Color.gradientBlue
        }
    }
}

enum GradientCourse: String, CaseIterable  {
    case easy = "Facile"
    case medium = "Moyen"
    case hard = "Difficile"
    
    var gradient: LinearGradient {
        switch self {
        case .easy:
            return Color.gradientBlue
        case .medium:
            return Color.gradientYellow
        case .hard:
            return Color.gradientOrange

        }
    }
}
