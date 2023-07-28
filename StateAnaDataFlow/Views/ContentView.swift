//
//  ContentView.swift
//  StateAnaDataFlow
//
//  Created by Alex on 14.06.2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var timer = TimeCounter()
    @EnvironmentObject private var userSettings: UserSettings
    private let storageManager = StorageManager.shared
    
    var body: some View {
        VStack {
            Text("Hi, \(userSettings.user.name)!")
                .font(.largeTitle)
                .padding(.top, 100)
            Text(timer.counter.formatted())
                .font(.largeTitle)
                .padding(.top, 100)
            
            Spacer()
            ButtonView(
                title: timer.buttonTitle,
                color: .red,
                action: timer.startTimer
            )
            Spacer()
            ButtonView(
                title: "Log Out",
                color: .blue,
                action: logOut
            )
            Spacer()
        }
    }
    
    private func logOut() {
        storageManager.delete(userSettings: userSettings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserSettings())
    }
}

// MARK: - ButtonView
struct ButtonView: View {
    let title: String
    let color: Color
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(width: 200, height: 60)
        .background(color)
        .cornerRadius(20)
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.black, lineWidth: 4)
        }
        .disabled(title == "Wait...")
    }
}