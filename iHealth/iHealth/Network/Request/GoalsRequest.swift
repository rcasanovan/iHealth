//
//  GoalsRequest.swift
//  iHealth
//
//  Created by Ricardo Casanova on 16/01/2019.
//  Copyright © 2019 Pijp. All rights reserved.
//

import Foundation

struct GoalsRequest: RequestProtocol {
    
    typealias ResponseType = GoalsResponse
    var completion: ((Result<GoalsResponse?>) -> Void)?
    var method: HTTPMethod = .get
    var url: URL? = Endpoint.getGoals().url
    var encodableBody: Encodable?
    var simulatedResponseJSONFile: String?
    var verbose: Bool?
    var contentType: ContentType = .json
    var processHeader: Bool?
    var shouldRetry: Bool = true
    
}
