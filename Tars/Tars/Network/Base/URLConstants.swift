//
//  URLConstants.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

protocol URLConstants {
    var url: String { get }
    var httpMethod: String { get }
    func getEndpoint(with parameters: [String: String]?) -> Endpoint
}

// MARK: - Astronomy API
// https://astronomyapi.com/
enum AstronomyURL: String, URLConstants {
    case bodies = "api/v2/bodies" // Get available bodies
    case bodiesPosition = "api/v2/bodies/positions" // Get all bodies positions
    case bodiesPositionBody = "/api/v2/bodies/positions/:body" // Get body positions
    
    var url: String {
        "https://api.astronomyapi.com/\(self.rawValue)"
    }
    
    var httpMethod: String {
        switch self {
        case .bodies, .bodiesPosition, .bodiesPositionBody:
            return "GET"
        }
    }
    
    /// getEndpoint
    /// - Parameter parameters: query parameters for urlrequest
    /// - Returns: Endpoint with query parameters and authorization header
    func getEndpoint(with parameters: [String: String]?) -> Endpoint {
        // Get API key and create hash for authorization
        let hash = "\(Keys.applicationId):\(Keys.applicationSecret)"
        let headers = ["Authorization": "Basic \(hash.toBase64())"]
        return Endpoint(url: self.url, method: self.httpMethod, headers: headers, queryParameters: parameters)
    }
}

// MARK: - Horizon API
// https://ssd-api.jpl.nasa.gov/doc/horizons.html
enum HorizonURL: String, URLConstants {
    case horizonAPI = "api/horizons.api"
    
    var url: String {
        "https://ssd.jpl.nasa.gov/\(self.rawValue)"
    }
    
    var httpMethod: String {
        switch self {
        case .horizonAPI:
            return "GET"
        }
    }
    
    func getEndpoint(with parameters: [String: String]?) -> Endpoint {
        return Endpoint(url: self.url, method: self.httpMethod, queryParameters: parameters)
    }
}
