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
    
    @ObservedObject var viewModel: FiltersViewModel
    var filtersArticles: [FiltersArticles]
    var filtersCourses: [FiltersCourses]

    var selectedFilters: [String] {
        return viewModel.selectedFilters.union(filtersArticles.map(\.rawValue)).union(filtersCourses.map(\.rawValue)).sorted()
    }
    
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
                .accessibilityAddTraits(.isButton)
                .accessibilityLabel("Fermer")
                .accessibilityHint("Cliquer pour fermer la fenêtre")
            }
            VStack(alignment: .leading) {
                Text("Sujets")
                    .font(.courseLabelTitle)
                    .foregroundColor(.white)
                WrappingHStack(selectedFilters, id: \.self, spacing: .constant(15), lineSpacing: 15) { filter in
                    FiltersLabel(isSelected: viewModel.bindingForFilters(filter), label: filter) {
                        viewModel.toggleFilter(filter: filter)
                    }
                }
            }            
            Spacer()
            
            DeleteButton(caption: "Annuler les changements") {
                viewModel.selectedFilters.removeAll()
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
        FiltersView(viewModel: FiltersViewModel(), filtersArticles: FiltersArticles.allCases, filtersCourses: FiltersCourses.allCases)
    }
}
