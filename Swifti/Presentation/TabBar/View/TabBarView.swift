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
                    
                    CourseView(courseViewModel: coursesViewModel)
                        .tag(TabBar.courses)
                    
                    ArticlesView(articlesViewModel: articlesViewModel)
                        .tag(TabBar.articles)
                    
                    SettingsView()
                        .environmentObject(appSettings)
                        .tag(TabBar.settings)
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
