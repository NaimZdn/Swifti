//
//  CourseLabelSquare.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import SwiftUI

struct CourseLabelSquare: View {
    @ObservedObject var coursesViewModel: CourseViewModel
    var index: Int
    
    var body: some View {
        NavigationLink {
            NavigationToCourse(viewModel: coursesViewModel, index: index)
        } label: {
            VStack(alignment: .leading) {
                HStack {
                    CourseIcon(icon: coursesViewModel.courses[index].icon)
                    Spacer()
                    CircularProgressBar(progress: coursesViewModel.progressBar(score: coursesViewModel.coursesScore[coursesViewModel.courses[index].title] ?? 0, numberOfQuestions: coursesViewModel.courses[index].questions.count), score: coursesViewModel.coursesScore[coursesViewModel.courses[index].title] ?? 0, numberOfquestions: coursesViewModel.courses[index].questions.count)
                        .frame(width: 40, height: 40)
                    
                }
                VStack(alignment: .leading) {
                    Text(coursesViewModel.courses[index].techno)
                        .font(.courseLabelTitle)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                    
                    Text(coursesViewModel.courses[index].title)
                        .font(.courseLabelCaption)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(15)
            .frame(width: 150, height: 150)
            .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 25, style: .continuous))
            .accessibilityAddTraits(.isButton)
            .accessibilityLabel("Cours")
            .accessibilityHint("Cliquez pour aller vers le cours sélectionné")
            
        }
    }
}

struct CourseLabelSquare_Previews: PreviewProvider {
    static var previews: some View {
        CourseLabelSquare(coursesViewModel: CourseViewModel(), index: 0)
    }
}
