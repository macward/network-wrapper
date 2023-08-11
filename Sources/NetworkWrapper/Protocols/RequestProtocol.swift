//
//  File.swift
//  
//
//  Created by Max Ward on 10/08/2023.
//

import Foundation

public protocol Request {
    var path: String { get }
    var method: RequestMethod { get }
    var headers: ReaquestHeaders? { get }
    var parameters: RequestParameters? { get }
}
