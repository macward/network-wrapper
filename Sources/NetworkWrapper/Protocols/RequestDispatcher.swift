//
//  File.swift
//  
//
//  Created by Max Ward on 10/08/2023.
//

import Foundation

@available(iOS 13.0.0, *)
protocol RequestDispatcher {
    init(baseUrl: String, networkSession: NetworkSession)
    func execute<T: Codable>(request: Request, of type: T.Type) async throws -> T
    func setHeaders(_ headers: [String: String])
}
