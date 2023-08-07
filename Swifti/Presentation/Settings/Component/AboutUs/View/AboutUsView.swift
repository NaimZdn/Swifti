//
//  AboutUsView.swift
//  Swifti
//
//  Created by Zidouni on 25/07/2023.
//

import SwiftUI
import WrappingHStack

struct AboutUsView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State private var caption = "My resume"
    @State private var showBackgroundHello = false
    @State private var showBackgroundTechno = false
    @State private var showBackgroundSocial = false
    @State private var technos = Techno.allCases
    @State var showGithub = false
    @State var showLinkedin = false
    
    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("Bonjour tout le monde")
                        .font(.defaultTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .accessibilityAddTraits(.isHeader)
                    
                    Text("Moi c'est Naïm, développeur iOS et designer Français.")
                        .font(.defaultBody)
                        .foregroundColor(.white)
                }
                .padding(.bottom, 20)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 25) {
                    Text("Techno utilisées")
                        .font(.defaultTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    WrappingHStack(technos, id: \.self, spacing: .constant(10), lineSpacing: 8) { techno in
                        TechnosLabel(techno: techno.rawValue)
                        
                    }
                }
                .padding(.bottom, 20)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 15) {
                    Text("Description de l'application")
                        .font(.defaultTitle)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Découvrez les dernières actualités iOS et apprenez les bases de la programmation avec Swifti ! Restez à jour avec les nouveautés d'Apple tout en vous initiant à la programmation iOS de manière interactive et amusante. \nCommencez votre apprentissage dès maintenant !")
                    .font(.defaultBody)
                    .foregroundColor(.white)
                    
                }
                .padding(.bottom, 20)
                
                Spacer()
                
            }
            HStack(alignment: .center, spacing: 50) {
                
                LinkButton(isPresented: $showLinkedin, icon: Link.linkedin.rawValue, link: Link.linkedin.link)
                
                
                LinkButton(isPresented: $showGithub, icon: Link.github.rawValue, link: Link.github.link)
            }
            .padding(.vertical, 20)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: OptionButton(icon: "carret-left", action: {
            self.presentationMode.wrappedValue.dismiss()
        }).padding(.top, 25))
        .padding([.top, .horizontal], 20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
    }
}

struct AboutUsView_Previews: PreviewProvider {
    static var previews: some View {
        AboutUsView()
    }
}
