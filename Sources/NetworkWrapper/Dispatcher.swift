// The Swift Programming Language
// https://docs.swift.org/swift-book
//

import Foundation

@available(iOS 13.0.0, *)
public class Dispatcher: RequestDispatcher {
    
    private var networkSession: NetworkSession
    private var baseUrl: String
    private var headers: [String: String]?
    
    required public init(baseUrl: String,
                         networkSession: NetworkSession = NetworkSessionDefault()) {
        self.networkSession = networkSession
        self.baseUrl = baseUrl
    }
    
    public func setHeaders(_ headers: [String : String]) {
        self.headers = headers
    }
    
    public func execute<T: Codable>(request: Request, of type: T.Type) async throws -> T {
        guard var urlRequest = request.urlRequest(baseUrl: self.baseUrl) else {
            throw DispatcherError.badRequest("Something went wrong with the request")
        }
        
        headers?.forEach({ (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        
        request.headers?.forEach({ (key: String, value: String) in
            urlRequest.addValue(value, forHTTPHeaderField: key)
        })
        
        do {
            let data = try await networkSession.call(urlRequest)
            return try JSONDecoder().decode(T.self, from: data)
        } catch (let error) {
            throw DispatcherError.parseError(error.localizedDescription)
        }
    }
}
