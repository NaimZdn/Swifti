//
//  OptionButton.swift
//  Swifti
//
//  Created by Zidouni on 25/07/2023.
//

import SwiftUI

struct OptionButton: View {
    var icon: String
    var action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(icon)
                .foregroundColor(.white)
                .frame(maxWidth: 40, maxHeight: 40)
                .background(Color.optionsBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                
        }
        .frame(minWidth: 37, minHeight: 37)
        .buttonStyle(PlainButtonStyle())
    }
}

struct OptionButton_Previews: PreviewProvider {
    static var previews: some View {
        OptionButton(icon: "carret-left", action: {})
    }
}
