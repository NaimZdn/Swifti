//
//  CodeBlockView.swift
//  Swifti
//
//  Created by Zidouni on 01/08/2023.
//

import SwiftUI
import Markdown

struct CodeBlockView: View {
    @State var isCopied = false
    
    let parserResult: ParserResult
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let codeBlockLanguage = parserResult.codeBlockLanguage {
                    Text(codeBlockLanguage.capitalized)
                        .font(.defaultPlaceholder)
                        .foregroundColor(.placeholder)
                }
                Spacer()
                
                Button {
                    let string = NSAttributedString(parserResult.attributedString).string
                    UIPasteboard.general.string = string
                    withAnimation {
                        isCopied = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            isCopied = false
                        }
                    }
                } label: {
                    Image(systemName: isCopied ? "checkmark.circle.fill" : "doc.on.doc")
                        .foregroundColor(.optionsIcon)
                    if isCopied {
                        Text("Copié !")
                            .foregroundColor(.white)
                            .font(.articlesLabelCaption)
                    }
                }
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel("Copiez le code")
            }
            .padding(.bottom, 10)
            .frame(maxHeight: 20)
            
            ScrollView(.horizontal, showsIndicators: true) {
                Text(parserResult.attributedString)
                    .textSelection(.enabled)
                
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

struct CodeBlockView_Previews: PreviewProvider {
    static var markdownString = """
    ```swift
    // Code difficile à maintenir
    
    var i = 1
    
    // Code maintenable
    
    var counter = 1
    ```
    """
    
    static let parserResult = {
        let document = Document(parsing: markdownString)
        var parser = MarkdownAttributedStringParser()
        return parser.parserResults(from: document)[0]
    }()
    
    static var previews: some View {
        CodeBlockView(parserResult: parserResult)
    }
}
