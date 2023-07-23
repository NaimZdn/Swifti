//
//  SwiftiApp.swift
//  Swifti
//
//  Created by Zidouni on 22/07/2023.
//

import SwiftUI

@main
struct SwiftiApp: App {
    let persistenceController = PersistenceController.shared
    @State var isShowingLaunchingScreen = true

    var body: some Scene {
        WindowGroup {
            if isShowingLaunchingScreen {
                LaunchScreenView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            self.isShowingLaunchingScreen = false
                        }
                    }
            } else {
                
            }
        }
    }
}
