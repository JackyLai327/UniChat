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
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)

            ProfileView()
                .tabItem{
                    Label("", systemImage: "studentdesk")}
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            
            WritePostView()
                .tabItem{
                    Label("", systemImage: "pencil.line")}
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            
            NotificationsView()
                .tabItem{
                    Label("", systemImage: "bell.fill")
                }
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
            
            SettingsView()
                .tabItem{
                    Label("", systemImage: "gear")}
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
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
