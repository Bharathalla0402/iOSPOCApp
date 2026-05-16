//
//  MockNetworkMonitor.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

@testable import iOSPOCApp

final class MockNetworkMonitor: NetworkMonitor {

    override init() {
        super.init()
    }

    func setConnection(_ status: Bool) {
        isConnected = status
    }
}
