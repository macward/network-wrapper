//
//  File.swift
//  
//
//  Created by Max Ward on 10/08/2023.
//

import Foundation

@available(iOS 13.0.0, *)
public class NetworkSessionDefault: NSObject, NetworkSession {
    
    private var session: URLSession!
    
    public override convenience init() {
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForResource = 30
        sessionConfiguration.waitsForConnectivity = true
        self.init(configuration: sessionConfiguration)
    }

    public init(configuration: URLSessionConfiguration) {
        super.init()
        self.session = URLSession(configuration: configuration)
    }
    
    public func data(with request: URLRequest) async throws -> (Data, URLResponse) {
        do {
            return try await session.data(for: request)
        } catch (let error) {
            throw error
        }
    }
}
