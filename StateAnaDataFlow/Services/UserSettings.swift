//
//  UserSettings.swift
//  StateAnaDataFlow
//
//  Created by Alexey Efimov on 14.06.2023.
//

import Combine

final class UserSettings: ObservableObject {
    @Published var user = User()
    
    var nameIsValid: Bool {
        user.name.count >= 3
    }
    
    init() {
        self.user = StorageManager.shared.fetchUser()
    }
    
    init(user: User) {
        self.user = user
    }
}
