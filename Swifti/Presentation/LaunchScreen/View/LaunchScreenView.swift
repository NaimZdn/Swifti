//
//  LaunchScreenView.swift
//  Swifti
//
//  Created by Zidouni on 22/07/2023.
//

import SwiftUI

struct LaunchScreenView: View {

       var body: some View {
           ZStack {
               // Appliquer un dégradé comme masque sur le texte
            

               Color.gradientGreen
                   .mask(Text("Hello").font(.title)) // Utilisation du texte comme masque pour le dégradé
           }
       }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
