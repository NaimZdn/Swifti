//
//  PrivacyPolicyView.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var lastUpdated = "24.06.2023"
    @State private var privacyPolicy = PrivacyPolicy.allCases
    @State private var showBackground = false
    
    var body: some View {
        
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text("Politique de confidentialité")
                    .font(.defaultTitle)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .accessibilityAddTraits(.isHeader)
                
                Text("Dernière mise à jour : \(lastUpdated)")
                    .font(.defaultLabelCaption)
                    .foregroundColor(.placeholder)
                    .padding(.bottom, 10)
                
                Text("Votre vie privée est essentielle pour nous. Cette politique de confidentialité explique comment nous recueillons, utilisons, divulguons, stockons et protégeons vos informations personnelles lorsque vous utilisez notre application Swifti. \n\nVeuillez lire attentivement cette politique de confidentialité avant d'utiliser l'application.")
                    .font(.defaultBody)
                    .foregroundColor(.white)
                    .padding(.bottom, 10)
                
                Divider()
                
                ForEach(privacyPolicy.indices, id: \.self) { index in
                    let policy = privacyPolicy[index]
                    TermsSection(title: policy.rawValue, content: policy.content)
                    
                    if index != privacyPolicy.indices.last {
                        Divider()
                    }
                }
                .accessibilityAddTraits(.isSummaryElement)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: OptionButton(icon: "carret-left", action: {
            self.presentationMode.wrappedValue.dismiss()
        }).padding(.top, 25))
        .padding([.top, .horizontal], 20)
        .background(Color.background)
        
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
