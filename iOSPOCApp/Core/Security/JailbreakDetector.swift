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
        for path in Constants.Jailbreak.suspiciousPaths
        where FileManager.default.fileExists(atPath: path) {
            return true
        }
        return false
    }

    // MARK: - Layer 2: Sandbox Violation Test (Attempt to write outside of App Container)
    static func checkSandboxViolation() -> Bool {
        let stringToTest = Constants.Jailbreak.testString
        let path = Constants.Jailbreak.testFilePath

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
