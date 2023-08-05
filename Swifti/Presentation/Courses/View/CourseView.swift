//
//  CourseView.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import SwiftUI

struct CourseView: View {
    @ObservedObject private var courseViewModel = CourseViewModel()
    @ObservedObject private var filtersViewModel = FiltersViewModel()
    
    @State private var visibleIndices: [Int] = []
    
    @State private var isFilterViewPresented = false
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
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
                            
                            Spacer()
                            
                            OptionButton(icon: "filter") {
                                isFilterViewPresented = true
                            }
                        }
                        SearchBar(searchText: $searchText, placeholder: "Rechercher un cours")
                        
                        .sheet(isPresented: $isFilterViewPresented) {
                            FiltersView(viewModel: filtersViewModel, filtersArticles: [], filtersCourses: FiltersCourses.allCases)
                                .presentationDetents([.medium])
                                .presentationDragIndicator(.visible)
                        }
                    }
                    .padding(.bottom, 10)
                    
                    ScrollView {
                        ForEach(Array(filtersViewModel.getFilteredCourses(courses: courseViewModel.courses).enumerated().filter { searchText.isEmpty ||  $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}), id: \.element) { (index, course) in
                            
                            let isVisible = visibleIndices.contains(index)
                            
                            NavigationLink(destination: NavigationToCourse(viewModel: courseViewModel, index: index)) {
                                CourseLabelRectangle(icon: course.icon, techno: course.techno, title: course.title)
                                    .opacity(isVisible ? 1 : 0)
                                    .padding(.top, isVisible ? 0 : 40)
                                    .onAppear {
                                        if index < 8 {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 * Double(index)) {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    visibleIndices.append(index)
                                                }
                                            }
                                        } else {
                                            visibleIndices.append(index)
                                        }
                                    }
                            }
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
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView()
    }
}
