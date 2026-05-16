//
//  iOSPOCAppUITestsLaunchTests.swift
//  iOSPOCAppUITests
//
//  Created by Alla Bharath on 15/05/26.
//

import XCTest

final class IOSPOCAppUITestsLaunchTests: XCTestCase {

    // swiftlint:disable:next static_over_final_class
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
}
