//
//  CourseView.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import SwiftUI

struct CourseView: View {
    @StateObject private var viewModel = CourseViewModel()
    @State private var searchText = ""
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("blobs")
                .resizable()
                .frame(width: 350, height: 400)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 25) {
                    HStack {
                        Text("Course")
                            .font(.defaultTitle)
                            .foregroundColor(.white)
                    }
                    
                    SearchBar(searchText: $searchText, placeholder: "Rechercher un cours")
                    
                }
                .padding(.bottom, 10)
                
                ScrollView {
                    ForEach(Array(viewModel.courses.enumerated().filter { searchText.isEmpty || $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}), id: \.element) { (index, course) in
                        
                        CourseLabelRectangle(icon: course.icon, techno: course.techno, title: course.title)
                    }
                    .padding(.top, 10)
                }
               
                Spacer()
                
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        
        .background(Color.background)
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
