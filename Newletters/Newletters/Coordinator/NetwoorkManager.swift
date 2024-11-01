//
//  NetwoorkManager.swift
//  Newletters
//
//  Created by Jorge Alfredo Cruz Acuña on 31/10/24.
//

import Foundation
import Network

class NetwoorkManager {
    static let shared = NetwoorkManager()
    
    private let monitor: NWPathMonitor
    private let queue: DispatchQueue
    var isConnected: Bool = true

    private init() {
        monitor = NWPathMonitor()
        queue = DispatchQueue(label: "Monitor")
        
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = (path.status == .satisfied)
        }
        
        monitor.start(queue: queue)
    }
}
