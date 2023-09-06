//
//  UniChatApp.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/8/22.
//

import SwiftUI

@main
struct UniChatApp: App {
    let persistenceController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
