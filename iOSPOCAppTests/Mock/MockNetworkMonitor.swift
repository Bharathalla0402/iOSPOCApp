//
//  MockNetworkMonitor.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import Foundation
@testable import iOSPOCApp

final class MockNetworkMonitor: NetworkMonitorProtocol {

    var isConnected: Bool = false

    func setConnection(_ status: Bool) {
        isConnected = status
    }
}
