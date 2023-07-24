//
//  CourseLabelRectangle.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import SwiftUI

struct CourseLabelRectangle: View {
    var body: some View {
        HStack(spacing: 20) {
            CourseIcon(icon: "swift")
            
            VStack(alignment: .leading, spacing: -3) {
                Text("Swift")
                    .font(.courseLabelTitle)
                    .foregroundColor(.white)
                Spacer()
                Text("Introduction au langage")
                    .font(.courseLabelCaption)
                    .foregroundColor(.white)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
        .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

struct CourseLabelRectangle_Previews: PreviewProvider {
    static var previews: some View {
        CourseLabelRectangle()
    }
}
