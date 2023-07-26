//
//  TermsOfService.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import SwiftUI

struct TermsOfServiceView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var lastUpdated = "24.07.2023"
    @State private var terms = Term.allCases
    @State private var showBackground = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Conditions d'utilisations")
                    .font(.defaultTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)              .accessibilityAddTraits(.isHeader)
                
                Text("Last updated : \(lastUpdated)")
                    .font(.defaultLabelCaption)
                    .foregroundColor(.placeholder)
                    .padding(.bottom, 10)
                
                Text("En utilisant l'application Swifti, vous acceptez les présentes conditions d'utilisation. \n\nSi vous n'acceptez pas ces conditions, veuillez ne pas utiliser l'application.")
                .font(.defaultBody)
                .foregroundColor(.white)
                .padding(.bottom, 10)
                
                Divider()
                
                ForEach(terms.indices, id: \.self) { index in
                    let term = terms[index]
                    TermsSection(title: term.rawValue, content: term.content)
                    
                    if index != terms.indices.last {
                        Divider()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: OptionButton(icon: "carret-left", action: {
            self.presentationMode.wrappedValue.dismiss()
        }).padding(.top, 25))
        .padding(.horizontal, 20)
        .padding(.vertical, 30)
        .background(Color.background)   
    }
}

struct TermsOfService_Previews: PreviewProvider {
    static var previews: some View {
        TermsOfServiceView()
    }
}
