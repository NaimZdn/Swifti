//
//  CourseLabelSquare.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import SwiftUI

struct CourseLabelSquare: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                CourseIcon(icon: "swift")
                Spacer()
                CourseIcon(icon: "swift")
                
            }

            VStack(alignment: .leading) {
                Text("Swift")
                    .font(.courseLabelTitle)
                    .foregroundColor(.white)
                
                Text("Les tableaux")
                    .font(.courseLabelCaption)
                    .foregroundColor(.white)
            }
        }
        .padding(15)
        .frame(width: 150, height: 150)
        .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}

struct CourseLabelSquare_Previews: PreviewProvider {
    static var previews: some View {
        CourseLabelSquare()
    }
}
