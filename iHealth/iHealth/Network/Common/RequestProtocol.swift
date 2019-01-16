//
//  RequestProtocol.swift
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

enum ContentType {
    case json
    case urlencoded
}

protocol RequestProtocol {
    
    /// Associated type use to decode the response received (Must conform to Decodable)
    associatedtype ResponseType: Decodable
    
    /// Encodable body that will be sent in the body of the request
    var encodableBody: Encodable? { get set }
    
    /// HTTP methods used in the request (GET, POST, PUT, DELETE)
    var method: HTTPMethod { get set }
    
    /// URL used in the request
    var url: URL? { get set }
    
    /// Computed property that will encode 'encodableBody' into Data to be sent in the body of the request
    var body: Data? { get }
    
    /// Block called upon request completion. Returns a Result enum with either success or failure
    var completion: ((Result<ResponseType?>)->Void)? { get set }
    
    /// Optional method to process and parse received Data from request. By default decodes Data into specified associatedtype
    func processResponseData(data: Data) throws -> ResponseType?
    
    /// Whether the request should be retried after a failure. Default is false
    var shouldRetry: Bool { get }
    
    /// Custom query string parameters for the URL
    var queryString: [String: String]? { get }
    
    var debugDescription: String { get }
    
    /// Simulate the API response
    var simulatedResponseJSONFile: String? { get set }
    
    /// Verbose mode
    var verbose: Bool? { get set }
    
    /// Simulate the API response
    var contentType: ContentType { get set }
    
    /// Get header content
    var processHeader: Bool? { get set }
}



extension RequestProtocol {
    
    func processResponseData(data: Data) throws -> ResponseType? {
        return try parseCodable(fromData: data)
    }
    
    private func parseCodable<ResponseType: Decodable>(fromData data: Data) throws -> ResponseType? {
        return try JSONDecoder().decode(ResponseType.self, from: data)
    }
    
    private func getAllBodyFields() -> String {
        var fields: String = ""
        
        if let encodableBody = encodableBody {
            let mirror = Mirror(reflecting: encodableBody)
            for child in mirror.children {
                if let label = child.label {
                    fields.append("\(label)=\(child.value)&")
                }
            }
        }
        
        return String(fields.dropLast())
    }
    
    var shouldRetry: Bool {
        return false
    }
    
    var body: Data? {
        guard let encodableBody = encodableBody else {
            return try? JSONEncoder().encode(EmptyBody())
        }
        
        if contentType == .urlencoded {
            return getAllBodyFields().data(using: String.Encoding.utf8)
        }
    
        return try? JSONEncoder().encode(AnyCodable(encodableBody))
    }
    
    var queryString: [String: String]? {
        return nil
    }
    
    var debugDescription: String {
        return "\(Self.self) | " +
            "URL : \(url?.absoluteString ?? "") | " +
            "BODY : \(String(data: body ?? Data(), encoding: .utf8) ?? "") | " +
        "METHOD : \(method.rawValue)"
    }
}

/// Using this wrapper for Codable allows us to not use generics for a Encodable body
fileprivate struct AnyCodable: Encodable {
    let data: Encodable
    
    init(_ data: Encodable) {
        self.data = data
    }
    
    func encode(to encoder: Encoder) throws {
        // Encodes data directly into the root container
        try data.encode(to: encoder)
    }
}

/// Used because we've got POST requests that should send an empty body
struct EmptyBody: Codable {}
