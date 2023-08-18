//
//  CheckboxToggleStyle.swift
//  Swifti
//
//  Created by Zidouni on 18/08/2023.
//

import Foundation
import SwiftUI

struct CheckboxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .stroke(lineWidth: 2)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .overlay {
                    if configuration.isOn {
                        RoundedRectangle(cornerRadius: 2, style: .continuous)
                            .foregroundColor(.primaryColor)
                            .padding(3.5)
                    }
                }
                .onTapGesture {
                    withAnimation(.spring()) {
                        configuration.isOn.toggle()
                    }
                }
            configuration.label
        }
    }
}
