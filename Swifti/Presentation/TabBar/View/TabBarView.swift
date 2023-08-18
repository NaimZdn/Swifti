//
//  TabBarView.swift
//  Swifti
//
//  Created by Zidouni on 06/08/2023.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var appSettings: AppSettings
    
    @ObservedObject var coursesViewModel: CourseViewModel
    @ObservedObject var articlesViewModel: ArticlesViewModel
    
    @State private var currentTab: TabBar = .home
    
    init(coursesViewModel: CourseViewModel, articlesViewModel: ArticlesViewModel) {
        self.articlesViewModel = articlesViewModel
        self.coursesViewModel = coursesViewModel
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                TabView(selection: $currentTab) {
                    HomeView(courseViewModel: coursesViewModel, articlesViewModel: articlesViewModel, currentTab: $currentTab)
                        .tag(TabBar.home)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("Home View")
                    
                    CourseView(courseViewModel: coursesViewModel)
                        .tag(TabBar.courses)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("Courses View")
                    
                    ArticlesView(articlesViewModel: articlesViewModel)
                        .tag(TabBar.articles)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("Articles View")
                    
                    SettingsView()
                        .environmentObject(appSettings)
                        .tag(TabBar.settings)
                        .accessibilityAddTraits(.isButton)
                        .accessibilityLabel("Settings View")
                }
                CustomTabBar(selectedTab: $currentTab)
            }
        }
        .navigationBarBackButtonHidden()
    }
}

struct TabBarView_Previews: PreviewProvider {
    @StateObject private static var appSettings = AppSettings()
    
    static var previews: some View {
        TabBarView(coursesViewModel: CourseViewModel(), articlesViewModel: ArticlesViewModel())
            .environmentObject(appSettings)
    }
}
