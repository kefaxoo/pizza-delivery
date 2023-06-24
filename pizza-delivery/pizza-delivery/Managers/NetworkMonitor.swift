//
//  NetworkMonitor.swift
//  pizza-delivery
//
//  Created by Bahdan Piatrouski on 24.06.23.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor()

    let monitor = NWPathMonitor()
    private var status: NWPath.Status = .requiresConnection
    var isReachable: Bool { status == .satisfied }
    var isReachableOnCellular: Bool = true

    init() {
        startMonitoring()
    }
    
    func startMonitoring() {
        monitor.pathUpdateHandler = { [weak self] path in
            self?.status = path.status
            self?.isReachableOnCellular = path.isExpensive
        }

        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    func stopMonitoring() {
        monitor.cancel()
    }
    
    func isNetworkAvailable() -> Bool {
        print(isReachable || isReachableOnCellular)
        return isReachable || isReachableOnCellular
    }
}
