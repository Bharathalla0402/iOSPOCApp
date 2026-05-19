//
//  iOSPOCAppApp.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI

@main
struct IOSPOCAppApp: App {

    // MARK: - state objects
    @State private var networkMonitor = NetworkMonitor()
    
    // MARK: - i vars
    private let isJailbroken: Bool

    init() {
        self.init(
            arguments: ProcessInfo.processInfo.arguments,
            jailbreakCheck: { JailbreakDetector.isJailbroken() }
        )
    }

    init(
        arguments: [String],
        jailbreakCheck: () -> Bool
    ) {
        let isUITest = arguments.contains(AppConstants.uiTesting)

        if isUITest {
            self.isJailbroken = false
            return
        }

        self.isJailbroken = jailbreakCheck()
    }

    var body: some Scene {
        WindowGroup {
            ContentView(isJailbroken: isJailbroken)
                .environment(networkMonitor)
        }
    }
}
