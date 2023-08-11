//
//  File.swift
//  
//
//  Created by Max Ward on 10/08/2023.
//

import Foundation

public enum DispatcherError: Error {
    case noData
    case invalidResponse
    case badRequest(String?)
    case serverError(String?)
    case parseError(String?)
    case unknown
}

public enum RuntimeApiError: String {
    case noUrlFound = "(error 101 - No url found)"
    case urlNotProvided = "error 102 - Url not provided"
    case notValidUrlFormat = "(error 103 - Not valid url format)"
}
