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
    static let optionsIcon = Color("optionsIcon")
    static let articleButton = Color("articleButton")
    
    static let gradientBlue = LinearGradient(colors: [Color(hex: 0x62D9FF), Color(hex: 0xA4F4FF), Color(hex: 0x62D9FF)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let gradientYellow = LinearGradient(colors: [Color(hex: 0xFFD748), Color(hex: 0xFFE895), Color(hex: 0xFFD748)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let gradientOrange = LinearGradient(colors: [Color(hex: 0xFF5D43), Color(hex: 0xFF826D), Color(hex: 0xFF5D43)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let gradientPink = LinearGradient(colors: [Color(hex: 0xFF6287), Color(hex: 0xFF86D6), Color(hex: 0xFF6287)], startPoint: .bottomLeading, endPoint: .topTrailing)
    static let gradientGreen = LinearGradient(colors: [Color(hex: 0x39D620), Color(hex: 0x97FF86), Color(hex: 0x39D620)], startPoint: .bottomLeading, endPoint: .topTrailing)
    
}

extension Font {
    
    static func fontLight(_ size: CGFloat) -> Font {
        Font.custom("Poppins-Light", size: size)
    }
    
    static func fontRegular(_ size: CGFloat) -> Font {
        Font.custom("Poppins-Regular", size: size)
    }
    
    static func fontMedium(_ size: CGFloat) -> Font {
        Font.custom("Poppins-Medium", size: size)
    }
    
    static func fontItalic(_ size: CGFloat) -> Font {
        Font.custom("Poppins-Italic", size: size)
    }
    
    static func fontSemiBold(_ size: CGFloat) -> Font {
        Font.custom("Poppins-SemiBold", size: size)
    }
    
    static func fontBold(_ size: CGFloat) -> Font {
        Font.custom("Poppins-Bold", size: size)
    }
    
    // MARK: - Default
      
    static var defaultPlaceholder = fontLight(14)
    static var defaultLabelCaption = fontRegular(15)
    static var defaultBody = fontRegular(17)
    static var defaultItalic = fontItalic(17)
    static var defaultButtonCaption = fontSemiBold(17)
    static var defaultTitle3 = fontSemiBold(20)
    static var defaultTitle2 = fontSemiBold(26)
    static var defaultTitle = fontSemiBold(30)
    
    // MARK: - Course Label
    
    static var courseLabelCounter = fontBold(10)
    static var courseLabelCaption = fontLight(13)
    static var courseLabelTitle = fontMedium(17)
    
    // MARK: - Articles Label
    
    static var articlesLabelCaption = fontLight(12)
    static var articlesLabelTitle = fontMedium(14)
    
    // MARK: - Articles Label
    
    static var settingsLabelText = fontLight(14)
    
}
