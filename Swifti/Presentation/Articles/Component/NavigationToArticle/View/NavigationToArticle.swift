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
    
    @ObservedObject var articlesViewModel: ArticlesViewModel
    
    @State private var index: Int
    
    init(articlesViewModel: ArticlesViewModel, index: Int) {
        self.articlesViewModel = articlesViewModel
        self._index = State(initialValue: index)
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ImageView(imageURL: URL(string: articlesViewModel.articles[index].cover)!)
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
                                
                                if index < articlesViewModel.articles.count - 1 {
                                    NavigationToArticleButton(icon: "carret-right") {
                                        if index < articlesViewModel.articles.count - 1 {
                                            index += 1
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .accessibilityAddTraits(.isImage)
                        .accessibilityLabel("Illustration de l'article")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(articlesViewModel.articles[index].title)
                            .font(.defaultTitle2)
                            .foregroundColor(.white)
                        
                        InformationLabel(subject: articlesViewModel.articles[index].subject, gradient: articlesViewModel.getLabelColor(subject: articlesViewModel.articles[index].subject))
                            .padding(.leading, 0.5)
                        
                        Text("Date de publication : \(articlesViewModel.articles[index].published)")
                            .font(.defaultPlaceholder)
                            .foregroundColor(.placeholder)
                    }
                    .accessibilityAddTraits(.isHeader)
                    
                    Text(try! AttributedString(markdown: articlesViewModel.articles[index].intro, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                        .tint(Color.primaryColor)
                        .font(.defaultBody)
                        .foregroundColor(.white)
                    
                    if let image = articlesViewModel.articles[index].image {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: 170)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    
                    ForEach(articlesViewModel.articles[index].sections, id: \.self) { section in
                        VStack(alignment: .leading, spacing: 15) {
                            Text(try! AttributedString(markdown: section.title, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                .font(.defaultTitle3)
                                .foregroundColor(.white)
                            
                            Text(try! AttributedString(markdown: section.text, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                .tint(Color.primaryColor)
                                .font(.defaultBody)
                                .foregroundColor(.white)
                            
                            if let image = section.image {
                                Image(image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, minHeight: 170)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .padding(.top, 15)
                            }
                            
                            
                            
                            if section.isCode == true {
                                let parserResult: ParserResult = {
                                    let document = Document(parsing: section.code!)
                                    var parser = MarkdownAttributedStringParser()
                                    return parser.parserResults(from: document)[0]
                                }()
                                CodeBlockView(parserResult: parserResult)
                            }
                            
                            if section.isSecondText == true {
                                Text(try! AttributedString(markdown: section.secondText!, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                    .tint(Color.primaryColor)
                                    .font(.defaultBody)
                                    .foregroundColor(.white)
                            }
                            
                            if section.isSecondCode == true {
                                let parserResult: ParserResult = {
                                    let document = Document(parsing: section.secondCode!)
                                    var parser = MarkdownAttributedStringParser()
                                    return parser.parserResults(from: document)[0]
                                }()
                                CodeBlockView(parserResult: parserResult)
                            }
                            
                            if section.isThirdText == true {
                                Text(try! AttributedString(markdown: section.thirdText!, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                    .tint(Color.primaryColor)
                                    .font(.defaultBody)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                    
                    Text(try! AttributedString(markdown: articlesViewModel.articles[index].outro, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                        .tint(Color.primaryColor)
                        .font(.defaultBody)
                        .foregroundColor(.white)
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: OptionButton(icon: "carret-left", action: {
                self.presentationMode.wrappedValue.dismiss()
            }).padding(.top, 5))
            .padding([.top, .horizontal], 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.background)
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    ImageView(imageURL: URL(string: articlesViewModel.articles[index].cover)!)
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
                                
                                if index < articlesViewModel.articles.count - 1 {
                                    NavigationToArticleButton(icon: "carret-right") {
                                        if index < articlesViewModel.articles.count - 1 {
                                            index += 1
                                        }
                                    }
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        .accessibilityAddTraits(.isImage)
                        .accessibilityLabel("Illustration de l'article")
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(articlesViewModel.articles[index].title)
                            .font(.defaultTitle2)
                            .foregroundColor(.white)
                        
                        InformationLabel(subject: articlesViewModel.articles[index].subject, gradient: articlesViewModel.getLabelColor(subject: articlesViewModel.articles[index].subject))
                            .padding(.leading, 0.5)
                        
                        Text("Date de publication : \(articlesViewModel.articles[index].published)")
                            .font(.defaultPlaceholder)
                            .foregroundColor(.placeholder)
                    }
                    .accessibilityAddTraits(.isHeader)
                    
                    Text(try! AttributedString(markdown: articlesViewModel.articles[index].intro, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                        .tint(Color.primaryColor)
                        .font(.defaultBody)
                        .foregroundColor(.white)
                    
                    if let image = articlesViewModel.articles[index].image {
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(maxWidth: .infinity, minHeight: 170)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    
                    ForEach(articlesViewModel.articles[index].sections, id: \.self) { section in
                        VStack(alignment: .leading, spacing: 15) {
                            Text(try! AttributedString(markdown: section.title, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                .font(.defaultTitle3)
                                .foregroundColor(.white)
                            
                            Text(try! AttributedString(markdown: section.text, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                .tint(Color.primaryColor)
                                .font(.defaultBody)
                                .foregroundColor(.white)
                            
                            if let image = section.image {
                                Image(image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(maxWidth: .infinity, minHeight: 170)
                                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                    .padding(.top, 15)
                            }
                            
                            
                            
                            if section.isCode == true {
                                let parserResult: ParserResult = {
                                    let document = Document(parsing: section.code!)
                                    var parser = MarkdownAttributedStringParser()
                                    return parser.parserResults(from: document)[0]
                                }()
                                CodeBlockView(parserResult: parserResult)
                            }
                            
                            if section.isSecondText == true {
                                Text(try! AttributedString(markdown: section.secondText!, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                    .tint(Color.primaryColor)
                                    .font(.defaultBody)
                                    .foregroundColor(.white)
                            }
                            
                            if section.isSecondCode == true {
                                let parserResult: ParserResult = {
                                    let document = Document(parsing: section.secondCode!)
                                    var parser = MarkdownAttributedStringParser()
                                    return parser.parserResults(from: document)[0]
                                }()
                                CodeBlockView(parserResult: parserResult)
                            }
                            
                            if section.isThirdText == true {
                                Text(try! AttributedString(markdown: section.thirdText!, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                    .tint(Color.primaryColor)
                                    .font(.defaultBody)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.bottom, 30)
                    }
                    
                    Text(try! AttributedString(markdown: articlesViewModel.articles[index].outro, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                        .tint(Color.primaryColor)
                        .font(.defaultBody)
                        .foregroundColor(.white)
                    
                }
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: OptionButton(icon: "carret-left", action: {
                self.presentationMode.wrappedValue.dismiss()
            }).padding(.top, 5))
            .padding(.top, 1)
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.background)
        }
        

    }
}

struct NavigationToArticle_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToArticle(articlesViewModel: ArticlesViewModel(), index: 0)
    }
}
