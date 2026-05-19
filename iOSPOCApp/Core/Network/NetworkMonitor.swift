//
//  NetworkMonitor.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import Network
import SwiftUI
import Combine

protocol NetworkMonitorProtocol {
    var isConnected: Bool { get set }
}

@Observable
final class NetworkMonitor: NetworkMonitorProtocol {
    private let networkMonitor = NWPathMonitor()
    private let workerQueue = DispatchQueue(label: AppConstants.networkMonitor)
    var isConnected = false

    init() {
        networkMonitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
        }
        networkMonitor.start(queue: workerQueue)
    }
}
