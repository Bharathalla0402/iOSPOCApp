//
//  NetworkMonitor.swift
//  iOSPOCApp
//
//  Created by Alla Bharath on 15/05/26.
//

import Network
import SwiftUI
import Combine

class NetworkMonitor: ObservableObject {
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global()

    @Published var isConnected = true

    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
