//
//  KeychainManager.swift
//  UniChat
//
//  Created by Jacky Lai on 2023/9/13.
//

import Foundation

/// Struct used to store a user's username and password.
struct Credentials {
    var username: String
    var password: String
}

enum KeychainError: Error {
    case noPassword
    case unexpectedPasswordData
    case unhandledError(status: OSStatus)
}

/// Manages items in keychian.
class KeychainManager {
    static let server = ""
    
    /// Adds a Credential object to keychain.
    /// - Parameter credential: Username and Password to into keychain.
    func addCredential(credential: Credentials) throws {
        
        let accountUsername = credential.username
        let accountPassword = credential.password.data(using: .utf8)!
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: accountUsername,
            kSecAttrServer as String: KeychainManager.server,
            kSecValueData as String: accountPassword
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
    }
    
    /// Reads from the keychain for items.
    /// - Returns: The Credential object stored as a keychain item.
    func retrieveCredentials() throws -> Credentials {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrServer as String: KeychainManager.server,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        guard status != errSecItemNotFound else { throw KeychainError.noPassword }
        
        guard status == errSecSuccess else { throw KeychainError.unhandledError(status: status) }
        
        guard let existingItem = item as? [String: Any],
              let passwordData = existingItem[kSecValueData as String] as? Data,
              let password = String(data: passwordData, encoding: .utf8),
              let accountUsername = existingItem[kSecAttrAccount as String] as? String
        else {
            throw KeychainError.unexpectedPasswordData
        }
        
        let crendentials = Credentials(username: accountUsername, password: password)
        
        return crendentials
    }
    
    /// Remove unused/unnecessary Credential objecy from keychian items.
    /// - Parameter credential: The Credential object with username and password to remove.
    func deleteCredentials(credential: Credentials) throws {
        
        let accountUsername = credential.username
        let accountPassword = credential.password.data(using: .utf8)!
        
        // Create a query dictionary with the attributes of the item to be deleted
        let query: [String: Any] = [
            kSecClass as String: kSecClassInternetPassword,
            kSecAttrAccount as String: accountUsername,
            kSecAttrServer as String: KeychainManager.server,
            kSecValueData as String: accountPassword
        ]
        
        // Delete the item from the keychain
        let status = SecItemDelete(query as CFDictionary)
        
        // Check the status of the deletion operation
        if status != errSecSuccess {
            print("Failed to delete keychain item. Status: \(status)")
        } else {
            print("Keychain item deleted successfully.")
        }
    }
}


