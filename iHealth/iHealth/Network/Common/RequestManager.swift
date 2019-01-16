//
//  RequestManager.swift
//
//  Created by Ricardo Casanova on 03/09/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
    case get
    case head
    case post
    case put
    case patch
    case delete = "DELETE"
}

class RequestManager {
    private let defaultRetryTime: TimeInterval = 2.0 // In seconds
    
    fileprivate func sessionConfiguration() -> URLSessionConfiguration {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 30
        configuration.httpAdditionalHeaders = NetworkHeaders.create()
        return configuration
    }
    
    var isConnected: Bool {
        return ReachabilityManager.shared.hasConnection()
    }
    
    func send<T: RequestProtocol>(request: T, after: TimeInterval) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + after) {
            self.send(request: request)
        }
    }
    
    func send<T: RequestProtocol>(request: T) {
        if let simulatedResponseJSONFile = request.simulatedResponseJSONFile {
            processLocalResponse(request: request, JSONFile: simulatedResponseJSONFile)
            return
        }
        
        // Check reachability
        guard isConnected else {
            send(request: request, after: defaultRetryTime)
            return
        }
        
        guard var url = request.url else {
            assertionFailure("Error creating URL for endpoint: \(String(describing: request))")
            request.completion?(Result.failure(ResultError.internalError(message: "Error creating URL for endpoint: \(String(describing: request))")))
            return
        }
        
        if let queryDictionary = request.queryString {
            let urlParams = queryDictionary.compactMap({ (key, value) -> String in
                return "\(key)=\(value)"
            }).joined(separator: "&")
            
            let queryString = url.absoluteString + "?" + urlParams
            if let queryURL = URL(string: queryString) {
                url = queryURL
            }
        }
        
        var httpRequest = URLRequest(url: url)
        
        httpRequest.httpMethod = request.method.rawValue
        if request.method == .post || request.method == .put {
            assert(request.body != nil, "Body is nil and it shouldn't")
            httpRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            httpRequest.httpBody = request.body
        }
        
        // Debugging
        if let verbose = request.verbose, verbose == true {
            print(" ------------ SENDING REQUEST ------------ ")
            print("Request: \(request.debugDescription)")
            print("Headers: \(sessionConfiguration().httpAdditionalHeaders ?? [:])")
            print(" ------------------------------------ ")
        }
        
        let session = URLSession(configuration: sessionConfiguration())
        let task = session.dataTask(with: httpRequest) { (serverData, responseData, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    let httpError = ResultError(error: error)
                    // Check if it's a generic connection error to attempt retry
                    if httpError.isConnectionError && request.shouldRetry {
                        self.send(request: request, after: self.defaultRetryTime)
                    } else {
                        request.completion?(Result.failure(httpError))
                    }
                    return
                }
                
                let httpCode: HTTPCode = HTTPCode(intValue: (responseData as? HTTPURLResponse)?.statusCode ?? 0)
                
                if !httpCode.isSuccess {
                    var dataDict: [String : Any] = ["Request": request.debugDescription]
                    dataDict.updateValue(String(data: (serverData ?? Data()), encoding: .utf8) ?? "", forKey: "Response")
                    
                    guard let data = serverData else {
                        request.completion?(Result.failure(ResultError.networkError(code: httpCode)))
                        return
                    }
                    
                    do {
                        let error = try JSONDecoder().decode(RequestErrorResponse.self, from: data)
                        print("Received Server error. Reason: \((error.reason ?? "Unknown")). Info: \(error.errors)")
                        request.completion?(Result.failure(ResultError.serverError(code: httpCode, underlying: error)))
                    } catch {
                        print("Unknown error: \(error)")
                        if let errorDescription = String(data: data, encoding: .utf8) {
                            print(errorDescription)
                        }
                        
                        request.completion?(Result.failure(ResultError.unknownError(code: httpCode, underlying: error)))
                    }
                    
                    return
                }
                
                var informationData = serverData
                if let processHeader = request.processHeader, processHeader == true, let responseData = responseData as? HTTPURLResponse {
                    informationData = try? JSONSerialization.data(withJSONObject: responseData.allHeaderFields, options: .prettyPrinted)                    
                }
                
                // If method is DELETE or no data, return success
                guard request.method != .delete, let data = informationData else {
                    request.completion?(Result.success(nil))
                    return
                }
                do {
                    let processedData = try request.processResponseData(data: data)
                    request.completion?(Result.success(processedData))
                    
                } catch {
                    request.completion?(Result.failure(ResultError.parsingError(message: error.localizedDescription)))
                }
                
            }
            
        }
        
        task.resume()
    }
}

extension RequestManager {
    
    private func processLocalResponse<T: RequestProtocol>(request: T, JSONFile: String) {
        if let path = Bundle.main.path(forResource: JSONFile, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let processedData = try request.processResponseData(data: data)
                request.completion?(Result.success(processedData))
            } catch {
                request.completion?(Result.failure(ResultError.parsingError(message: error.localizedDescription)))
            }
        }
    }
    
}
