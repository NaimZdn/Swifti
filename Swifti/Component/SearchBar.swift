//
//  SearchBar.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import SwiftUI

struct SearchBar: View {
    @State private var searchText = ""
    
    var body: some View {
        HStack(spacing: 20) {
            Image("search")
                .foregroundColor(.optionsIcon)

            TextField("", text: $searchText, prompt: Text("Recherchez un cours").foregroundColor(.placeholder).font(.defaultPlaceholder))
                .font(.defaultBody)
                .foregroundColor(.white)
            
            if !searchText.isEmpty {
                Image(systemName: "xmark")
                    .foregroundColor(.optionsIcon)
                    .onTapGesture {
                        searchText = ""
                    }
                
            }
        }
        .frame(height: 50)
        .padding(.horizontal, 20)
        .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 30, style: .continuous))
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
            .padding(20)
            .background(Color.background)
        
    }
}
