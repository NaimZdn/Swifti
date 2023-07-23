//
//  SwiftiApp.swift
//  Swifti
//
//  Created by Zidouni on 22/07/2023.
//

import SwiftUI

@main
struct SwiftiApp: App {
    @State private var isShowingLaunchingScreen = true
    @State private var isUserLoggedIn = false

    let dataController = DataController.shared

    var body: some Scene {
        WindowGroup {
            if isShowingLaunchingScreen {
                LaunchScreenView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .preferredColorScheme(.dark)
                    .opacity(isShowingLaunchingScreen ? 1 : 0 )
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeInOut(duration: 2.5)) {
                                self.isShowingLaunchingScreen = false
                                self.checkUserLoggedIn()
                            }
                        }
                    }
            } else if !isUserLoggedIn {
                WelcomeView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .preferredColorScheme(.dark)
            } else {
                HomeView()
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .preferredColorScheme(.dark)
            }
        }
    }

    func checkUserLoggedIn() {
        isUserLoggedIn = !(dataController.getUserName()?.isEmpty ?? true)
    }
}
