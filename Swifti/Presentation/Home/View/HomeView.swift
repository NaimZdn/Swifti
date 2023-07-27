//
//  HomeView.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject private var viewModel = HomeViewModel()
    
    @State private var searchText = ""
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            Image("blobs")
                .resizable()
                .frame(width: 350, height: 400)
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading) {
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(viewModel.getCurrentDate())
                        .font(.defaultBody)
                        .foregroundColor(.white)
                    
                    Text("Hello \(viewModel.userName)👋")
                        .font(.defaultTitle2)
                        .foregroundColor(.white)
                    
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 25)
                
                SearchBar(searchText: $searchText, placeholder: "Recherchez un cours")
                    .padding(.horizontal, 20)
                    .padding(.bottom, 25)
                
                VStack(alignment: .leading, spacing: 30) {
                    VStack(spacing: 20) {
                        HStack {
                            Text("Vos derniers cours")
                                .font(.defaultBody)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Voir tout")
                                    .font(.defaultLabelCaption)
                                    .foregroundColor(.optionsIcon)
                            }
                            .buttonStyle(.plain)
                            
                        }
                        
                        VStack(spacing: 10) {
                            CourseLabelRectangle()
                            CourseLabelRectangle()
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    VStack(spacing: 20) {
                        HStack {
                            Text("Liste des cours")
                                .font(.defaultBody)
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                            Button {
                                
                            } label: {
                                Text("Voir tout")
                                    .font(.defaultLabelCaption)
                                    .foregroundColor(.optionsIcon)
                            }
                            .buttonStyle(.plain)
                        }
                        .padding(.horizontal, 20)
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                CourseLabelSquare()
                                CourseLabelSquare()
                                CourseLabelSquare()
                                
                            }
                        }
                        
                        .padding(.leading, 20)
                    }
                    
                }
                
                Spacer()
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
        }
        .background(Color.background)
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
