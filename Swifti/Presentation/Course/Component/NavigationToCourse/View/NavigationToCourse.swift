//
//  NavigationToCourse.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import SwiftUI

struct NavigationToCourse: View {
    @Environment(\.presentationMode) var presentationMode
    
    var title: String
    var difficulty: String
    var update: String
    var content: String
    var gradient: LinearGradient
    
    var body: some View {
        
        
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading, spacing: 5) {
                    Text(title)
                        .font(.defaultTitle2)
                        .foregroundColor(.white)
                    
                    InformationLabel(subject: difficulty, gradient: gradient)
                        .padding(.leading, 0.5)
                        .padding(.bottom, 10)
                    
                    Text("Dernière mise à jour : \(update)")
                        .font(.defaultPlaceholder)
                        .foregroundColor(.placeholder)
                        
                }
                
                Text(content)
                    .font(.defaultBody)
                    .foregroundColor(.white)
                
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: OptionButton(icon: "carret-left", action: {
            self.presentationMode.wrappedValue.dismiss()
        }).padding(.top, 5),
            trailing: OptionButton(icon: "carret-right", action: {
            
        }).padding(.top, 5))
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.background)
    }
}

struct NavigationToCourse_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToCourse(title: "Introduction au langage", difficulty: "Facile", update: "28 juillet 2023", content: "Lorem ipsum", gradient: Color.gradientBlue)
    }
}
