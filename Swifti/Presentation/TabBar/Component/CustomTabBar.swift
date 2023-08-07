//
//  CustomTabBar.swift
//  Swifti
//
//  Created by Zidouni on 06/08/2023.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabBar
    
    var body: some View {
        VStack {
            HStack(spacing: 20) {
                ForEach(TabBar.allCases, id: \.rawValue) { tab in
                    Image("\(selectedTab == tab ? selectedTab.rawValue : tab.rawValue)")
                        .frame(maxWidth: .infinity, maxHeight: 30)
                        .foregroundColor(selectedTab == tab ? .primaryColor : .labelIconBackground)
                        .onTapGesture {
                            selectedTab = tab
                        }
                }
            }
            .padding(.vertical, 20)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .background(Color.background)
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.home))
    }
}
