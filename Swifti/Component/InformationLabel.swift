//
//  InformationLabel.swift
//  Swifti
//
//  Created by Zidouni on 26/07/2023.
//

import SwiftUI

struct InformationLabel: View {
    var subject: String
    var gradient: LinearGradient
    
    var body: some View {
        HStack {
            Text(subject)
                .font(.articlesLabelCaption)
                .padding(.vertical, 2)
                .padding(.horizontal, 20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(gradient, lineWidth: 1)
                )
                .overlay {
                    gradient
                }
                .mask {
                    Text(subject)
                        .font(.articlesLabelCaption)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(gradient, lineWidth: 1)
                        )  
                }
        }
        .frame(maxHeight: 30, alignment: .leading)
        .accessibilityAddTraits(.isSummaryElement)
        .accessibilityLabel(subject)
    }
}

struct InformationLabel_Previews: PreviewProvider {
    static var previews: some View {
        InformationLabel(subject: "Astuces", gradient: Color.gradientBlue)
    }
}
