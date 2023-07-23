//
//  WelcomeView.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject private var viewModel = WelcomeViewModel()
    @State private var userName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Image("swifti-illustration")
                    .resizable()
                    .frame(width: 273, height: 282)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text("Hello 👋")
                        .font(.defaultTitle)
                        .foregroundColor(.white)
                    
                    Text("Quel est ton nom ?")
                        .font(.defaultTitle3)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 30)
                
                TextField("", text: $userName, prompt: Text("Ex: swifti").foregroundColor(.placeholder).font(.defaultPlaceholder))
                    .font(.defaultBody)
                    .foregroundColor(.white)
                    .frame(height: 50)
                    .padding(.horizontal, 20)
                    .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Spacer()
                
                ValidateButton(caption: "C'est parti !") {
                    viewModel.addUserAndRedirectToHome(name: userName)
                }
                
            }
            .navigationDestination(isPresented: $viewModel.isUserRegistered, destination: {
                HomeView()
            })
            .padding(20)
            .frame(maxWidth: .infinity)
            .background(Color.background)
            
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
