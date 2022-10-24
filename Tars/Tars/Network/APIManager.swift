//
//  APIManager.swift
//  Tars
//
//  Created by 이윤영 on 2022/10/24.
//

import Foundation

class AstronomyAPIManager: NetworkService {
    func fetchPlanets() async throws -> [Body] {
        let parameters = ["longitude": "-122.406417", "time": "21:42:48", "from_date": "2022-10-24", "elevation": "0.0", "to_date": "2022-10-24", "latitude": "37.785834"]
        let url = AstronomyURL.bodiesPosition
        let endpoint = url.getEndpoint(with: parameters)
        guard let request = endpoint.getURLRequest() else { throw  NetworkError.invalidURL}
        let data: BodiesPositionsResponse = try await getRequest(request)
        print(data.bodiesData)
        return data.bodiesData
    }
}
