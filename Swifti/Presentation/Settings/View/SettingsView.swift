//
//  SettingsView.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var appSettings: AppSettings

    @State private var icon = "bell"
    @State private var text = "Activer les notifications"
    @State private var label = Label.allCases
    
    var body: some View {
            ZStack(alignment: .topTrailing) {
                Image("blobs")
                    .resizable()
                    .frame(width: 350, height: 400)
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 30) {
                    Text("Settings")
                        .font(.defaultTitle)
                        .foregroundColor(.white)

                    ScrollView {
                        VStack(alignment: .leading) {
                            Text("Réglages de l'application")
                                .font(.defaultBody)
                                .foregroundColor(.white)
                            
                            SettingsLabel(appSettings: appSettings, text: label[0].rawValue, icon: label[0].icon, isNavigation: false, isLink: false, notificationToggle: true)
                            
                        }
                        .padding(.bottom, 15)
                        
                        VStack(alignment: .leading) {
                            Text("Mentions légales")
                                .font(.defaultBody)
                                .foregroundColor(.white)
                            
                            SettingsLabel(appSettings: appSettings, text: label[1].rawValue, icon: label[1].icon, isNavigation: false, isLink: true, notificationToggle: false)
                            
                            NavigationLink(destination: AboutUsView()) {
                                SettingsLabel(appSettings: appSettings, text: label[2].rawValue, icon: label[2].icon, isNavigation: true, isLink: false, notificationToggle: false)
                            }
                            .accessibilityLabel("Navigation vers à propos de nous")
                            
                            NavigationLink(destination: PrivacyPolicyView()) {
                                SettingsLabel(appSettings: appSettings, text: label[3].rawValue, icon: label[3].icon, isNavigation: true, isLink: false, notificationToggle: false)
                            }
                            .accessibilityLabel("Navigation vers les politiques de confidentialités")
                            
                            NavigationLink(destination: TermsOfServiceView()) {
                                SettingsLabel(appSettings: appSettings, text: label[4].rawValue, icon: label[4].icon, isNavigation: true, isLink: false, notificationToggle: false)
                            }
                            .accessibilityLabel("Navigation vers les conditions d'utilisations")
                        }
                        
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 65)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .background(Color.background)
            .edgesIgnoringSafeArea(.top)
    }
}

struct SettingsView_Previews: PreviewProvider {
    @StateObject private static var appSettings = AppSettings()
    
    static var previews: some View {
        SettingsView()
            .environmentObject(appSettings)
    }
}
