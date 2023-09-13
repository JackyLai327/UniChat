//
//  Persistence.swift
//
//
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    //to add test data for preview
    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        // temprary data for testing only
        let discussion01 = Discussion(context: viewContext)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        discussion01.id = UUID()
        discussion01.content = "my hot lecturer said she was free after 6pm tomorrow... what do i do... 🧐"
        discussion01.numLikes = 420
        discussion01.numReplies = 3
        discussion01.numShares = 42
        discussion01.target = "RMIT University"
        discussion01.timestamp = dateFormatter.date(from: "2023-08-08T12:13:20+1000")!
        discussion01.username = "ilikeuni"
        discussion01.targetType = "uni"
        
        let notification01 = Notification(context: viewContext)
        notification01.id = UUID()
        notification01.discussion = "\(discussion01.id)"
        notification01.receiver = "unichat"
        notification01.sender = "ilovejava"
        notification01.timestamp = dateFormatter.date(from: "2023-08-08T12:13:20+1000")!
        notification01.notificationType = .like
        
        let reply01 = Reply(context: viewContext)
        reply01.id = UUID()
        reply01.content = "bro be capping for life"
        reply01.discussion = "\(discussion01.id)"
        reply01.numUps = 420
        reply01.timestamp = dateFormatter.date(from: "2022-08-23T12:19:14+1000")!
        reply01.username = "420forthewin"
        
        do {
            try viewContext.save()
        } catch {
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return result
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "UniChatCoreData")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
