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
    static var isEnabled = false

    private static let handledKey = "MockURLProtocolHandled"

    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(
            forKey: handledKey,
            in: request
        ) != nil {
            return false
        }

        return isEnabled
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        let newRequest = ((request as NSURLRequest).mutableCopy() as? NSMutableURLRequest)
        URLProtocol.setProperty(
            true,
            forKey: Self.handledKey,
            in: newRequest!
        )

        if let error = Self.error {
            client?.urlProtocol(self, didFailWithError: error)
            return
        }

        if let response = Self.response {
            client?.urlProtocol(self,
                didReceive: response,
                cacheStoragePolicy: .notAllowed
            )
        }

        if let data = Self.mockData {
            client?.urlProtocol(self, didLoad: data)
        }

        client?.urlProtocolDidFinishLoading(self)
    }

    override func stopLoading() {}
}
