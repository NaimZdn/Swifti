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
                .resizable()
                .foregroundColor(.white)
                .frame(width: 25, height: 25)
                
        }
        .frame(minWidth: 40, minHeight: 40)
        .background(Color.optionsBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .buttonStyle(PlainButtonStyle())
    }
}

struct OptionButton_Previews: PreviewProvider {
    static var previews: some View {
        OptionButton(icon: "filter", action: {})
    }
}
