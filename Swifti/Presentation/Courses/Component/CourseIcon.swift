//
//  CourseIcon.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import SwiftUI

struct CourseIcon: View {
    var icon: String
    var body: some View {
        VStack {
            Image(icon)
            
        }
        .frame(minWidth: 40, minHeight: 40)
        .background(Color.labelIconBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CourseIcon_Previews: PreviewProvider {
    static var previews: some View {
        CourseIcon(icon: "swift")
    }
}
