//
//  Endpoint.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

struct Endpoint {
    var url: String
    var method: String
    var headers: [String: String]?
    var queryParameters: [String: String]?
    
    init(url: String, method: String, headers: [String: String]? = nil, queryParameters: [String: String]? = nil) {
        self.url = url
        self.method = method
        self.headers = headers
        self.queryParameters = queryParameters
    }
    
    func getURLRequest() -> URLRequest? {
        guard var urlComponents = URLComponents(string: url) else { return nil }
        if let queryParameters = queryParameters {
            urlComponents.queryItems = queryParameters.map({ key, value in
                URLQueryItem(name: key, value: value)
            })
        }
        
        guard let url = urlComponents.url else { return nil }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        if let headers = headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        return urlRequest
    }
}
