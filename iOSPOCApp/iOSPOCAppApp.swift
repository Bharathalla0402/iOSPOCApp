//
//  iOSPOCAppApp.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import SwiftUI

@main
struct IOSPOCAppApp: App {

    // Required by SwiftUI
    init() {
        self.init(
            arguments: ProcessInfo.processInfo.arguments,
            jailbrokenCheck: { JailbreakDetector.isJailbroken() }
        )
    }

    // Your testable initializer
    init(
        arguments: [String],
        jailbrokenCheck: () -> Bool
    ) {
        let isUITest = arguments.contains("UI_TESTING")

        if isUITest {
            return
        }

        if jailbrokenCheck() {
            // avoid exit in unit test
            if !arguments.contains("UNIT_TESTING") {
                exit(0)
            }
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
