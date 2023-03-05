//
//  NetworkService.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

enum NetworkError: Error {
    case invalidResponse
    case invalidURL
    case decodeError
}

protocol NetworkService {}
extension NetworkService {
    func getRequest<D: Decodable>(_ request: URLRequest) async throws -> D {
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        let decodedData = try JSONDecoder().decode(D.self, from: data)
        return decodedData
    }
}
