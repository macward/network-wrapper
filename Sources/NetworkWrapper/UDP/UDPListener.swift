//
//  UDPListener.swift
//
//
//  Created by Max Ward on 11/08/2023.
//

// THIS IS a WIP

import Foundation
import Network

protocol UDPListenerDelegate {
    func handleData(data: Data)
}

@available(iOS 13.0, *)
class UDPListener: ObservableObject {
    
    private var connection: NWConnection?
    private let listener: NWListener?
    private var listen: Bool = false
    @Published var messageContent: Data?
    var delegate: UDPListenerDelegate?
    
    init(port: NWEndpoint.Port) {
        
        self.listener = try? NWListener(using: .udp, on: port)
        
        listener?.stateUpdateHandler = { state in
            switch state {
            case .setup:
                print("setup")
            case .ready:
                print("is ready")
            case .waiting(let error):
                print("Waiting: \(error.localizedDescription)")
            case .failed(let error):
                print("Failed: \(error.localizedDescription)")
            case .cancelled:
                print("Cancelled")
                self.listen = false
            @unknown default:
                print("Waiting for data")
            }
        }
    }
    
    private func connectionCallback(connection: NWConnection) {
        print("Someone tries to talk to us!:", connection)
        self.createConnection(connection: connection)
    }
    
    func startReceiving() {
        self.listen = true
        listener?.newConnectionHandler = self.connectionCallback
        listener?.start(queue: .global(qos: .userInteractive))
    }
    
    private func createConnection(connection: NWConnection) {
        self.connection = connection
        self.connection?.stateUpdateHandler = { state in
            switch state {
            case .setup:
                print("setup")
            case .preparing:
                print("preparing")
            case .ready:
                print("connection is ready")
                self.receiveData()
            case .cancelled:
                print("Cancelled")
                self.listen = false
            case .waiting(let error):
                print(error.localizedDescription)
            case .failed(let error):
                print(error.localizedDescription)
            @unknown default:
                print("Waiting for data")
            }
        }
        self.connection?.start(queue: .global(qos: .userInitiated))
    }
    
    func receiveData() {
        self.connection?.receive(minimumIncompleteLength: 1, maximumLength: 1024, completion: { content, contentContext, isComplete, error in
            
            guard isComplete, let data = content else {
                print("error con los datos")
                return
            }
            if self.listen {
                self.messageContent = data
                self.delegate?.handleData(data: data)
                self.receiveData()
            }
        })
    }
    
    deinit {
        self.connection?.cancel()
        self.listen = false
    }
    
    func stop() {
        self.connection?.cancel()
    }
}
