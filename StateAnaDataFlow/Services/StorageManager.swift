//
//  StorageManager.swift
//  StateAnaDataFlow
//
//  Created by Alex on 18.06.2023.
//

import SwiftUI

final class StorageManager {
    static let shared = StorageManager()
        
    @AppStorage("user") private var userData: Data?
    
    private init() {}
    
    func save(user: User) {
        userData = try? JSONEncoder().encode(user)
    }
    
    func fetchUser() -> User {
        guard let userData else { return User() }
        let user = try? JSONDecoder().decode(User.self, from: userData)
        guard let user else { return User() }
        return user
    }
    
    func delete(userSettings: UserSettings) {
        userSettings.user.isLoggedIn = false
        userSettings.user.name = ""
        userData = nil
    }
}
