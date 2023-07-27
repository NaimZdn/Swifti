//
//  NavigationToArticle.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import SwiftUI

struct NavigationToArticle: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: ArticlesViewModel
    @State private var index: Int
    
    init(viewModel: ArticlesViewModel, index: Int) {
        self.viewModel = viewModel
        self._index = State(initialValue: index)
    }
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                ImageView(imageURL: URL(string: viewModel.articles[index].cover)!)
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: 180)
                    .cornerRadius(20)
                    .clipped()
                    .overlay {
                        HStack {
                            if index > 0 {
                                NavigationToArticleButton(icon: "carret-left") {
                                    if index > 0 {
                                        index -= 1
                                    }
                                }
                            }
                            Spacer()
                            
                            if index < viewModel.articles.count - 1 {
                                NavigationToArticleButton(icon: "carret-right") {
                                    if index < viewModel.articles.count - 1 {
                                        index += 1
                                    }
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(viewModel.articles[index].title)
                        .font(.defaultTitle2)
                        .foregroundColor(.white)
                    
                    ArticlesSubjectLabel(subject: viewModel.articles[index].subject, gradient: viewModel.getLabelColor(subject: viewModel.articles[index].subject))
                }
                
                Text(viewModel.articles[index].content)
                    .font(.defaultBody)
                    .foregroundColor(.white)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: OptionButton(icon: "carret-left", action: {
            self.presentationMode.wrappedValue.dismiss()
        }).padding(.top, 25))
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
    }
}

struct NavigationToArticle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToArticle(viewModel: ArticlesViewModel(), index: 0)
    }
}
