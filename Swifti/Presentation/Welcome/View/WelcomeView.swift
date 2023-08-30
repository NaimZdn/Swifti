//
//  WelcomeView.swift
//  Swifti
//
//  Created by Zidouni on 23/07/2023.
//

import SwiftUI

struct WelcomeView: View {
    @ObservedObject private var viewModel = WelcomeViewModel()
    @ObservedObject var courseViewModel: CourseViewModel
    @ObservedObject var articlesViewModel: ArticlesViewModel
    
    @StateObject var appSettings: AppSettings
    
    @State private var currentTab: TabBar = .home
    @State private var userName = ""
    @State private var charactersLimit = 10
    @State private var isButtonVisible = false
    
    let dataController: DataController
    
    var counterColor: Color {
        let number = charactersLimit / 5
        let orangeInterval = charactersLimit - number
        
        if userName.count >= orangeInterval && userName.count != charactersLimit{
            return .orange
        } else if userName.count <= orangeInterval && userName.count != 0 && userName.count != charactersLimit {
            return.green
        } else if userName.count == charactersLimit {
            return .red
        } else {
            return .white
        }
    }
    
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Image("swifti-illustration")
                            .resizable()
                            .frame(width: 273, height: 282)
                            .padding(.top, 50)
                            .accessibilityLabel("Swifti illustration")
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hello 👋")
                                .font(.defaultTitle)
                                .foregroundColor(.white)
                            
                            Text("Quel est ton nom ?")
                                .font(.defaultTitle3)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 25)
                        
                        VStack(alignment: .trailing) {
                            TextField("", text: $userName, prompt: Text("Ex: Swifti").foregroundColor(.placeholder).font(.defaultPlaceholder))
                                .font(.defaultBody)
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .padding(.horizontal, 20)
                                .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .onChange(of: userName) { character in
                                    if character.count > charactersLimit {
                                        userName.removeLast()
                                    }
                                    if viewModel.containsOnlySpaces(userName) {
                                        userName = ""
                                    }
                                }
                                .accessibilityLabel("Entrez votre nom")
                            
                            Text("\(userName.count)/\(charactersLimit)")
                                .font(.defaultLabelCaption)
                                .foregroundColor(counterColor)
                        }
                        Spacer()
                    }
                    .navigationDestination(isPresented: $viewModel.isUserRegistered, destination: {
                        TabBarView(coursesViewModel: courseViewModel, articlesViewModel: articlesViewModel)
                            .environment(\.managedObjectContext, dataController.container.viewContext)
                            .environmentObject(appSettings)
                    })
                    .safeAreaInset(edge: .bottom, content: {
                        if !userName.isEmpty {
                            ValidateButton(caption: "C'est parti !") {
                                viewModel.addUserAndRedirectToHome(name: userName)
                            }
                            .disabled(userName.count == 0)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isButtonVisible = true
                                }
                            }
                            .onDisappear {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isButtonVisible = false
                                }
                            }
                            .frame(height: 50)
                            .padding(.top, 20)
                            .opacity(isButtonVisible ? 1 : 0)
                            .padding(.bottom, isButtonVisible ? 10 : -50)
                        }
                    })
                    .padding(20)
                    
                }
                .frame(maxWidth: .infinity)
                .background(Color.background)
            }
        } else {
            NavigationView {
                ScrollView(showsIndicators: false) {
                    VStack {
                        Image("swifti-illustration")
                            .resizable()
                            .frame(width: 273, height: 282)
                            .padding(.top, 50)
                            .accessibilityLabel("Swifti illustration")
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Hello 👋")
                                .font(.defaultTitle)
                                .foregroundColor(.white)
                            
                            Text("Quel est ton nom ?")
                                .font(.defaultTitle3)
                                .foregroundColor(.white)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 25)
                        
                        VStack(alignment: .trailing) {
                            TextField("", text: $userName, prompt: Text("Ex: Swifti").foregroundColor(.placeholder).font(.defaultPlaceholder))
                                .font(.defaultBody)
                                .foregroundColor(.white)
                                .frame(height: 50)
                                .padding(.horizontal, 20)
                                .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                                .onChange(of: userName) { character in
                                    if character.count > charactersLimit {
                                        userName.removeLast()
                                    }
                                    if viewModel.containsOnlySpaces(userName) {
                                        userName = ""
                                    }
                                }
                                .accessibilityLabel("Entrez votre nom")
                            
                            Text("\(userName.count)/\(charactersLimit)")
                                .font(.defaultLabelCaption)
                                .foregroundColor(counterColor)
                        }
                        Spacer()
                    }
                    NavigationLink(destination:  TabBarView(coursesViewModel: courseViewModel, articlesViewModel: articlesViewModel)
                        .environment(\.managedObjectContext, dataController.container.viewContext)
                        .environmentObject(appSettings))  {
                            
                            ValidateButton(caption: "C'est parti !") {
                                viewModel.addUserAndRedirectToHome(name: userName)
                            }
                            .disabled(userName.count == 0)
                            .onAppear {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isButtonVisible = true
                                }
                            }
                            .onDisappear {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    isButtonVisible = false
                                }
                            }
                            .opacity(isButtonVisible ? 1 : 0)
                            
                            .frame(height: 100)
                            
                        }
                }
                .navigationBarHidden(true)
                .ignoresSafeArea()
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity)
                .background(Color.background)
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView(courseViewModel: CourseViewModel(), articlesViewModel: ArticlesViewModel(), appSettings: AppSettings(), dataController: DataController.shared)
    }
}
