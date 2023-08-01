//
//  NavigationToArticle.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import SwiftUI
import Markdown

struct NavigationToArticle: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: ArticlesViewModel
    @State private var index: Int
    
    var text: String = "**Hello** *World*"
 
    var keyText: LocalizedStringKey = "**Hello** *World*"
    
    init(viewModel: ArticlesViewModel, index: Int) {
        self.viewModel = viewModel
        self._index = State(initialValue: index)
    }
    
    var paragraphStyle: NSParagraphStyle {
      let style = NSMutableParagraphStyle()
      style.alignment = .justified
      return style
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
                    
                    InformationLabel(subject: viewModel.articles[index].subject, gradient: viewModel.getLabelColor(subject: viewModel.articles[index].subject))
                        .padding(.leading, 0.5)
                    
                    Text("Date de publication : \(viewModel.articles[index].published)")
                        .font(.defaultPlaceholder)
                        .foregroundColor(.placeholder)
                }
                
                Text(try! AttributedString(markdown: viewModel.articles[index].intro, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                    .tint(Color.primaryColor)
                    .font(.defaultBody)
                    .foregroundColor(.white)
                    .padding(.bottom, 30)
                
                ForEach(viewModel.articles[index].sections, id: \.self) { section in
                    VStack(alignment: .leading, spacing: 15) {
                        Text(try! AttributedString(markdown: section.title, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                            .font(.defaultTitle3)
                            .foregroundColor(.white)
                        
                        Text(try! AttributedString(markdown: section.text, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                            .tint(Color.primaryColor)
                            .font(.defaultBody)
                            .foregroundColor(.white)
                        
                        if section.isCode == true {
                            let parserResult: ParserResult = {
                                let document = Document(parsing: section.code!)
                                var parser = MarkdownAttributedStringParser()
                                return parser.parserResults(from: document)[0]
                            }()
                            CodeBlockView(parserResult: parserResult)
                        }
                    }
                    .padding(.bottom, 30)
                    
                }
                
                Text(try! AttributedString(markdown: viewModel.articles[index].outro, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                    .tint(Color.primaryColor)
                    .font(.defaultBody)
                    .foregroundColor(.white)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: OptionButton(icon: "carret-left", action: {
            self.presentationMode.wrappedValue.dismiss()
        }).padding(.top, 5))
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

