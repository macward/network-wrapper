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
    
    public func call(_ request: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: request)
        guard let response = response.httpResponse, response.isOk else {
            throw DispatcherError.invalidResponse
        }
        return data
    }
}

