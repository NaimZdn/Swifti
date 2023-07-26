//
//  SettingsLabel.swift
//  Swifti
//
//  Created by Zidouni on 24/07/2023.
//

import SwiftUI

struct SettingsLabel: View {
    @EnvironmentObject private var appSettings: AppSettings
    
    @StateObject private var viewModel: SettingsViewModel
    
    var text: String
    var icon: String
    var isNavigation: Bool
    var isLink: Bool
    var notificationToggle: Bool
    
    init(appSettings: AppSettings, text: String, icon: String, isNavigation: Bool, isLink: Bool, notificationToggle: Bool) {
        
        self.text = text
        self.icon = icon
        self.isNavigation = isNavigation
        self.isLink = isLink
        
        self.notificationToggle = notificationToggle
        
        self._viewModel = StateObject(wrappedValue: SettingsViewModel(appSettings: appSettings))
        
    }
    
    
    var body: some View {
        HStack(spacing: 15) {
            Image(icon)
                .foregroundColor(.white)
            
            Text(text)
                .font(.settingsLabelText)
                .foregroundColor(.white)
            
            Spacer()
            
            if isNavigation {
                Image("carret-right")
                    .resizable()
                    .foregroundColor(.labelIconBackground)
                    .frame(width: 30, height: 30)
                
            }
            
            if isLink {
                Image("link")
                    .resizable()
                    .foregroundColor(.labelIconBackground)
                    .frame(width: 25, height: 25)
                
            }
            
            if notificationToggle {
                Toggle(isOn: $viewModel.isNotificationEnabled) {
                }
                .accessibilityAddTraits(.isSelected)
                .accessibilityLabel("Enabled notification")
                .onChange(of: viewModel.isNotificationEnabled) { enabled in
                    if enabled {
                        viewModel.openAppSettings()
                    } else {
                        viewModel.disabledNotification()
                    }
                }
                .toggleStyle(SwitchToggleStyle(tint: .primaryColor))
                .frame(width: 57)
            }
        }
        .accessibilityAddTraits(.isButton)
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, minHeight: 70)
        .background(Color.labelBackground, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

struct SettingsLabel_Previews: PreviewProvider {
    @StateObject private static var appSettings = AppSettings()
    static var previews: some View {
        SettingsLabel(appSettings: appSettings, text: "Activer les notifications", icon: "bell", isNavigation: false, isLink: false, notificationToggle: true)
            .environmentObject(appSettings)
    }
}
