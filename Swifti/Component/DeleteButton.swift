//
//  DeleteButton.swift
//  Swifti
//
//  Created by Zidouni on 02/08/2023.
//

import SwiftUI

struct DeleteButton: View {
    var caption: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                action()
            }) {
                HStack(spacing: 15) {
                    Image(systemName: "xmark")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 12, height: 12)
                        .padding(.bottom, -2)
                    
                    Text(caption)
                        .font(.defaultLabelCaption)
                        .foregroundColor(Color.white)
                       
                }
                .frame(maxWidth: .infinity, minHeight: 55)
                .background(Color.secondaryColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                
            }
            .accessibilityLabel("Réinitialise tous les filtres")
            .buttonStyle(.plain)
            
        }
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButton(caption: "Annuler les changements", action: {})
    }
}
