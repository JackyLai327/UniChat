//
//  FeatureTabView.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

struct FeatureTabView: View {
    // for custom back button dismiss action
    @Environment(\.dismiss) private var dismiss
    
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            TrendingDiscussionsView()
                .tabItem{
                    Label("", systemImage: "flame")}
                .toolbarBackground(UniChatColor.headerYellow, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .tag(0)

            ProfileView()
                .tabItem{
                    Label("", systemImage: "studentdesk")}
                .toolbarBackground(UniChatColor.headerYellow, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .tag(1)
            
            WritePostView()
                .tabItem{
                    Label("", systemImage: "pencil.line")}
                .toolbarBackground(UniChatColor.headerYellow, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .tag(2)
            
            NotificationsView()
                .tabItem{
                    Label("", systemImage: "bell.fill")
                }
                .toolbarBackground(UniChatColor.headerYellow, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .tag(3)
            
            SettingsView()
                .tabItem{
                    Label("", systemImage: "gear")}
                .toolbarBackground(UniChatColor.headerYellow, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .tag(4)
        }
        .accentColor(UniChatColor.brightYellow)
        .navigationBarBackButtonHidden(true)
        .toolbar(.hidden)
        
    }
}

struct FeatureTabView_Previews: PreviewProvider {
    static var previews: some View {
        FeatureTabView()
    }
}
