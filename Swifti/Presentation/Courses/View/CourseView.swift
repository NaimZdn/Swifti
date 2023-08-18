//
//  CourseView.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import SwiftUI

struct CourseView: View {
    @ObservedObject var courseViewModel : CourseViewModel
    @ObservedObject private var filtersViewModel = FiltersViewModel()
    
    @State private var visibleIndices: [Int] = []
    @State private var isFilterViewPresented = false
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
                        Text("Cours")
                            .font(.defaultTitle)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        OptionButton(icon: "filter") {
                            isFilterViewPresented = true
                        }
                        .sheet(isPresented: $isFilterViewPresented) {
                            FiltersView(viewModel: filtersViewModel, filtersArticles: [], filtersCourses: FiltersCourses.allCases)
                                .presentationDetents([.medium])
                                .presentationDragIndicator(.visible)
                        }
                        .accessibilityLabel("Filtres")
                        .accessibilityHint("Cliquez pour affiner votre recherche")
                    }
                    
                    SearchBar(searchText: $searchText, placeholder: "Rechercher un cours")
                }
                .padding(.bottom, 10)
                
                if Array(filtersViewModel.getFilteredCourses(courses: courseViewModel.courses).enumerated().filter { searchText.isEmpty ||  $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}).isEmpty {
                    
                    VStack(spacing: 20) {
                        Spacer()
                        Image("courses-outline")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(Color.placeholder)
                        
                        Text("Aucun cours n'a été trouvé")
                            .font(.defaultTitle3)
                            .foregroundColor(.placeholder)
                        
                        Spacer()
                        
                    }
                    .accessibilityAddTraits(.isSummaryElement)
                    .frame(maxWidth: .infinity)
                } else {
                    ScrollView {
                        ForEach(Array(filtersViewModel.getFilteredCourses(courses: courseViewModel.courses).enumerated().filter { searchText.isEmpty ||  $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}), id: \.element) { (index, course) in
                            
                            let isVisible = visibleIndices.contains(index)
                            
                            CourseLabelRectangle(coursesViewModel: courseViewModel, icon: course.icon, techno: course.techno, title: course.title, index: index)
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
                        .padding(.top, 10)
                    }
                    Spacer()
                }
            }
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.background)
    }
}

struct CourseView_Previews: PreviewProvider {
    static var previews: some View {
        CourseView(courseViewModel: CourseViewModel())
    }
}
