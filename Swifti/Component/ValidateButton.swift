//
//  ValidateButton.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import SwiftUI

struct ValidateButton: View {
    var caption: String
    var action: () -> Void
    
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(caption)
                    .font(.defaultButtonCaption)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(Color.primaryColor, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .buttonStyle(.plain)
            
        }
    }
}

struct ValidateButton_Previews: PreviewProvider {
    static var previews: some View {
        ValidateButton(caption: "C'est parti !", action: {})
            .padding(.horizontal, 20)
    }
}
