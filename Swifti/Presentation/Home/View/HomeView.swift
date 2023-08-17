//
//  HomeView.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var courseViewModel: CourseViewModel
    @ObservedObject var articlesViewModel: ArticlesViewModel
    @ObservedObject private var viewModel = HomeViewModel()
    
    @Binding var currentTab: TabBar
    
    @State private var searchText = ""
    @State private var isArticlesLoading = true
    @State private var visibleArticlesIndices: [Int] = []
    @State private var visibleCoursesIndices: [Int] = []
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            Image("blobs")
                .resizable()
                .frame(width: 350, height: 400)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.getCurrentDate())
                        .font(.defaultBody)
                        .foregroundColor(.white)
                    
                    Text("Hello \(viewModel.userName) 👋")
                        .font(.defaultTitle2)
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 25)
                
                SearchBar(searchText: $searchText, placeholder: "Recherchez un cours")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)
                
                VStack(alignment: .leading, spacing: 30) {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Liste des cours")
                                .font(.defaultBody)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                currentTab = .courses
                            } label: {
                                Text("Voir tout")
                                    .font(.defaultLabelCaption)
                                    .foregroundColor(.optionsIcon)
                            }
                            .buttonStyle(.plain)
                        }
                        if Array(courseViewModel.courses.enumerated().filter { searchText.isEmpty || $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}).isEmpty {
                            
                            VStack {
                                Text("Aucun cours n'a été trouvé")
                                    .font(.defaultTitle4)
                                    .foregroundColor(.white)
                                
                            }
                        } else {
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 10) {
                                    ForEach(Array(courseViewModel.courses.enumerated().filter { searchText.isEmpty || $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}), id: \.element) { (index, course) in
                                        
                                        let isVisible = visibleCoursesIndices.contains(index)
                                        
                                        if index <= 2 {
                                            CourseLabelSquare(coursesViewModel: courseViewModel, index: index)
                                                .opacity(isVisible ? 1 : 0)
                                                .padding(.leading, isVisible ? 0 : 70)
                                                .onAppear {
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5 * Double(index)) {
                                                        withAnimation(.easeInOut(duration: 0.5)) {
                                                            visibleCoursesIndices.append(index)
                                                        }
                                                    }
                                                }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 20) {
                        HStack {
                            Text("Les derniers articles")
                                .font(.defaultBody)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                currentTab = .articles
                            } label: {
                                Text("Voir tout")
                                    .font(.defaultLabelCaption)
                                    .foregroundColor(.optionsIcon)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView(showsIndicators: false) {
                            ForEach(Array(articlesViewModel.articles.enumerated()), id: \.element) { (index, article) in
                                
                                let isVisible = visibleArticlesIndices.contains(index)
                                
                                if index <= 1 {
                                    ArticlesLabel(articlesViewModel: articlesViewModel, cover: article.cover, title: article.title, subject: article.subject, gradient: articlesViewModel.getLabelColor(subject: article.subject), intro: article.intro, index: index)
                                        .opacity(isVisible ? 1 : 0)
                                        .padding(.top, isVisible ? 0 : 40)
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3 * Double(index)) {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    visibleArticlesIndices.append(index)
                                                }
                                            }
                                        }
                                        .redacted(reason: isArticlesLoading ? .placeholder : .init())
                                        .onAppear {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                                                withAnimation(.easeInOut(duration: 0.5)) {
                                                    isArticlesLoading = false
                                                    
                                                }
                                            }
                                        }
                                        .disabled(isArticlesLoading ? true : false)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color.background)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(courseViewModel: CourseViewModel(), articlesViewModel: ArticlesViewModel(), currentTab: .constant(.home))
    }
}
