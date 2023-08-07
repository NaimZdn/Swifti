//
//  CourseLabelRectangle.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import SwiftUI

struct CourseLabelRectangle: View {
    @ObservedObject var coursesViewModel: CourseViewModel
    var icon: String
    var techno: String
    var title: String
    var index: Int
    
    var body: some View {
        NavigationLink {
            NavigationToCourse(viewModel: coursesViewModel, index: index)
        } label: {
            HStack(spacing: 20) {
                CourseIcon(icon: icon)
                
                VStack(alignment: .leading, spacing: -3) {
                    Text(techno)
                        .font(.courseLabelTitle)
                        .foregroundColor(.white)
                    Spacer()
                    Text(title)
                        .font(.courseLabelCaption)
                        .foregroundColor(.white)
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: 80, alignment: .leading)
            .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
        }
    }
}

struct CourseLabelRectangle_Previews: PreviewProvider {
    static var previews: some View {
        CourseLabelRectangle(coursesViewModel: CourseViewModel(), icon: "swift", techno: "Swift", title: "Introduction au langage", index: 0)
    }
}
