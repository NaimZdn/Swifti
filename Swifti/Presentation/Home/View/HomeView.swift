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
    @Binding var currentTab: TabBar
    
    @ObservedObject private var viewModel = HomeViewModel()
    @State private var searchText = ""
    
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
                    
                    Text("Hello \(viewModel.userName)👋")
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
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(Array(courseViewModel.courses.enumerated().filter { searchText.isEmpty || $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}), id: \.element) { (index, course) in
                                    if index <= 2 {
                                        CourseLabelSquare(coursesViewModel: courseViewModel, index: index)
            
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
                                if index <= 1 {
                                    ArticlesLabel(articlesViewModel: articlesViewModel, cover: article.cover, title: article.title, subject: article.subject, gradient: articlesViewModel.getLabelColor(subject: article.subject), intro: article.intro, index: index)
                                }
                                
                            }
                        }
                        .padding(.leading, 20)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .navigationBarBackButtonHidden()
        .background(Color.background)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(courseViewModel: CourseViewModel(), articlesViewModel: ArticlesViewModel(), currentTab: .constant(.home))
    }
}
