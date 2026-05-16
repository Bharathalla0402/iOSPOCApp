//
//  JailbreakDetector.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import Foundation
import UIKit

final class JailbreakDetector {

    // MARK: - Core Interface
    static func isJailbroken() -> Bool {
        // 1. Immediately pass if running on the Xcode Simulator
#if targetEnvironment(simulator)
        return false
#else
        // 2. Run all checking layers
        return checkSuspiciousFiles() || checkSandboxViolation()
#endif
    }

    // MARK: - Layer 1: Enhanced File-Path Scanning
    static func checkSuspiciousFiles() -> Bool {
        let paths = [
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

        for path in paths where FileManager.default.fileExists(atPath: path) {
            return true
        }

        return false
    }

    // MARK: - Layer 2: Sandbox Violation Test (Attempt to write outside of App Container)
    static func checkSandboxViolation() -> Bool {
        let stringToTest = "JailbreakTest"
        let path = "/private/jailbreakTest.txt"

        do {
            // A non-jailbroken app will fail here due to strict iOS sandbox restrictions
            try stringToTest.write(toFile: path, atomically: true, encoding: .utf8)

            // If it succeeds, the app was able to write outside its sandbox
            try FileManager.default.removeItem(atPath: path)
            return true
        } catch {
            return false
        }
    }
}
