//
//  Constants.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

enum Constants {
    enum API {
        static let postsURL = "https://dummyjson.com/posts"
    }

    enum Jailbreak {
        static let suspiciousPaths: [String] = [
            "/Applications/Cydia.app",
            "/Applications/FakeCarrier.app",
            "/Applications/Icy.app",
            "/Applications/IntelliScreen.app",
            "/Applications/MxTube.app",
            "/Applications/RockApp",
            "/Applications/SBSettings.app",
            "/Applications/WinterBoard.app",
            "/Library/MobileSubstrate/DynamicLibraries/LiveClock.plist",
            "/Library/MobileSubstrate/DynamicLibraries/Veency.plist",
            "/Library/MobileSubstrate/MobileSubstrate.dylib",
            "/System/Library/LaunchDaemons/com.ikey.bbot.plist",
            "/System/Library/LaunchDaemons/com.saurik.Cydia.Startup.plist",
            "/bin/bash",
            "/bin/sh",
            "/etc/apt",
            "/etc/ssh/sshd_config",
            "/private/var/lib/apt/",
            "/private/var/lib/cydia",
            "/private/var/mobile/Library/SBSettings/Themes",
            "/private/var/tmp/cydia.log",
            "/usr/bin/sshd",
            "/usr/libexec/sftp-server",
            "/usr/libexec/ssh-keysign",
            "/usr/sbin/sshd"
        ]

        static let testString = "JailbreakTest"
        static let testFilePath = "/private/jailbreakTest.txt"
    }

    enum Alert {
        static let jailbreakTitle = "Security Alert"
        static let jailbreakMessage = "This device appears to be jailbroken. The app cannot continue."
        static let okButton = "OK"
    }

    enum ImageStrings {
        static let docFile = "doc.text.image.fill"
        static let rightImage = "chevron.right"
        static let leftImage = "chevron.left"
        static let bookmark = "bookmark"
        static let fillEye = "eye.fill"
        static let squareArrowUp = "square.and.arrow.up"
        static let handUpFill = "hand.thumbsup.fill"
        static let handDownFill = "hand.thumbsdown.fill"
        static let wifiSalsh = "wifi.slash"
    }
}

// string constants
struct AppConstants {
    static let trending = "Trending"
    static let uiTesting = "UI_TESTING"
    static let articleHub = "ArticleHub"
    static let loadingText = "Loading posts..."
    static let retry = "Retry"
    static let articles = "Articles"
    static let noConnection = "No internet connection"
    static let failedData = "Failed to load data"
    static let featured = "Featured"
    static let testDate = "May 15, 2026"
    static let details = "Details"
    static let dot = "•"
    static let read = "• 5 min read"
    static let errorTitle = "Error"
    static let okButton = "OK"
    static let networkMonitor = "Monitor"
}
