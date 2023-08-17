//
//  SearchBar.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var placeholder: String
    
    func containsOnlySpaces(_ input: String) -> Bool {
        let trimmedInput = input.trimmingCharacters(in: .whitespaces)
        return trimmedInput.isEmpty
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Image("search")
                .foregroundColor(.optionsIcon)
            
            TextField("", text: $searchText, prompt: Text(placeholder).foregroundColor(.placeholder).font(.defaultPlaceholder))
                .font(.defaultBody)
                .foregroundColor(.white)
                .onChange(of: searchText) { text in
                    if containsOnlySpaces(text) {
                        searchText = ""
                    }
                }
            
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
        SearchBar(searchText: .constant(""), placeholder: "Recherchez un cours")
            .padding(20)
            .background(Color.background)
        
    }
}
