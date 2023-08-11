//
//  NavigationToQuestions.swift
//  Swifti
//
//  Created by Zidouni on 08/08/2023.
//

import SwiftUI
import Markdown

struct NavigationToQuestions: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var coursesViewModel: CourseViewModel
    var questions: [CourseQuestion]
    var courseTitle: String
    
    @State private var checkedChoices: [[Bool]]
    @State private var selectedQuestionIndex: Int?
    @State private var selectedChoiceID: Int?
    @State private var selectedChoiceQuote: String?
    @State private var answerValidated = false
    @State private var score = 0
    @State private var currentQuestionIndex = 0
    
    init(coursesViewModel: CourseViewModel, questions: [CourseQuestion], courseTitle: String) {
        self.coursesViewModel = coursesViewModel
        self.questions = questions
        self.courseTitle = courseTitle
        self._checkedChoices = State(initialValue: Array(repeating: Array(repeating: false, count: questions[0].choices.count), count: questions.count))
    }
    
    func toggleChoice(_ questionIndex: Int, _ choiceIndex: Int) {
        for index in 0..<checkedChoices[questionIndex].count {
            checkedChoices[questionIndex][index] = (index == choiceIndex)
        }
        selectedChoiceID = checkedChoices[questionIndex].firstIndex(of: true).map { questions[questionIndex].choices[$0].id }
        
        selectedChoiceQuote = checkedChoices[questionIndex].firstIndex(of: true).map {
            questions[questionIndex].choices[$0].quote
        }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            if currentQuestionIndex < questions.count {
                let question = questions[currentQuestionIndex]
                
                
                
                Text(try! AttributedString(markdown: question.question, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                    .font(.defaultTitle3)
                    .foregroundColor(.white)
                
                if let code = question.code {
                    let parserResult: ParserResult = {
                        let document = Document(parsing: code)
                        var parser = MarkdownAttributedStringParser()
                        return parser.parserResults(from: document)[0]
                    }()
                    CodeBlockView(parserResult: parserResult)
                }
                
                VStack(alignment: .leading) {
                    ForEach(question.choices.indices, id: \.self) { choiceIndex in
                        Toggle(isOn: Binding(
                            get: { self.checkedChoices[currentQuestionIndex][choiceIndex] },
                            set: { newValue in self.toggleChoice(currentQuestionIndex, choiceIndex) }
                        )) {
                            Text(try! AttributedString(markdown: question.choices[choiceIndex].choice, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                                .font(.defaultBody)
                                .foregroundColor(.white)
                        }
                        .toggleStyle(CheckboxToggleStyle())
                        .disabled(answerValidated)
                    }
                }
                .padding(.bottom, 30)
                
                if answerValidated {
                    Text(try! AttributedString(markdown: selectedChoiceQuote ?? "", options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                        .font(.defaultItalic)
                        .foregroundColor(.white)
                }
                Spacer()
                if !answerValidated {
                    ValidateButton(caption: "Valider") {
                        if let selectedChoiceID = selectedChoiceID,
                           selectedChoiceID == question.answer {
                            score += 1
                            answerValidated = true
                        } else {
                            answerValidated = true
                        }
                    }
                    .disabled(checkedChoices[currentQuestionIndex].contains(true) ? false : true)
                } else {
                    ValidateButton(caption: "Question suivante") {
                        if currentQuestionIndex < questions.count - 1 {
                            currentQuestionIndex += 1
                            answerValidated = false
                            checkedChoices = Array(repeating: Array(repeating: false, count: questions[currentQuestionIndex].choices.count), count: questions.count)
                            
                            coursesViewModel.addScoreToData(courseTitle: courseTitle, score: score)
                            //print(coursesViewModel.coursesScore)
                        }
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: OptionButton(icon: "carret-left", action: {
                self.presentationMode.wrappedValue.dismiss()
            }).padding(.top, 5))
            .padding([.top, .horizontal], 20)
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.background)
        //.padding()
        //.background(Color.background)
        
    }
}


struct NavigationToQuestions_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToQuestions(coursesViewModel: CourseViewModel(), questions:
                                [CourseQuestion(
                                    question: "\n1. Ce code est-il correct ?",
                                    choices: [
                                        CourseQuestionChoice(
                                            id: 1,
                                            choice: "Oui",
                                            quote: "C'est exact 🎊 Le code est correct même si la convention de nommage n'est pas respectée."
                                        ),
                                        CourseQuestionChoice(
                                            id: 2,
                                            choice: "Non",
                                            quote: "Dommage 😕 Le code est correct même si la convention de nommage n'est pas respectée.")
                                    ],
                                    code: "```swift\nvar quote = \"I think therefore I am.\"\nlet second-quote = \"If you build it, they will come.\"",
                                    answer: 1),
                                 CourseQuestion(
                                     question: "\n2. Coucou 2 eme question",
                                     choices: [
                                         CourseQuestionChoice(
                                             id: 1,
                                             choice: "Oui",
                                             quote: "C'est faux"
                                         ),
                                         CourseQuestionChoice(
                                             id: 2,
                                             choice: "Non",
                                             quote: "Cool c'est ca")
                                     ],
                                     code: "```swift\nvar quote = \"I think therefore I am.\"\nlet second-quote = \"If you build it, they will come.\"",
                                     answer: 1)], courseTitle: "Introduction au langage Swift")
    }
}

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .stroke(lineWidth: 2)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .overlay {
                    if configuration.isOn {
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .foregroundColor(.primaryColor)
                            .padding(3.5)
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
 
            configuration.label
 
        }
    }
}