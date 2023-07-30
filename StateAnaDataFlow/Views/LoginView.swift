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
        GeometryReader { geometry in
            
            HeaderView(
                color: .teal,
                frame: geometry.size.width * 1.9,
                offset: -geometry.size.width * 1.3
            )
            
            VStack {
                HStack {
                    TextField("Enter your name...", text: $userSettings.user.name)
                        .multilineTextAlignment(.center)
                    Text("\(userSettings.user.name.count)")
                        .foregroundColor(userSettings.nameIsValid ? .green : .red)
                }
                .padding(
                    EdgeInsets(
                        top: geometry.size.width * 0.8,
                        leading: geometry.size.width * 0.2,
                        bottom: geometry.size.width * 0.1,
                        trailing: geometry.size.width * 0.1
                    )
                )
                
                Button(action: login) {
                    Label("Ok", systemImage: "checkmark.circle")
                }
                .disabled(!userSettings.nameIsValid)
            }
            .font(.system(size: geometry.size.width * 0.07))
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
            .environmentObject(UserSettings())
    }
}

// MARK: - HeaderView
struct HeaderView: View {
    let color: Color
    let frame: CGFloat
    let offset: CGFloat
    
    var body: some View {
        Circle()
            .foregroundColor(color)
            .frame(width: frame)
            .offset(y: offset)
    }
}
