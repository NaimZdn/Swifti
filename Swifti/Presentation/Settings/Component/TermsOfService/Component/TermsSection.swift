//
//  TermsSection.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import SwiftUI

struct TermsSection: View {
    var title: String
    var content: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.defaultTitle3)
                .foregroundColor(.white)
            
            Text("\(content)")
           
            .font(.defaultBody)
            .foregroundColor(.white)
            .padding(.bottom, 10)
        }
    }
}

struct TermsSection_Previews: PreviewProvider {
    static var previews: some View {
        TermsSection(title: "Content", content: "Hello world")
    }
}
