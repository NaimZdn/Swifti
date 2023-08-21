//
//  SwiftiApp.swift
//  Swifti
//
//  Created by Zidouni on 22/07/2023.
//

import SwiftUI
import Firebase
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
}

@main
struct SwiftiApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @ObservedObject private var courseViewModel = CourseViewModel()
    @ObservedObject private var articlesViewModel = ArticlesViewModel()
    
    @StateObject private var appSettings = AppSettings()
    
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
                WelcomeView(courseViewModel: courseViewModel, articlesViewModel: articlesViewModel, appSettings: appSettings, dataController: DataController.shared)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .preferredColorScheme(.dark)
            } else {
                TabBarView(coursesViewModel: courseViewModel, articlesViewModel: articlesViewModel)
                    .environment(\.managedObjectContext, dataController.container.viewContext)
                    .environmentObject(appSettings)
                    .preferredColorScheme(.dark)
            }
        }
    }

    func checkUserLoggedIn() {
        isUserLoggedIn = !(dataController.getUserName()?.isEmpty ?? true)
    }
}
