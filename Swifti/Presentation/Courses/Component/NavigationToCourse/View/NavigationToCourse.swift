//
//  NavigationToCourse.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import SwiftUI
import Markdown

struct NavigationToCourse: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: CourseViewModel
    var index: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.courses[index].title)
                        .font(.defaultTitle2)
                        .foregroundColor(.white)
                    
                    InformationLabel(subject: viewModel.courses[index].difficulty, gradient: viewModel.getLabelColor(subject: viewModel.courses[1].difficulty))
                        .padding(.leading, 0.5)
                        .padding(.bottom, 10)
                    
                    Text("Dernière mise à jour : \(viewModel.courses[index].update)")
                        .font(.defaultPlaceholder)
                        .foregroundColor(.placeholder)
                    
                }
                Text(try! AttributedString(markdown: viewModel.courses[index].intro, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                    .font(.defaultBody)
                    .foregroundColor(.white)
                
                ForEach(viewModel.courses[index].sections, id: \.self) { section in
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text(try! AttributedString(markdown: section.title, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                            .font(.defaultTitle3)
                            .foregroundColor(.white)
                        
                        if let firstText = section.firstText {
                            Text(try! AttributedString(markdown: firstText, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                .font(.defaultBody)
                                .foregroundColor(.white)
                        }
                        
                        if let firstCode = section.firstCode {
                            let parserResult: ParserResult = {
                                let document = Document(parsing: firstCode)
                                var parser = MarkdownAttributedStringParser()
                                return parser.parserResults(from: document)[0]
                            }()
                            CodeBlockView(parserResult: parserResult)
                        }
                        
                        if let secondText = section.secondText {
                            Text(try! AttributedString(markdown: secondText, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                .font(.defaultBody)
                                .foregroundColor(.white)
                        }
                        
                        if let firstTextBox = section.firstTextBox {
                            Text(try! AttributedString(markdown: firstTextBox, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                .font(.defaultBody)
                                .foregroundColor(.white)
                        }
                        
                        if let subsections = section.subsections as? [CourseSubsection] {
                            ForEach(subsections, id: \.self) { subsection in
                                Text(try! AttributedString(markdown: subsection.subtitle, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                    .font(.defaultTitle4)
                                    .foregroundColor(.white)
                                
                                Text(try! AttributedString(markdown: subsection.firstText, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                    .font(.defaultBody)
                                    .foregroundColor(.white)
                                
                                if let firstCode = subsection.firstCode {
                                    let parserResult: ParserResult = {
                                        let document = Document(parsing: firstCode)
                                        var parser = MarkdownAttributedStringParser()
                                        return parser.parserResults(from: document)[0]
                                    }()
                                    CodeBlockView(parserResult: parserResult)
                                }
                                
                                if let secondText = subsection.secondText {
                                    Text(try! AttributedString(markdown: secondText, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                        .font(.defaultBody)
                                        .foregroundColor(.white)
                                }
                                
                                if let secondCode = subsection.secondCode {
                                    let parserResult: ParserResult = {
                                        let document = Document(parsing: secondCode)
                                        var parser = MarkdownAttributedStringParser()
                                        return parser.parserResults(from: document)[0]
                                    }()
                                    CodeBlockView(parserResult: parserResult)
                                }
                                
                                if let thirdText = subsection.thirdText {
                                    Text(try! AttributedString(markdown: thirdText, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                        .font(.defaultBody)
                                        .foregroundColor(.white)
                                    
                                }
                            }
                        }
                    }
                }
                if let outro = viewModel.courses[index].outro {
                    Text(try! AttributedString(markdown: outro, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                        .font(.defaultBody)
                        .foregroundColor(.white)
                }
                
                
                
                NavigationLink(destination: NavigationToQuestions(coursesViewModel: viewModel, questions: viewModel.courses[index].questions, courseTitle: viewModel.courses[index].title)) {
                    
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: OptionButton(icon: "carret-left", action: {
                self.presentationMode.wrappedValue.dismiss()
            }).padding(.top, 5),
            trailing:  NavigationLink(destination: NavigationToQuestions(coursesViewModel: viewModel, questions: viewModel.courses[index].questions, courseTitle: viewModel.courses[index].title)) {
                VStack {
                    Image("carret-right")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 25, height: 25)
                }
                .frame(minWidth: 40, minHeight: 40)
                .background(Color.optionsBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            }).padding(.top, 5)
        
            .padding([.top, .horizontal], 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.background)
        
    }
}

struct NavigationToCourse_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToCourse(viewModel: CourseViewModel(), index: 1)
    }
}
