//
//  LoginView.swift
//  StateAnaDataFlow
//
//  Created by Alex on 14.06.2023.
//

import SwiftUI

struct LoginView: View {
    @EnvironmentObject private var userSettings: UserSettings
    private let storageManager = StorageManager.shared
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter your name...", text: $userSettings.user.name)
                    .multilineTextAlignment(.center)
                Text("\(userSettings.user.name.count)")
                    .foregroundColor(userSettings.nameIsValid ? .green : .red)
            }
            .padding(EdgeInsets(top: 0, leading: 60, bottom: 20, trailing: 40))
            
            Button(action: login) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("OK")
                }
            }
            .disabled(!userSettings.nameIsValid)
        }
    }
    
    private func login() {
        userSettings.user.isLoggedIn.toggle()
        storageManager.save(user: userSettings.user)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
