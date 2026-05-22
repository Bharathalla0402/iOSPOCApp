//
//  PostDetailViewModelTests.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 16/05/26.
//

@testable import iOSPOCApp
import XCTest

final class PostDetailViewModelTests: XCTestCase {

    var viewModel: PostDetailViewModel!

    override func setUp() {
        super.setUp()
        viewModel = makeViewModel()
    }

    // MARK: - Basic Properties

    func testTitle() {
        XCTAssertEqual(viewModel.title, "Test Title")
    }

    func testDescription() {
        XCTAssertEqual(viewModel.description, "First sentence. Second sentence.")
    }

    func testTags() {
        XCTAssertEqual(viewModel.tags, ["swift", "ios"])
    }

    func testShortDescription() {
        XCTAssertEqual(viewModel.shortDescription, "First sentence.")
    }

    func testTagsText() {
        XCTAssertEqual(viewModel.tagsText, "swift, ios")
    }

    func testLikesText() {
        XCTAssertEqual(viewModel.likesText, 120)
    }

    func testDislikesText() {
        XCTAssertEqual(viewModel.dislikesText, 5)
    }

    func testStatusTrending() {
        XCTAssertEqual(viewModel.status, "Trending")
    }

    func testDate() {
        XCTAssertEqual(viewModel.date, "May 15, 2026")
    }

    func testIsTrendingTrue() {
        XCTAssertTrue(viewModel.isTrending)
    }

    func testHasTagsTrue() {
        XCTAssertTrue(viewModel.hasTags)
    }

    func testPostViews() {
        XCTAssertEqual(viewModel.postViews, 300)
    }
}
