//
//  ContentView.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI

struct ContentView: View {

    // MARK: - State vars
    @State private var showSplashScreen = true
    @State private var showJailbreakAlert = false

    // MARK: - i vars
    let isJailbroken: Bool

    var body: some View {
        ZStack {
            if showSplashScreen {
                SplashView()
                    .onAppear {
                        handleStartup()
                    }
            } else {
                PostListView()
            }
        }
        .alert(Constants.Alert.jailbreakTitle, isPresented: $showJailbreakAlert) {
            Button(Constants.Alert.okButton, role: .cancel) {
                exit(0) // optional (strict security)
            }
        } message: {
            Text(Constants.Alert.jailbreakMessage)
        }
    }

    private func handleStartup() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if isJailbroken {
                showJailbreakAlert = true
            } else {
                withAnimation(.easeInOut(duration: 0.4)) {
                    showSplashScreen = false
                }
            }
        }
    }
}
