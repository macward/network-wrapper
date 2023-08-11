//
//  File.swift
//  
//
//  Created by Max Ward on 10/08/2023.
//

import Foundation

extension Request {
    
    public func urlRequest(baseUrl: String) -> URLRequest? {
        guard let url = self.url(with: baseUrl) else {
            fatalError(RuntimeApiError.notValidUrlFormat.rawValue)
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        return request
    }
        
    private func url(with baseURL: String) -> URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

    private var queryItems: [URLQueryItem]? {
        guard method == .get, let parameters = parameters else {
            return nil
        }
        return parameters.map { (key: String, value: Any?) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
    }
    
    private var body: Data? {
        guard [.post, .put, .patch].contains(method), let parameters = parameters else {
            return nil
        }
        var jsonBody: Data?
        do {
            jsonBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            return nil
        }
        return jsonBody
    }
}
