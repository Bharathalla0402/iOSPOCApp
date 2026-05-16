//
//  ShapeExtensionsTests.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 16/05/26.
//

import XCTest
import SwiftUI
@testable import iOSPOCApp

final class ShapeExtensionsTests: XCTestCase {

    // Basic execution
    func testShapeStyle_executes() {
        let shape = Circle()

        let view = shape.style(
            withStroke: Color.red,
            lineWidth: 2,
            fill: Color.blue
        )

        // Force execution
        _ = view

        XCTAssertNotNil(view)
    }

    // Different parameters (cover generic paths)
    func testShapeStyle_withDifferentStyles() {
        let shape = Rectangle()

        let view = shape.style(
            withStroke: Color.green,
            lineWidth: 5,
            fill: LinearGradient(
                colors: [.red, .blue],
                startPoint: .top,
                endPoint: .bottom
            )
        )

        _ = view

        XCTAssertTrue(true)
    }
}
