//
//  File.swift
//  
//
//  Created by Max Ward on 10/08/2023.
//

import Foundation

@available(iOS 13.0.0, *)
public protocol NetworkSession {
    func data(with request: URLRequest) async throws -> (Data, URLResponse)
}
