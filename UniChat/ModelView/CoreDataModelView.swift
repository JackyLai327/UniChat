////
////  CoreDataModelView.swift
////  UniChat
////
////  Created by Jacky Lai on 2023/9/15.
////
//
//import Foundation
//import SwiftUI
//
//public class CoreDataModelView {
//    
//    // fetching discussions in a descending order by timestamp
//    static func fetchDiscussionsTimestampDescend() -> FetchedResults<Discussion> {
//        @FetchRequest(
//            entity: Discussion.entity(),
//            sortDescriptors: [ NSSortDescriptor(keyPath: \Discussion.timestamp, ascending: false) ])
//        var discussions: FetchedResults<Discussion>
//        
//        return discussions
//    }
// 
//    // fetching notifications in a descending order by timestamp
//    static func fetchNotificationsTimestampDescend() -> FetchedResults<Notification> {
//        @FetchRequest(
//            entity: Notification.entity(),
//            sortDescriptors: [ NSSortDescriptor(keyPath: \Notification.timestamp, ascending: false) ])
//        var notifications: FetchedResults<Notification>
//        
//        return notifications
//    }
//    
//    // fetch discussions from core data
//    static func fetchDiscussionsNumLikesDescend() -> FetchedResults<Discussion> {
//        @FetchRequest(
//            entity: Discussion.entity(),
//            sortDescriptors: [ NSSortDescriptor(keyPath: \Discussion.numLikes, ascending: false) ])
//        var discussions: FetchedResults<Discussion>
//        
//        return discussions
//    }
//    
//    // fetch images from core data
//    static func fetchImagesTimeStampDescend() -> FetchedResults<DiscussionImage> {
//        @FetchRequest(
//            entity: DiscussionImage.entity(),
//            sortDescriptors: [ NSSortDescriptor(keyPath: \DiscussionImage.timestamp, ascending: false) ])
//        var images: FetchedResults<DiscussionImage>
//        
//        return images
//    }
//    
//    // read from user entity
//    static func fetchUsersUsernameAscending() -> FetchedResults<User> {
//        @FetchRequest(
//            entity: User.entity(),
//            sortDescriptors: [ NSSortDescriptor(keyPath: \User.username, ascending: true) ])
//        var users: FetchedResults<User>
//        
//        return users
//    }
//}
