//
//  ResultError.swift
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

enum ResultError: Error {
    var localizedDescription: String {
        switch self {
        case .networkError(let code):
            return "Network error. HTTP Code \(code.intValue)"
        case .serverError(let underlying):
            return "Server error: \(String(describing: underlying))"
        default:
            return "Unknown error"
        }
    }
    
    case networkError(code: HTTPCode)
    case serverError(code: HTTPCode, underlying: RequestErrorResponse)
    case unknownError(code: HTTPCode, underlying: Error)
    case parsingError(message: String)
    case internalError(message: String)
    case noInternet
    
    init(error: Error) {
        self = .unknownError(code: HTTPCode(intValue: -1), underlying: error)
    }
    
    var isConnectionError: Bool {
        return false // TODO:
    }
    
    var httpCode: HTTPCode? {
        switch self {
        case .networkError(let code), .serverError(let code, _), .unknownError(let code, _):
            return code
        default:
            return nil
        }
    }
    
}
