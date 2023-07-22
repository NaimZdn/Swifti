//
//  Style.swift
//  Swifti
//
//  Created by Zidouni on 22/07/2023.
//

import Foundation
import SwiftUI

extension Color {
    
    init(hex: UInt, alpha: Double = 1) {
        self.init(
            .sRGB    ,
            red: Double((hex >> 16) & 0xff) / 255,
            green: Double((hex >> 08) & 0xff) / 255,
            blue: Double((hex >> 00) & 0xff) / 255,
            opacity: alpha
        )
    }
    
    static let primaryColor = Color("primaryColor")
    static let secondaryColor = Color("secondaryColor")
    static let background = Color("background")
    static let placeholder = Color("placeholder")
    static let labelBackground = Color("labelBackground")
    static let labelIconBackground = Color("labelIconBackground")
    static let optionsBackground = Color("optionsBackground")
    
    static let gradientBlue = LinearGradient(colors: [Color(hex: 0x62D9FF), Color(hex: 0xA4F4FF), Color(hex: 0x62D9FF)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let gradientYellow = LinearGradient(colors: [Color(hex: 0xFFD748), Color(hex: 0xFFE895), Color(hex: 0xFFD748)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let gradientOrange = LinearGradient(colors: [Color(hex: 0xFF5D43), Color(hex: 0xFF826D), Color(hex: 0xFF5D43)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let gradientPink = LinearGradient(colors: [Color(hex: 0xFF6287), Color(hex: 0xFF86D6), Color(hex: 0xFF6287)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let gradientGreen = LinearGradient(colors: [Color(hex: 0x39D620), Color(hex: 0x97FF86), Color(hex: 0x39D620)], startPoint: .bottomLeading, endPoint: .topTrailing)
    
}


