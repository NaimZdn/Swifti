//
//  FiltersLabel.swift
//  Swifti
//
//  Created by Zidouni on 01/08/2023.
//

import SwiftUI

struct FiltersLabel: View {
    @Binding var isSelected: Bool
    
    var label: String
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                action()
            } label: {
                Text(label)
                    .font(.defaultPlaceholder)
                    .foregroundColor(isSelected ? .filterLabelSelectedText : .placeholder)
                    .frame(minWidth: 70, minHeight: 15)
                    .padding(10)
                    .background(isSelected ? Color.primaryColor.opacity(0.2) : Color.labelBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
            }
            .buttonStyle(.plain)

        }
    }
}

struct FiltersLabel_Previews: PreviewProvider {
    static var previews: some View {
        FiltersLabel(isSelected: .constant(true), label: "Astuces", action: {})
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.labelBackground)
    }
}
