//
//  FiltersView.swift
//  Swifti
//
//  Created by Zidouni on 01/08/2023.
//

import SwiftUI
import WrappingHStack

struct FiltersView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var articlesViewModel: ArticlesViewModel
    var filters: [FiltersArticles]
    
    @State private var selectedFilters: Set<FiltersArticles> = Set()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            HStack {
                Text("Filtres")
                    .font(.defaultTitle)
                    .foregroundColor(.white)
                
                Spacer()
                
                OptionButton(icon: "xmark") {
                    presentationMode.wrappedValue.dismiss()
                }
            }
            VStack(alignment: .leading) {
                Text("Sujets")
                    .font(.courseLabelTitle)
                    .foregroundColor(.white)
                WrappingHStack(filters, id: \.self, spacing: .constant(15), lineSpacing: 15) { filter in
                    FiltersLabel(isSelected: articlesViewModel.bindingForFilters(filter.rawValue), label: filter.rawValue) {
                        articlesViewModel.toggleFilter(filter: filter.rawValue)
                    }
                }
            }            
            Spacer()
            
            DeleteButton(caption: "Annuler les changements") {
                articlesViewModel.selectedFilters.removeAll()
                presentationMode.wrappedValue.dismiss()
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.background)
       
    }
}

struct FiltersView_Previews: PreviewProvider {
    static var previews: some View {
        FiltersView(articlesViewModel: ArticlesViewModel(), filters: FiltersArticles.allCases)
    }
}
