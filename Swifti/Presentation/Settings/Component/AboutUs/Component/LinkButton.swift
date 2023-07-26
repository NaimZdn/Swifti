//
//  LinkButton.swift
//  Swifti
//
//  Created by Zidouni on 25/07/2023.
//

import SwiftUI

struct LinkButton: View {
    @Binding var isPresented: Bool
    
    var icon: String
    var link: String
    
    var body: some View {
        Button {
            self.isPresented.toggle()
        } label: {
            Image(icon)
                .resizable()
                .foregroundColor(.white)
                .frame(width: 30, height: 30)
        }
        .accessibilityAddTraits(.isLink)
        .accessibilityLabel("Link to \(icon)")
        .sheet(isPresented: $isPresented) {
            SafariRepresentable(url: link)
        }
    }
}

struct LinkButton_Previews: PreviewProvider {
    static var previews: some View {
        LinkButton(isPresented: .constant(false), icon: "linkedin", link: "https://www.linkedin.com/in/naim-zidouni/")
    }
}
