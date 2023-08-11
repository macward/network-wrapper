//
//  File.swift
//  
//
//  Created by Max Ward on 11/08/2023.
//

import Foundation

public extension HTTPURLResponse {
    var isOk: Bool {
        return 200...299 ~= self.statusCode
    }
}

extension URLResponse {
    var httpResponse: HTTPURLResponse? {
        return self as? HTTPURLResponse
    }
}
