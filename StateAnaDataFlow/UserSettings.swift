//
//  UserSettings.swift
//  StateAnaDataFlow
//
//  Created by Alexey Efimov on 14.06.2023.
//

import SwiftUI

final class UserSettings: ObservableObject {
    @AppStorage("isLoggedIn") var isLoggedIn = false
    @AppStorage("name") var name = ""
}
