//
//  NavigationToArticleButton.swift
//  Swifti
//
//  Created by Zidouni on 27/07/2023.
//

import SwiftUI

struct NavigationToArticleButton: View {
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            
            Image(icon)
                .foregroundColor(.optionsIcon)
                .frame(width: 40, height: 40)
                .background(Color.articleButton, in: Circle())
        }
        .buttonStyle(.plain)
        
    }
}

struct NavigationToArticleButton_Previews: PreviewProvider {
    static var previews: some View {
        NavigationToArticleButton(icon: "carret-left", action: {})
    }
}
