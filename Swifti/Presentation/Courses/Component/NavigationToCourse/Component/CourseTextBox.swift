//
//  CourseTextBox.swift
//  Swifti
//
//  Created by Zidouni on 13/08/2023.
//

import SwiftUI
import Markdown

struct CourseTextBox: View {
    var text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Text("💡")
                .font(.defaultTitle)
    
            Text(try! AttributedString(markdown: text, options: AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)))
                .font(.defaultBody)
                .foregroundColor(.white)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 15)
        .background(Color.yellow.opacity(0.15), in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        
    }
}

struct CourseTextBox_Previews: PreviewProvider {
    static var previews: some View {
        CourseTextBox(text: "Sachez qu’il est toujours **préférable d’utiliser des constantes que des variables** afin d’optimiser davantage notre code. De plus, si vous souhaitez modifier une constante Swift et Xcode vous préviendront.")
            .padding(30)
            .background(Color.background)
    }
    
}
