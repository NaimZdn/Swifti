//
//  TechnosLabel.swift
//  Swifti
//
//  Created by Zidouni on 25/07/2023.
//

import SwiftUI

struct TechnosLabel: View {
    var techno: String
    
    var body: some View {
        HStack {
            Text(techno)
                .font(.defaultLabelCaption)
                .foregroundColor(.white)
                .padding(.horizontal, 10)
                .padding(.vertical, 5)
                
                .overlay {
                    RoundedRectangle(cornerRadius: 5)
                        .stroke(Color.white, lineWidth: 1)
                }
        }
        .accessibilityAddTraits(.isImage)
        .accessibilityLabel(techno)
    }
}

struct TechnosLabel_Previews: PreviewProvider {
    static var previews: some View {
        TechnosLabel(techno: "Combine")
    }
}
