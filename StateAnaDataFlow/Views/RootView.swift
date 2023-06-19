//
//  RootView.swift
//  StateAnaDataFlow
//
//  Created by Alexey Efimov on 14.06.2023.
//

import SwiftUI

struct RootView: View {
    @StateObject private var userSettings = UserSettings()
    
    var body: some View {
        Group {
            if userSettings.user.isLoggedIn {
                ContentView()
            } else {
                LoginView()
            }
        }.environmentObject(userSettings)
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
