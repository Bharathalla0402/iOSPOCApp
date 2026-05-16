//
//  MockAPIService.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import Foundation
@testable import iOSPOCApp

final class MockAPIService: APIServiceProtocol {

    var shouldReturnError: Bool = false
    var postsToReturn: [Post] = []

    func fetchPosts() async throws -> [Post] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return postsToReturn
    }
}

class MockURLProtocol: URLProtocol {

    static var mockData: Data?
    static var response: URLResponse?
    static var error: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }

    override func startLoading() {
        if let error = MockURLProtocol.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        if let response = MockURLProtocol.response {
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        }

        if let data = MockURLProtocol.mockData {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
