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
    @State private var isPresented = false
    @State private var counterValue = ""
    private let storageManager = StorageManager.shared
    
    var body: some View {
        NavigationStack {
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
                    color: .pink,
                    action: timer.startTimer
                )
                Spacer()
                ButtonView(
                    title: "Log Out",
                    color: .teal,
                    action: logOut
                )
                Spacer()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {isPresented.toggle()}) {
                        Image(systemName: "gearshape.2.fill")
                    }
                    .disabled(timer.buttonTitle != "Start")
                    .alert("Settings", isPresented: $isPresented, actions: {
                        TextField("Enter a number", text: $counterValue)
                            .keyboardType(.numberPad)
                        Button("OK", action: {counterChange()})
                    }, message: {
                        Text("Changing the countdown value")
                    })
                }
            }
        }
    }
    
    private func logOut() {
        storageManager.delete(userSettings: userSettings)
    }
    
    private func counterChange() {
        if let counterValue = Int(counterValue), counterValue > 0 {
            timer.counter = counterValue
        }
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
                .stroke(.black, lineWidth: 2)
        }
        .disabled(title == "Wait...")
    }
}
