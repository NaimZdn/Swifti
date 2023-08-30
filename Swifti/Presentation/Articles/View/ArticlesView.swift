//
//  ArticlesView.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import SwiftUI

struct ArticlesView: View {    
    @ObservedObject var articlesViewModel : ArticlesViewModel
    @ObservedObject private var filtersViewModel = FiltersViewModel()
    
    @State private var isFilterViewPresented = false
    @State private var searchText = ""
    @State private var visibleIndices: [Int] = []
    @State var isScrollViewLoading = true
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image("blobs")
                .resizable()
                .frame(width: 350, height: 400)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading, spacing: 10) {
                VStack(alignment: .leading, spacing: 25) {
                    HStack {
                        Text("Articles")
                            .font(.defaultTitle)
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        OptionButton(icon: "filter") {
                            isFilterViewPresented = true
                        }
                        .sheet(isPresented: $isFilterViewPresented) {
                            if #available(iOS 16.0, *) {
                                FiltersView(viewModel: filtersViewModel, filtersArticles: FiltersArticles.allCases, filtersCourses: [])
                                    .presentationDetents([.medium])
                                    .presentationDragIndicator(.visible)
                            } else {
                                FiltersView(viewModel: filtersViewModel, filtersArticles: FiltersArticles.allCases, filtersCourses: [])
                                
                            }
                        }
                    }
                    .accessibilityLabel("Filtres")
                    .accessibilityHint("Cliquez pour affiner votre recherche")
                    
                    SearchBar(searchText: $searchText, placeholder: "Recherchez un article ")
                        .padding(.bottom, 10)
                    
                }
                .padding(.horizontal, 20)
                
                if Array(filtersViewModel.getFilteredArticles(articles: articlesViewModel.articles).enumerated().filter { searchText.isEmpty ||  $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}).isEmpty {
                    
                    VStack(spacing: 20) {
                        Spacer()
                        Image("articles-outline")
                            .resizable()
                            .frame(width: 120, height: 120)
                            .foregroundColor(Color.placeholder)
                        
                        Text("Aucun article n'a été trouvé")
                            .font(.defaultTitle3)
                            .foregroundColor(.placeholder)
                        
                        Spacer()
                        
                    }
                    .accessibilityAddTraits(.isSummaryElement)
                    .frame(maxWidth: .infinity)
                    
                } else {
                    ScrollView(showsIndicators: false) {
                        ForEach(Array(filtersViewModel.getFilteredArticles(articles: articlesViewModel.articles).enumerated().filter { searchText.isEmpty ||  $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}), id: \.element) { (index, article) in
                            
                            let isVisible = visibleIndices.contains(index)
                            
                            ArticlesLabel(articlesViewModel: articlesViewModel, cover: article.cover, title: article.title, subject: article.subject, gradient: articlesViewModel.getLabelColor(subject: article.subject), intro: article.intro, index: index)
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
                                .redacted(reason: isScrollViewLoading ? .placeholder : .init())
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                                        withAnimation(.easeInOut(duration: 0.5)) {
                                            isScrollViewLoading = false
                                            
                                        }
                                    }
                                }
                                .disabled(isScrollViewLoading ? true : false)
                        }
                        .padding(.top, 10)
                    }
                    .padding(.horizontal, 20)
                    
                }
            }
            .padding(.top, 65)
        }
        .background(Color.background)
        .edgesIgnoringSafeArea(.top)
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView(articlesViewModel: ArticlesViewModel())
    }
}
