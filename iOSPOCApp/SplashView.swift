//
//  SplashView.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

// SplashView.swift
import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State private var logoOpacity = 0.3
    @State private var logoScale = 0.7

    var body: some View {
        ZStack {
            // Background matches system canvas profile
            Color(.systemBackground)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                Image(systemName: "doc.text.image.fill")
                    .font(.system(size: 85))
                    .foregroundColor(.blue)

                Text("ArticleHub")
                    .font(.largeTitle)
                    .bold()
                    .tracking(1.5)
            }
            .scaleEffect(logoScale)
            .opacity(logoOpacity)
            .onAppear {
                withAnimation(.easeOut(duration: 1.0)) {
                    self.logoScale = 1.0
                    self.logoOpacity = 1.0
                }
            }
        }
    }
}
