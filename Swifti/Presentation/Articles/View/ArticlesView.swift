//
//  ArticlesView.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import SwiftUI

struct ArticlesView: View {
    @StateObject private var viewModel = ArticlesViewModel()
    
    @State private var searchText = ""
    @State private var visibleIndices: [Int] = []

    var body: some View {
        
        NavigationView {
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
                                
                            }
                        }     
                        SearchBar(searchText: $searchText, placeholder: "Recherchez un article ")
                            .padding(.bottom, 10)
                        
                    }
                    .padding(.horizontal, 20)
                    
                    ScrollView(showsIndicators: false) {
                        ForEach(Array(viewModel.articles.enumerated().filter { searchText.isEmpty ||  $0.element.title.lowercased().contains(searchText.lowercased().trimmingCharacters(in: .whitespaces))}), id: \.element) { (index, article) in
                            
                            let isVisible = visibleIndices.contains(index)
                            
                            NavigationLink(destination: NavigationToArticle(viewModel: viewModel, index: index)) {
                                ArticlesLabel(cover: article.cover, title: article.title, subject: article.subject, gradient: viewModel.getLabelColor(subject: article.subject), intro: article.intro)
                                    .opacity(isVisible ? 1 : 0)
                                    .padding(.top, isVisible ? 0 : 20)
                                    .onAppear {
                                        if index < 8 {
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2 * Double(index)) {
                                                withAnimation(.easeInOut(duration: 0.4)) {
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
                    .padding(.horizontal, 20)
                }
            }
            .background(Color.background)
        }
    }
}

struct ArticlesView_Previews: PreviewProvider {
    static var previews: some View {
        ArticlesView()
    }
}
