//
//  ContentView.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI

struct ContentView: View {

    @State private var showSplashScreen = true

    var body: some View {
        if showSplashScreen {
            SplashView()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                        withAnimation(.easeInOut(duration: 0.4)) {
                            showSplashScreen = false
                        }
                    }
                }
        } else {
            PostListView()
        }
    }
}

#Preview {
    ContentView()
}
